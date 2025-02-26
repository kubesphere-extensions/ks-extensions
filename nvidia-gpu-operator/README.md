## Functionality

The NVIDIA GPU Operator allows administrators of Kubernetes clusters to manage GPU nodes just like CPU nodes in the cluster. Instead of provisioning a special OS image for GPU nodes, administrators can rely on a standard OS image for both CPU and GPU nodes and then rely on the GPU Operator to provision the required software components for GPUs. Note that the GPU Operator is specifically useful for scenarios where the Kubernetes cluster needs to scale quickly - for example provisioning additional GPU nodes on the cloud or on-prem and managing the lifecycle of the underlying software components. Since the GPU Operator runs everything as containers including NVIDIA drivers, the administrators can easily replace various components - simply by starting or stopping containers.

Kubernetes provides access to special hardware resources such as NVIDIA GPUs, NICs, Infiniband adapters, and other devices through the [device plugin framework](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/). However, configuring and managing nodes with these hardware resources requires configuration of multiple software components such as drivers, container runtimes or other libraries which  are difficult and prone to errors.
The NVIDIA GPU Operator uses the [operator framework](https://cloud.redhat.com/blog/introducing-the-operator-framework) within Kubernetes to automate the management of all NVIDIA software components needed to provision GPU. These components include the NVIDIA drivers (to enable CUDA), Kubernetes device plugin for GPUs, the NVIDIA Container Runtime, automatic node labeling, [DCGM](https://developer.nvidia.com/dcgm) based monitoring and others.


## Installation

1. Go to the **KubeSphere Marketplace** page and find the **NVIDIA GPU Operator** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Configuration

### Deploy **NVIDIA GPU Operator** in Network-Restricted Environments

> Note: The **NVIDIA GPU Operator** extension does not honor the `global.imageRegistry` setting. Follow the steps below for configuration.

First, check your system and kernel versions:

```sh
root@node:/# kubectl get node -o wide
NAME         STATUS   ROLES                         AGE     VERSION    INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
node         Ready    control-plane,master,worker   4d21h   v1.23.17   172.28.0.2    <none>        Ubuntu 22.04.5 LTS   5.15.0-131-generic   docker://24.0.9
```

Next, push the required images to your private registry. 

The driver image version depends on the system and kernel version. For example, if the system is `Ubuntu 22.04` with kernel `5.15.0-131-generic`, the corresponding driver image tag is `5.15.0-131-generic-ubuntu22.04`. Push this image (`nvcr.io/nvidia/driver:5.15.0-131-generic-ubuntu22.04`) to your registry.

Additionally, push the following images to your private registry:

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

Finally, update the extension configuration to replace default image URLs with your private registry paths. For example, if your registry is `dockerhub.kubekey.local/kse`, modify `nvcr.io/nvidia/gpu-operator:v23.9.2` to `dockerhub.kubekey.local/kse/nvidia/gpu-operator:v23.9.2`.

> Note: The `driver.version` field excludes system suffixes.

Sample configuration:

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
    version: 550-5.15.0-131-generic                  # Excludes system suffix
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

### Enable GPU Monitoring with **WizTelemetry Monitoring**

**WizTelemetry Monitoring** includes built-in NVIDIA GPU monitoring. Enable it as follows:

First, install the **WizTelemetry Monitoring** extension **before** the **NVIDIA GPU Operator**. Modify its configuration by setting `whizard-monitoring-helper.gpuMonitoringHelper.enabled` to `true`:

```yaml
whizard-monitoring-helper:
  gpuMonitoringHelper:
    enabled: true      # Enable GPU monitoring in the console
```

Next, update the **NVIDIA GPU Operator** configuration to enable ServiceMonitor:

```yaml
  dcgmExporter:
    enabled: true
    serviceMonitor:
      enabled: true                    # Enable ServiceMonitor
      interval: 15s
      honorLabels: true                # Enable honorLabels
      additionalLabels: {}
      relabelings: []
```

The KubeSphere console will now display NVIDIA GPU metrics.

## Quick Start

### Run a Sample GPU Application

Deploy a simple CUDA workload requesting `nvidia.com/gpu` resources to verify GPU Operator functionality:

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

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **NVIDIA GPU Operator** extension, and click the **Uninstall** button to begin the uninstallation process.


## Documentation

For information on platform support and getting started, visit the official documentation [repository](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html).
