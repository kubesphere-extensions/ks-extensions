## Installation

1. Go to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Monitoring** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Quick Start

Once installed, the left navigation pane for clusters and projects displays **Monitoring & Alerting**, where you can view the cluster status, application resources, and customize monitoring dashboards. Services under application workloads in clusters and projects support **Edit Monitoring Exporter**.

Many pages under clusters, workspaces, and projects, such as the Overview page, the details page of Workloads, Jobs, Pods, Services, and Persistent Volume Claims, also display data for relevant monitoring metrics.

## Configuration

### 1. Enable Etcd Monitoring

1. Create the Etcd client certificate key.

   ```sh
    kubectl -n kubesphere-monitoring-system create secret generic kube-etcd-client-certs  \
    --from-file=etcd-client-ca.crt=/etc/ssl/etcd/ssl/ca.pem  \
    --from-file=etcd-client.crt=/etc/ssl/etcd/ssl/node-$(hostname).pem  \
    --from-file=etcd-client.key=/etc/ssl/etcd/ssl/node-$(hostname)-key.pem
    ```

2. Modify the **Extension Config** and include the following section. Save and update the configuration, then start the installation.

    Set `whizard-monitoring-helper.etcdMonitoringHelper.enabled` to `true`

    ```yaml
    whizard-monitoring-helper:
      etcdMonitoringHelper:
        enabled: true
    ```

    Modify the **cluster Agent configuration** and add the following content. Note that the Etcd endpoints correspond to the clusters respectively.

    ```yaml
    kube-prometheus-stack:
      prometheus:
        prometheusSpec:
          secrets:
            - kube-etcd-client-certs  ## be added when enable kubeEtcd servicemonitor with tls config

      kubeEtcd:
        enabled: true ## set true to enable etcd monitoring
        endpoints: 
         - 172.31.73.206 ## add etcd endpoints
    ```

### 2. Enable GPU Monitoring

> GPU monitoring requires the installation of `GPU drivers` and [configuring CRI](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) on the nodes, as well as deploying the corresponding [device-plugin](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/#examples) in the cluster; or you can use [gpu-operator](https://github.com/NVIDIA/gpu-operator) to create, configure, and manage GPUs on Kubernetes.
>
> Note: The WhizardTelemetry Monitoring includes a built-in dcgm-exporter (not enabled by default) that enhances the default GPU monitoring metrics and functionalities. This exporter is similar to the `dcgm-exporter` deployed by the `gpu-operator`. You only need to enable one of them (to avoid conflict) to export GPU monitoring metrics.
>
> 1. If you have deployed `dcgm-exporter` with `gpu-operator`, after completing the deployment of WhizardTelemetry monitoring, please use `helm` to update or redeploy [gpu-operator] and add the `--set dcgmExporter.serviceMonitor.enabled=true` parameter. Do not enable the built-in `dcgm-exporter` to avoid conflicts.
>
> 2. If you are using the built-in `dcgm-exporter` on top of the `gpu-operator` deployment, please use `helm` to update or redeploy `gpu-operator` and add the `--set dcgmExporter.enabled=false` parameter. Set the `dcgmExporter.enabled` configuration in the `extension components` to `true` to enable the built-in installation.

Modify the `Extension Config` and set `whizard-monitoring-helper.gpuMonitoringHelper.enabled` and `dcgmExporter.enabled` to `true`. Save and update the configuration, then start the installation.

```yaml
whizard-monitoring-helper:
  gpuMonitoringHelper:
    enabled: false

dcgmExporter:
  enabled: false
```

### 3. Compatibility Support

The **WhizardTelemetry Monitoring** extension provides compatibility support for **Kubernetes v1.19** and above versions. Due to the evolution and deprecation of the [Kubernetes API](https://kubernetes.io/zh-cn/docs/reference/using-api/deprecation-guide/), some components such as [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics?tab=readme-ov-file#compatibility-matrix) need to be manually configured to be compatible with different versions of Kubernetes.

```yaml
kube-prometheus-stack:
  kube-state-metrics:
    collectors:     # remove cronjobs, poddisruptionbudgets when k8s version < 1.21, remove horizontalpodautoscalers when k8s version < 1.23
    - certificatesigningrequests
    - configmaps
    # - cronjobs
    - daemonsets
    - deployments
    - endpoints
    # - horizontalpodautoscalers
    - ingresses
    - jobs
    - leases
    - limitranges
    - mutatingwebhookconfigurations
    - namespaces
    - networkpolicies
    - nodes
    - persistentvolumeclaims
    - persistentvolumes
    # - poddisruptionbudgets
    - pods
    - replicasets
    - replicationcontrollers
    - resourcequotas
    - secrets
    - services
    - statefulsets
    - storageclasses
    - validatingwebhookconfigurations
    - volumeattachments
```

### 4. Customizing kube-prometheus-stack Configuration

If users need to modify the configuration of kube-prometheus-stack, they can refer to [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) and values.yaml for modification.


## Uninstallation

To uninstall, go to the **KubeSphere Marketplace** page, find the **WhizardTelemetry Monitoring** extension, select the installed version, and click the **Uninstall** button to start the uninstallation process. Please note that during the uninstallation process, all monitoring resources will be deleted, but the CRD (Custom Resource Definition) and PVC (Persistent Volume Claim) will be retained. If needed, please manually delete those parts.
