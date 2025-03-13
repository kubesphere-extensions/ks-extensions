- [简介](#简介)
- [使用 ollama 部署](#使用-ollama-部署)
  - [要求和建议](#要求和建议)
  - [基础安装](#基础安装)
  - [资源配置示例](#资源配置示例)
  - [分布式部署](#分布式部署)
- [使用ipex-llm部署](#使用ipex-llm部署)
  - [要求和建议](#要求和建议-1)
  - [基础安装](#基础安装-1)
  - [分布式部署](#分布式部署-1)
- [其他说明](#其他说明)
  - [模型访问](#模型访问)
  - [模型缓存](#模型缓存)

## 简介

该扩展组件用于在 KubeSphere 集群部署 deepseek-r1 模型，并通过 Service 对外提供 API 服务，同时提供 next-chat 作为 web chat UI。    

该组件支持两种部署模式:
- IPEX-LLM: 针对支持 AMX 的 Intel CPU 优化
- Ollama: 适用于通用 CPU 环境

## 使用 ollama 部署

安装时需设置
```yaml
ollama:
  enabled: true
ipex-llm:
  enabled: false
```

### 要求和建议

* 最低资源要求    
  > 针对 deepseek-r1:1.5b 模型, 以下为单个 pod 的最低资源要求，大参数量模型应预留更多资源。    
  
  - 2 核 CPU    
  - 8GB 内存    

* 存储要求    
  
  集群中已设置可用的 StorageClass，主要用于创建 PVC 对模型数据进行持久化存储。建议存储支持 ReadWriteMany 模式，以支持多副本模式运行。    

* GPU 要求    
  > 注意: 小参数量模型可无 GPU 运行，该方式仅限于快速体验和功能测试场景。默认参数部署 deepseek-r1:1.5b 无 GPU 运行。    
  
  集群中规划运行模型的节点上应已经安装了来自对应硬件厂商的 GPU 驱动程序，并运行来自 GPU 厂商的对应设备插件。可参考：[调度 GPU](https://kubernetes.io/zh-cn/docs/tasks/manage-gpus/scheduling-gpus/)    
  
  如果使用 NVIDIA GPU，可在扩展中心中使用 [NVIDIA GPU Operator](https://github.com/kubesphere-extensions/ks-extensions/tree/main/nvidia-gpu-operator) 扩展组件来自动安装设备驱动和插件。    
  
  - NVIDIA驱动 ≥535.86.05    
  - CUDA Toolkit 12.2+    

  检查驱动是否安装：
  ```bash
  # 查看驱动版本
  nvidia-smi --query-gpu=driver_version --format=csv
  # 查看CUDA版本
  nvcc --version
  ```

* 模型仓库要求    
  
  应保证集群可以正常访问 [ollama 模型仓库](https://ollama.com/library)，或本地私有化模型仓库。    
  离线环境且无本地私有模型仓库，可以提前创建包含模型缓存的 PVC，可参考：[缓存模型](#模型缓存)

### 基础安装

默认安装 deepseek-r1:1.5b 模型，如果需要安装其他模型，请修改`global.model`字段。(受限与资源要求，目前仅测试到14b模型)    
支持模型列表：deepseek-r1:1.5b, deepseek-r1:3b, deepseek-r1:7b, deepseek-r1:8b, deepseek-r1:14b, deepseek-r1:32b, deepseek-r1:70b, deepseek-r1:671b
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

### 资源配置示例

部署该扩展组件时，如无指定配置，会根据待安装的模型，自动设置默认的资源请求和限制。   

* 扩展配置：按需启用 Nvidia GPU
```yaml
ollama:
  enableNvidia: true
```

* 扩展配置：可通过以下参数覆盖默认资源请求和限制
```yaml
ollama:
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

### 分布式部署

ollama 不支持模型拆分，每个副本分片都运行完整的模型，采用 service 对请求数据路由到不同的分片。    
修改副本分片配置. 
```yaml
ollama:
  server:
    replicas: 2
```

## 使用ipex-llm部署

ipex-llm 是针对 intel@Advanced Matrix Extensions 的 cpu 进行优化的 vllm 框架
安装时需设置：
```yaml
ollama:
  enabled: false
ipex-llm:
  enabled: true
```

### 要求和建议

* 最低资源要求    
  > 针对 deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B 模型, 以下为单个 pod 的最低资源要求，大参数量模型应预留更多资源。
  - 2 核 CPU（intel@Advanced Matrix Extensions 开启 AMX 支持）    
  - 8GB 内存 
  
  检查是否开启AMX：
  ```bash
  grep enable_cpu_host_passthrough /pitrix/conf/global/server.yaml 
  enable_cpu_host_passthrough: 0
  ```

* 存储要求    
  集群中已设置可用的 StorageClass，主要用于创建 PVC 对模型数据进行持久化存储。建议存储支持 ReadWriteMany 模式，以支持多副本模式运行。  
  
* GPU 要求    
  不建议部署在GPU上

### 基础安装
默认安装 DeepSeek-R1-Distill-Qwen-1.5B 模型，如果需要安装其他模型，请修改`global.model`字段。(受限与资源要求，目前仅测试到14b模型)    
支持模型列表：DeepSeek-R1-Distill-Qwen-1.5B, DeepSeek-R1-Distill-Qwen-3B, DeepSeek-R1-Distill-Qwen-7B, DeepSeek-R1-Distill-Qwen-8B, DeepSeek-R1-Distill-Qwen-14B, DeepSeek-R1-Distill-Qwen-32B, DeepSeek-R1-Distill-Qwen-70B, DeepSeek-R1-Distill-Qwen-671B
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
可通过以下参数覆盖默认资源请求和限制
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

### 分布式部署

ipex-llm 通过启用 ray 集群对模型进行拆分。    
修改副本分片配置：
```yaml
ipex-llm:
  server:
    replicas: 2
```

## 其他说明

### 模型访问

该扩展组件内置 NextChat，可用于UI化模型访问。外部访问是需配置ingress并开启 ingress-controller (推荐使用[KubeSphere 网关](https://github.com/kubesphere-extensions/ks-extensions/tree/main/gateway)扩展组件进行设置)
```yaml
global:
  extension:
    enabled: true # 是否开启ingress   
    ingress:
      ingressClassName: "" # 指定ingressClassName
      domainSuffix: "172.1.1.1.nip.io" # 指定域名后缀
      httpsPort: 443 # 指定https端口, 会覆盖httpPort
      #httpPort: 80 # 指定http端口
```

### 模型缓存

需创建名为 deepseek-models 的 PVC，并将备份的 models 目录导入 PV 中。
ollama: 需在可联网环境从 ollama 拉取模型并备份 models 目录到 PV 的 `ollama` 子目录下
ipex-llm: 需在可联网环境从 Hugging Face 拉取模型并备份 models 目录到 PV 的 `ipex-llm` 子目录下

创建 pvc 用于模型数据持久化存储
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
  - ReadWriteMany  # 需集群中所使用的的存储系统支持 ReadWriteMany 模型，否则设置为 ReadWriteOnce
  resources:
    requests:
      storage: "50Gi"  # 注意根据模型缓存大小设置 pv 大小
# storageClassName: "" # 使用默认 storage class 或指定 storage class
EOF
```