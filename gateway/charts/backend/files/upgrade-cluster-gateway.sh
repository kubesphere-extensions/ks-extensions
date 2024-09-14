#！ /bin/bash
set -e

cache_path=$1
new_cluster_gw=$(yq e '.metadata.name' override.yaml)
if [ -z "$cache_path" ]; then
  echo "Need parameter: cache_path"
  exit 1
fi

function upgrade_cluster_gateway() {
    cluster_gw=$(kubectl get gateways.gateway.kubesphere.io -l kubesphere.io/gateway-type=cluster -n kubesphere-controls-system --no-headers -o custom-columns=NAME:.metadata.name)
    if [ -z "$cluster_gw" ]; then
      echo "No cluster gateway was created, exit"
      return 0
    elif [ ${#cluster_gw[@]} -ne 1 ]; then
      echo "Incorrect number of cluster gateways, should 1, got ${#cluster_gw[@]}"
      return 1

    elif [ "$cluster_gw" = "$new_cluster_gw" ]; then
      echo "No need to upgrade"
      return 0
    fi

    kubectl get gateway.gateway.kubesphere.io "$cluster_gw" -n kubesphere-controls-system -oyaml > "$cache_path"/old-cluster-gateway.yaml
    gw_class_name=$(kubectl get gateway.gateway.kubesphere.io "$cluster_gw" -n kubesphere-controls-system -o jsonpath='{.spec.values.controller.ingressClassResource.name}')

    cluster_gateway_file="$cache_path"/cluster-gateway.yaml

    yq eval-all 'select(fileIndex == 0) *+ select(fileIndex == 1)'  "$cache_path"/old-cluster-gateway.yaml override.yaml > "$cluster_gateway_file"


    gw_service=$(kubectl get service -n kubesphere-controls-system "$cluster_gw" -o json)

    # shellcheck disable=SC1073
    # shellcheck disable=SC2046
    # shellcheck disable=SC2154
    if [ $(echo "$gw_service" | jq -r .spec.type) = "NodePort" ]; then
      node_port_http=$(echo "$gw_service" | jq -r '.spec.ports[] | select(.name=="http") | .nodePort')
      node_port_https=$(echo "$gw_service" | jq -r '.spec.ports[] | select(.name=="https") | .nodePort')
      yq eval ".spec.values.controller.service.nodePorts.http = $node_port_http" -i "$cluster_gateway_file"
      yq eval ".spec.values.controller.service.nodePorts.https = $node_port_https" -i "$cluster_gateway_file"
    fi

    echo "--- Cleaning old cluster gateways ---"
    kubectl delete gateway.gateway.kubesphere.io "$cluster_gw" -n kubesphere-controls-system

    echo "--- Creating new cluster gateway ---"
    # apply new cluster gateway
    kubectl apply -f "$cluster_gateway_file"

    echo "--- Updating ingresses which using cluster gateway ---"
    # replace ingress ingressClassName which using cluster gateway
    ingresses=$(kubectl get ingress --all-namespaces -o json)

    filtered_ingresses=$(echo "$ingresses" | jq --arg gw_class_name "$gw_class_name" -c '
        [.items[] |
        select(.spec.ingressClassName == $gw_class_name) |
        {namespace: .metadata.namespace, name: .metadata.name}]
    ')

    if [ "$(echo "$filtered_ingresses" | jq '. | length')" -eq 0 ]; then
        echo "No matching ingresses found, exiting."
        return 0
    fi

    echo "$filtered_ingresses" | jq -c '.[]' | while read -r ingress; do
        namespace=$(echo "$ingress" | jq -r '.namespace')
        name=$(echo "$ingress" | jq -r '.name')

        echo "Patching ingress $name in namespace $namespace"

        kubectl patch ingress "$name" -n "$namespace" --type='json' -p="[{'op': 'replace', 'path': '/spec/ingressClassName', 'value': '$new_cluster_gw'}]"
    done
}

echo "--- Starting upgrade cluster gateway ---"
echo "Read from override.yaml, the new cluster gateway: $new_cluster_gw"

# shellcheck disable=SC2218
upgrade_cluster_gateway

if [[ $? -eq 1 ]]; then
    exit 1
fi

echo "--- Updating nginx-ingress-controller electionID ---"
kubectl get gateways.gateway.kubesphere.io -n kubesphere-controls-system --no-headers -o custom-columns=NAME:.metadata.name | \
xargs -I {} kubectl patch gateways.gateway.kubesphere.io {} -n kubesphere-controls-system \
--type merge -p "{\"spec\":{\"values\":{\"controller\":{\"electionID\":\"{}\"}}}}"

echo "--- Completed ---"
