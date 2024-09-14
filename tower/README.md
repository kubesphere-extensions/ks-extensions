# KubeSphere Multi-Cluster Agent Connection

The component [Tower](https://github.com/kubesphere/tower) of KubeSphere is used for agent connection. Tower is a tool for network connection between clusters through the agent. If the host cluster cannot access the member cluster directly, you can expose the proxy service address of the host cluster. This enables the member cluster to connect to the host cluster through the agent. This method is applicable when the member cluster is in a private environment (for example, IDC) and the host cluster is able to expose the proxy service. The agent connection is also applicable when your clusters are distributed across different cloud providers.

## Set the Proxy Service Address

After the installation of the tower extension, a proxy service called `tower` will be created in `kubesphere-system`, whose type is `LoadBalancer`.

### A LoadBalancer available in your cluster

If a LoadBalancer plugin is available for the cluster, you can see a corresponding address for `EXTERNAL-IP` of tower, which will be acquired by KubeSphere. In this case, the proxy service is set automatically. That means you can skip the step to set the proxy. Execute the following command to verify if you have a LoadBalancer.

```bash
kubectl -n kubesphere-system get svc
```

The output is similar to this:

```shell
NAME       TYPE            CLUSTER-IP      EXTERNAL-IP     PORT(S)              AGE
tower      LoadBalancer    10.233.63.191   139.198.110.23  8080:30721/TCP       16h
```

Generally, there is always a LoadBalancer solution in the public cloud, and the external IP can be allocated by the load balancer automatically. If your clusters are running in an on-premises environment, especially a **bare metal environment**, you can use [OpenELB](https://github.com/kubesphere/openelb) as the LB solution.

### No LoadBalancer available in your cluster

1. Run the following command to check the service:

    ```shell
    kubectl -n kubesphere-system get svc
    ```

   In this sample, `NodePort` is `30721`.
    ```
    NAME       TYPE            CLUSTER-IP      EXTERNAL-IP     PORT(S)              AGE
    tower      LoadBalancer    10.233.63.191   <pending>       8080:30721/TCP       16h
    ```

2. If `EXTERNAL-IP` is `pending`, you need to manually set the proxy address. For example, if your public IP address is `139.198.120.120`, you need to expose port (for example, `30721`) of this public IP address to `NodeIP`:`NodePort`.

3. Add the value of `proxyPublishAddress` to the `kubesphere-config` ConfigMap and provide the public IP address (`139.198.120.120` in this tutorial) and port number as follows.

   ```bash
   kubectl -n kubesphere-system edit cm kubesphere-config
   ```

   Navigate to `multicluster` and add a new line for `proxyPublishAddress` to define the IP address to access tower.

   ```yaml
   multicluster:
     clusterRole: host
     proxyPublishAddress: http://139.198.120.120:{NodePort} # Add this line to set the address to access tower
   ```

   In the YAML file, you need to replace `NodePort` with the port ID you specified in Step 2.

## Custom agent image

By default, you do not need to set it. If there are some special scenarios where you need to configure the image used by the agent, you can set the `agentImage` field in the `kubesphere-config` ConfigMap:

```yaml
multicluster:
  clusterRole: host
  proxyPublishAddress: ...
  agentImage: kubesphere/tower:v0.2.1
```
