## 功能

NVIDIA GPU Operator 允许 Kubernetes 集群的管理员像管理集群中的 CPU 节点一样管理 GPU 节点。管理员不需要为 GPU 节点提供特定的操作系统镜像，而是可以依赖于 CPU 和 GPU 节点的标准操作系统镜像，然后依赖 GPU Operator 来提供 GPU 所需的软件组件。需要注意的是，GPU Operator 特别适用于 Kubernetes 集群需要快速扩展的场景，例如在云端或本地增加 GPU 节点并管理底层软件组件的生命周期。由于 GPU Operator 将所有内容都作为容器运行，包括 NVIDIA 驱动程序，管理员可以轻松更换各种组件——只需启动或停止容器即可。

Kubernetes 通过 [device plugin framework](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/) 提供对 NVIDIA GPU、NIC、Infiniband 适配器和其他设备等特殊硬件资源的访问。然而，配置和管理这些硬件资源节点需要配置多个软件组件，如驱动程序、容器运行时或其他库，这些过程既复杂又容易出错。NVIDIA GPU Operator 在 Kubernetes 中使用 [operator framework](https://cloud.redhat.com/blog/introducing-the-operator-framework) 自动管理提供 GPU 所需的所有 NVIDIA 软件组件。这些组件包括启用 CUDA 的 NVIDIA 驱动程序、用于 GPU 的 Kubernetes 设备插件、NVIDIA 容器运行时、自动节点标记、基于 [DCGM](https://developer.nvidia.com/dcgm) 的监控等。


## 安装

1. 通过 **扩展市场** 页面找到 **NVIDIA GPU Operator** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，开始安装；
3. 安装完成后，点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面；
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

## 配置

### 在网络受限环境下部署 **NVIDIA GPU Operator** 扩展组件

> 注意：**NVIDIA GPU Operator** 扩展不遵从 `global.imageRegistry` 全局镜像设置，您需要进行如下配置。

首先，确认系统及内核版本。

```sh
root@node:/# kubectl get node -o wide
NAME         STATUS   ROLES                         AGE     VERSION    INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
node         Ready    control-plane,master,worker   4d21h   v1.23.17   172.28.0.2    <none>        Ubuntu 22.04.5 LTS   5.15.0-131-generic   docker://24.0.9
```

然后，推送相关镜像至您的本地私有镜像仓库。

扩展组件安装时，驱动的镜像版本与系统及内核版本有关，如当前系统为 `Ubuntu 22.04`， 内核版本为 `5.15.0-131-generic`，则对应镜像的 tag 为 `5.15.0-131-generic-ubuntu22.04`， 驱动镜像为 `nvcr.io/nvidia/driver:5.15.0-131-generic-ubuntu22.04`，请将该驱动推送至本地私有镜像仓库。

并且，将以下镜像推送至您的本地私有镜像仓库。

```txt
docker.io/kubesphere/node-feature-discovery:v0.14.2
nvcr.io/nvidia/cloud-native/dcgm:3.3.0-1-ubuntu22.04
nvcr.io/nvidia/cloud-native/gpu-operator-validator:v23.9.2
nvcr.io/nvidia/cloud-native/k8s-cc-manager:v0.1.1
nvcr.io/nvidia/cloud-native/k8s-driver-manager:v0.6.5
nvcr.io/nvidia/cloud-native/k8s-kata-manager:v0.1.2
nvcr.io/nvidia/cloud-native/k8s-mig-manager:v0.6.0-ubuntu20.04
nvcr.io/nvidia/cloud-native/vgpu-device-manager:v0.2.4
nvcr.io/nvidia/cuda:12.3.2-base-ubi8
nvcr.io/nvidia/gpu-feature-discovery:v0.8.2-ubi8
nvcr.io/nvidia/gpu-operator:v23.9.2
nvcr.io/nvidia/k8s-device-plugin:v0.14.5-ubi8
nvcr.io/nvidia/k8s/container-toolkit:v1.14.6-ubuntu20.04
nvcr.io/nvidia/k8s/dcgm-exporter:3.3.0-3.2.0-ubuntu22.04
nvcr.io/nvidia/kubevirt-gpu-device-plugin:v1.2.4
```

最后，修改扩展组件配置，将多个默认镜像地址替换为本地镜像仓库地址。假如本地镜像仓库地址为 `dockerhub.kubekey.local/kse`，需将默认镜像地址，如 `nvcr.io/nvidia/gpu-operator:v23.9.2` 修改为 `dockerhub.kubekey.local/kse/nvidia/gpu-operator:v23.9.2`。

> 注意：驱动镜像 `driver.version` 字段不包含系统后缀。

扩展组件配置参考如下：

```yaml
gpu-operator:
  validator:
    image: gpu-operator-validator
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  operator:
    repository: dockerhub.kubekey.local/kse/nvidia
    image: gpu-operator
    initContainer:
      image: cuda
      repository: dockerhub.kubekey.local/kse/nvidia
  driver:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia
    version: 550-5.15.0-131-generic                  # version 不含系统后缀
    manager:
      image: k8s-driver-manager
      repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  toolkit:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia/k8s
    image: container-toolkit
  devicePlugin:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia
    image: k8s-device-plugin
  dcgm:
    enabled: false
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  dcgmExporter:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia/k8s
    image: dcgm-exporter
  gfd:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia
    image: gpu-feature-discovery
  migManager:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
    image: k8s-mig-manager
  nodeStatusExporter:
    enabled: false
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
    image: gpu-operator-validator
  gds:
    enabled: false
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  vgpuManager:
    enabled: false
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
    driverManager:
      repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  vgpuDeviceManager:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  kataManager:
    enabled: false
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  vfioManager:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia
    driverManager:
      repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  sandboxDevicePlugin:
    enabled: true
    repository: dockerhub.kubekey.local/kse/nvidia
  ccManager:
    enabled: false
    repository: dockerhub.kubekey.local/kse/nvidia/cloud-native
  node-feature-discovery:
    image:
      repository: dockerhub.kubekey.local/kse/kubesphere/node-feature-discovery
```

### 结合 **WizTelemetry 监控** 扩展组件， 启用 GPU 监控

**WizTelemetry 监控** 内置 Nvidia GPU 监控，您可以通过如下配置进行启用。

首先，**WizTelemetry 监控** 扩展组件应先于 **NVIDIA GPU Operator** 安装，并修改 **WizTelemetry 监控** 扩展组件配置，将 `whizard-monitoring-helper.gpuMonitoringHelper.enabled` 设置为 `true`，保存并更新配置，开始安装。

```yaml
whizard-monitoring-helper:
  gpuMonitoringHelper:
    enabled: false      ## set true to enable gpu monitoring in console
```

然后，修改 **NVIDIA GPU Operator** 扩展组件配置， 将 `dcgmExporter.serviceMonitor.enabled` 和 `dcgmExporter.serviceMonitor.honorLabels` 设置为 `true`，保存并更新配置，开始安装。

```
  dcgmExporter:
    enabled: true
    serviceMonitor:
      enabled: false                    ## set true to enable serviceMonitor
      interval: 15s
      honorLabels: false                ## set true
      additionalLabels: {}
      relabelings: []
```

至此，KubeSphere 控制台将展示 NVIDIA GPU 监控信息。

## 快速入门

### 运行示例 GPU 应用程序

以下将运行一个简单的 CUDA 示例，它在部署时申请调度 `nvidia.com/gpu`，Pod 正常运行即可表示 **NVIDIA GPU Operator** 完成部署，GPU 资源可正常调度。

```sh
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: cuda-vectoradd
spec:
  restartPolicy: OnFailure
  containers:
  - name: cuda-vectoradd
    image: "nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda11.7.1-ubuntu20.04"
    resources:
      limits:
        nvidia.com/gpu: 1
EOF
```

## 卸载

通过 **扩展市场** 页面找到 **NVIDIA GPU Operator** 扩展，选择已安装的版本，点击 **卸载** 按钮，开始卸载。


## 产品文档

有关平台支持和入门信息，请访问[官方文档库](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html)。
