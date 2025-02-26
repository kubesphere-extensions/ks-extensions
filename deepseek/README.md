## Introduction

This extension component runs the deepseek-r1 model based on ollama, provides API services through Service, and includes next-chat as a web chat UI.

## Requirements and Recommendations

* Minimum Resource Requirements

  > For the deepseek-r1:1.5b model, the following are minimum resource requirements per pod. Models with larger parameters should reserve more resources.

  - 2 CPU cores
  - 8GB memory

* Storage Requirements

  A usable StorageClass must be configured in the cluster, mainly used to create PVC for persistent storage of model data. Storage supporting ReadWriteMany mode is recommended to support multi-replica operation.

* GPU Requirements
  > Note: Small parameter models can run without GPU, but this is only for quick experience and functional testing scenarios. The default deployment of deepseek-r1:1.5b runs without GPU.

  Nodes planned for running models in the cluster should have GPU drivers installed from corresponding hardware vendors and run corresponding device plugins from GPU vendors. Reference: [Schedule GPUs](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)

  If using NVIDIA GPU, you can use the [NVIDIA GPU Operator](https://github.com/kubesphere-extensions/ks-extensions/tree/main/nvidia-gpu-operator) extension component in the extension center to automatically install device drivers and plugins.

  - NVIDIA driver ≥535.86.05
  - CUDA Toolkit 12.2+

  Check if drivers are installed:
  ```bash
  # Check driver version
  nvidia-smi --query-gpu=driver_version --format=csv
  # Check CUDA version
  nvcc --version
  ```

* Model Repository Requirements

  Ensure the cluster can normally access the [ollama model repository](https://ollama.com/library), or a local private model repository.

  For offline environments without a local private model repository, you can create a PVC containing model cache in advance. Reference: [Cache Models](#model-cache)

## Deployment Configuration Guide

### Basic Installation
By default, the 1.5b model is installed. If you need to install other models, please modify the `deepseek.model` field. (Limited by resource requirements, currently only tested up to 14b model)    
Supported model list: deepseek-r1:1.5b, deepseek-r1:3b, deepseek-r1:7b, deepseek-r1:8b, deepseek-r1:14b, deepseek-r1:32b, deepseek-r1:70b, deepseek-r1:671b
```yaml
# config.yaml
backend:
  model:
    # registry: "registry.ollama.ai/library"
    # repository: deepseek-r1
    tag:1.5b  # replace with the model version you need
```

### Resource Configuration Example
When deploying this extension component, if no configuration is specified, the default resources will be automatically set according to the model to be installed.
```yaml
backend:
  enableNvidia: true
```

### Extended Configuration
The following parameters can be configured to override the default resource requests and limits.
```yaml
backend:
  server:
    nodeSelector:
      accelerator: nvidia
    resources:
      requests:
        cpu: 1000m 
        memory: 1024Mi 
        nvidia.com/gpu: 1
      limits:
        cpu: 1000m 
        memory: 1024Mi 
        nvidia.com/gpu: 1
```

### Model Access
The extension component includes NextChat, which can be used for UI-based model access. External access requires configuration of ingress (default enabled)
```yaml
global:
  ingress:
    enabled: true # if ingress is enabled
    ingressClassName: "" # specify ingressClassName
    domain: "example.com" # specify domain
    tls: [] # specify tls 
    port: 3000 # specify port
```

### Model Cache
By default, the ollama model cache path is: `$HOME/.ollama/models`

For offline environment deployment, you need to pull the model using ollama in an environment with internet access, back up the models directory and copy it to the offline environment. At the same time, create a PVC named deepseek-models and import the backed up models directory into the PV.

Create a PVC for model data persistent storage:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: extension-deepseek
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: deepseek-models
  namespace: extension-deepseek
spec:
  accessModes:
  - ReadWriteMany  # The storage system used in the cluster needs to support ReadWriteMany mode, otherwise set it to ReadWriteOnce
  resources:
    requests:
      storage: "50Gi"  # Note: Set PV size according to model cache size
# storageClassName: "" # Use default storage class or specify storage class
EOF
```