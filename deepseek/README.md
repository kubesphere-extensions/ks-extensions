- [Introduction](#introduction)
- [Deploy with Ollama](#deploy-with-ollama)
  - [Requirements and Recommendations](#requirements-and-recommendations)
  - [Basic Installation](#basic-installation)
  - [Resource Configuration Example](#resource-configuration-example)
  - [Distributed Deployment](#distributed-deployment)
- [Using ipex-llm Deployment](#using-ipex-llm-deployment)
  - [Requirements and Recommendations](#requirements-and-recommendations-1)
  - [Basic Installation](#basic-installation-1)
  - [Distributed Deployment](#distributed-deployment-1)
- [Other Notes](#other-notes)
  - [Model Access](#model-access)
  - [Model Cache](#model-cache)

## Introduction

This extension component runs the DeepSeek-R1 model in KubeSphere, provides API services through Service, and includes NextChat as a web chat UI.

The component supports two deployment modes:
- IPEX-LLM: Optimized for Intel CPUs with AMX support
- Ollama: For general CPU environments

## Deploy with Ollama

Set the following when installing:
```yaml
ollama:
  enabled: true
ipex-llm:
  enabled: false
```

### Requirements and Recommendations

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

### Basic Installation

By default, the deepseek-r1:1.5b model is installed. If you need to install other models, please modify the `global.model` field. (Limited by resource requirements, currently only tested up to 14b model)    
Supported model list: deepseek-r1:1.5b, deepseek-r1:3b, deepseek-r1:7b, deepseek-r1:8b, deepseek-r1:14b, deepseek-r1:32b, deepseek-r1:70b, deepseek-r1:671b
```yaml
global:
  model:
    # the full path in models directory
    # in ollama
    id: "registry.ollama.ai/library/deepseek-r1:1.5b"
    # in vllm
    # id: "deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"
    # the serve name to access.
    # in ollama
    name: "deepseek-r1:1.5b"
    # in vllm
    # name: "DeepSeek-R1-Distill-Qwen-1.5B"
```

### Resource Configuration Example

When deploying this extension component, if no configuration is specified, the default resources will be automatically set according to the model to be installed.

* Extended Configuration: Enable Nvidia GPU as needed:
```yaml
ollama:
  enableNvidia: true
```

* Extended Configuration: The following parameters can be configured to override the default resource requests and limits.
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

### Distributed Deployment

Ollama does not support model sharding. Each replica shard runs a complete model, using service to route request data to different shards.
Modify replica shard configuration:
```yaml
ollama:
  server:
    replicas: 2
```

## Using ipex-llm Deployment

ipex-llm is a vllm framework optimized for intel@Advanced Matrix Extensions CPUs.
When installing, you need to set:
```yaml
ollama:
  enabled: false
ipex-llm:
  enabled: true
```

### Requirements and Recommendations

* Minimum Resource Requirements    
  > For the DeepSeek-R1-Distill-Qwen-1.5B model, the following are the minimum resource requirements for a single pod. Models with larger parameters should reserve more resources.
  - 2 CPU cores (intel@Advanced Matrix Extensions with AMX support enabled)    
  - 8GB memory 
  
  Check if AMX is enabled:
  ```bash
  grep enable_cpu_host_passthrough /pitrix/conf/global/server.yaml 
  enable_cpu_host_passthrough: 0
  ```

* Storage Requirements    
  The cluster should have an available StorageClass configured, mainly used to create PVCs for persistent storage of model data. Storage that supports ReadWriteMany mode is recommended to support multi-replica operation.  
  
* GPU Requirements    
  Not recommended for deployment on GPU

### Basic Installation
By default, the DeepSeek-R1-Distill-Qwen-1.5B model is installed. If you need to install other models, please modify the `global.model` field. (Due to resource requirements, currently only tested up to 14b models)    
Supported model list: DeepSeek-R1-Distill-Qwen-1.5B, DeepSeek-R1-Distill-Qwen-3B, DeepSeek-R1-Distill-Qwen-7B, DeepSeek-R1-Distill-Qwen-8B, DeepSeek-R1-Distill-Qwen-14B, DeepSeek-R1-Distill-Qwen-32B, DeepSeek-R1-Distill-Qwen-70B, DeepSeek-R1-Distill-Qwen-671B
```yaml
global:
  model:
    # the full path in models directory
    # in ollama
    # id: "registry.ollama.ai/library/deepseek-r1:1.5b"
    # in vllm
    id: "deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"
    # the serve name to access.
    # in ollama
    # name: "deepseek-r1:1.5b"
    # in vllm
    name: "DeepSeek-R1-Distill-Qwen-1.5B"
```
You can override default resource requests and limits with the following parameters:
```yaml
ipex-llm:
  server:
    ray:
      resources:
        requests:
          cpu: 1
          memory: 2Gi
        limits:
          cpu: 2
          memory: 4Gi  
    llm:
      resources:
        requests:
          cpu: 4
          memory: 8Gi
        limits:
          cpu: 8
          memory: 16Gi     
```

### Distributed Deployment

ipex-llm splits the model by enabling the ray cluster.    
Modify replica shard configuration:
```yaml
ipex-llm:
  server:
    replicas: 2
```

## Other Notes

### Model Access

This extension component includes NextChat, which can be used for UI-based model access. External access requires configuring ingress and enabling ingress-controller (it is recommended to use the [KubeSphere Gateway](https://github.com/kubesphere-extensions/ks-extensions/tree/main/gateway) extension component for setup)
```yaml
global:
  extension:
    enabled: true # if ingress is enabled
    ingress:
      ingressClassName: "" # specify ingressClassName
      domainSuffix: "172.1.1.1.nip.io" # specify domain suffix
      httpsPort: 443 # specify https port, will override httpPort
      #httpPort: 80 # specify http port
```

### Model Cache

You need to create a PVC named deepseek-models and import the backed up models directory into the PV.
ollama: In an environment with internet access, pull the model from ollama and back up the models directory to the `ollama` subdirectory in the PV
ipex-llm: In an environment with internet access, pull the model from Hugging Face and back up the models directory to the `ipex-llm` subdirectory in the PV

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