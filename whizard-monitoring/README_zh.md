## 安装

1. 通过 **扩展市场** 页面找到 **WhizardTelemetry 监控** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，开始安装；
3. 安装完成后，点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面；
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

## 快速开始

安装完成后，集群和项目的左侧导航栏将显示**监控告警**，可查看集群状态、应用资源，并自定义监控面板。集群和项目中应用负载下的服务将支持**编辑监控导出器**。

集群、企业空间、项目下的很多页面，如概览、工作负载、任务、容器组、服务、持久卷声明的详情页，也将显示相关监控指标的数据。


## 配置

### 1. 启用 Etcd 监控

1. 创建 Etcd 客户端证书密钥

   ```sh
    kubectl -n kubesphere-monitoring-system create secret generic kube-etcd-client-certs  \
    --from-file=etcd-client-ca.crt=/etc/ssl/etcd/ssl/ca.pem  \
    --from-file=etcd-client.crt=/etc/ssl/etcd/ssl/node-$(hostname).pem  \
    --from-file=etcd-client.key=/etc/ssl/etcd/ssl/node-$(hostname)-key.pem
    ```

2. 修改 **扩展组件配置**，包含以下部分，保存并更新配置后，开始安装

    将 `whizard-monitoring-helper.enabledEtcdMonitoring.enabled` 设置为 `true`

    ```yaml
    whizard-monitoring-helper:
      etcdMonitoringHelper:
        enabled: true
    ```

    修改 **集群 Agent 配置**，在 **差异化配置** 增加如下内容，注意 Etcd 端点分别与各自集群对应

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

### 2. 启用 GPU 监控

> GPU 监控需要在节点上安装 `GPU 驱动`、 [配置 CRI](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) 及在集群中部署对应 [device-plugin](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/#examples)； 或您也可以使用 [gpu-operator](https://github.com/NVIDIA/gpu-operator) 在 Kubernetes 上创建、配置、管理 GPU。
>
> 注: **WhizardTelemetry 监控**内置了 `dcgm-exporter`（默认没有启用），内置的 `dcgm-exporter` 会增强默认 GPU 监控指标等功能。这个 exporter 与某些用户通过 `gpu-operator` 部署的 `dcgm-exporter` 为相同服务且彼此冲突，仅需启用其中之一即可导出 GPU 监控指标。
>
> 1. 如果您已经使用 `gpu-operator` 部署了 `dcgm-exporter`，就无需启用本扩展组件内置的 `dcgm-exporter` 以避免冲突。
>
> 2. 如果您计划使用本扩展组件内置的`dcgm-exporter`，需设置`扩展组件配置`的`dcgmExporter.enabled` 为 `true`。如果您已经安装了 `gpu-operator` ，请在启用本扩展组件内置的`dcgm-exporter` 之前，使用 `helm` 更新 `gpu-operator` 并增加 `--set dcgmExporter.enabled=false` 参数以确保不启动 `gpu-operator` 自带的`dcgm-exporter`

修改 `扩展组件配置`，将 `whizard-monitoring-helper.enabledGPUMonitoring.enabled` 及 `dcgmExporter.enabled` 设置为 `true`，保存并更新配置，开始安装。

```yaml
whizard-monitoring-helper:
  gpuMonitoringHelper:
    enabled: false      ## set true to enable gpu monitoring in console

dcgmExporter:
  enabled: false        ## set true to deploy dcgm-exporter
  nodeSelector: {}      ## set nodeSelector to deploy dcgm-exporter
```

### 3. 兼容性支持

**WhizardTelemetry 监控** 扩展组件提供 **Kubernetes v1.19** 及以上版本兼容性支持； 由于 [kubernetes API 的演化与弃用](https://kubernetes.io/zh-cn/docs/reference/using-api/deprecation-guide/)，部分组件如 [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics?tab=readme-ov-file#compatibility-matrix) 需要手动配置以兼容不同版本的 Kubernetes。

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

### 4. 单独部署 cadvisor 配置

适用于在 k8s 1.24 及以上版本仍然使用 Docker Engine 的场景。

> k8s 1.24 开始不再原生支持 docker 运行时, 通常可选择 cri-dockerd 提供适配支持。但 kubelet 不再支持提供 docker 运行时的容器指标。

修改扩展组件配置，以部署单独的 cadvisor 组件，从该组件采集容器指标。同时禁用从 kubelet 采集 cadvisor 暴露的指标。

```yaml
kube-prometheus-stack:

  kubelet:
    serviceMonitor:
      cAdvisor: false

cadvisor:
  enabled: true
```

### 5. kube-prometheus-stack 自定义配置

如用户需要修改 kube-prometheus-stack 的配置， 可参考 [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) 及 values.yaml 进行修改。

## 卸载

通过 **扩展市场** 页面找到 **WhizardTelemetry 监控**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。 需要注意的是，卸载过程中会删除所有监控资源，但会保留其 CRD 与 PVC，如有需求请手动删除该部分。
