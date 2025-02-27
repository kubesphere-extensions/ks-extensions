## 简介

该扩展组件基于 ollama 运行 deepseek-r1 模型，并通过 Service 对外提供 API 服务，同时提供 next-chat 作为 web chat UI。

## 要求和建议
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

## 部署配置说明

### 基础安装
默认安装1.5b模型，如果需要安装其他模型，请修改`deepseek.model`字段。(受限与资源要求，目前仅测试到14b模型)    
支持模型列表：deepseek-r1:1.5b, deepseek-r1:3b, deepseek-r1:7b, deepseek-r1:8b, deepseek-r1:14b, deepseek-r1:32b, deepseek-r1:70b, deepseek-r1:671b
```yaml
# config.yaml
backend:
  model:
    # registry: "registry.ollama.ai/library"
    # repository: deepseek-r1
    tag:1.5b  # 按需替换模型版本
```

### 资源配置示例
部署该扩展组件时，如无指定配置，会根据待安装的模型，自动设置默认的资源请求和限制。
```yaml
backend:
  enableNvidia: true
```
扩展配置：可通过以下参数覆盖默认资源请求和限制
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

### 模型访问
该扩展组件内置 NextChat，可用于UI化模型访问。外部访问是需配置ingress并开启ingress-controller(推荐使用gateway扩展组件进行设置)
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
默认情况下，ollama 模型的缓存路径：`$HOME/.ollama/models`

离线环境部署时，需在可联网环境利用 ollama 拉取模型并备份 models 目录拷贝至离线环境中，同时创建名为 deepseek-models 的 PVC，并将备份的 models 目录导入 PV 中。

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