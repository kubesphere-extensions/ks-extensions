<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.3 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.4

### 优化

- 升级 ingress-nginx 版本到 4.12.1

## v1.0.3

### 优化

- 升级 ingress-nginx 版本到 4.10.3

### 缺陷修复

- 修复网关输出异常日志的问题
- 修复网关监控无法显示平均延迟的问题


<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.2

### 优化

- 网关设置页面用户体验优化

### 缺陷修复

- 修复在 kubesphere-system 命名空间显示了集群中的所有网关
- 修复所有网关使用同一个 lease，导致只有一个网关运行
- 修复 ingress-nginx 无法使用全局镜像配置的问题
- 修复多个项目网关选主导致 ingress loadBalancer IP 无法更新的问题

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0
- 基于全新的微内核架构 KubeSphere LuBan 重构
- 屏蔽底层配置细节，支持一键启用网关
- 集成 WhizardTelemetry 监控模块
- 集成 WhizardTelemetry 日志模块
- 支持更细粒度的权限配置，包含网关管理与查看

### 新特性
- 支持通过全新微内核架构 KubeSphere LuBan 热插拔
- 调整了 KubeSphere 网关的架构，便于解耦不同厂商的网关
- 整合了 KubeSphere 网关创建、编辑时的配置步骤
- 通过编辑网关 YAML 管理网关 values 中所有配置项
- 可配置通过 NodePort 对外暴露时展示网关地址
- 支持更细粒度的权限配置

### 弃用
- 移除了 Gateway v1alpha1 CRD
- 移除了 Nginx v1alpha1 CRD

### API 更新
- 新增了 Gateway v2alpha1 CRD

### 优化
- 简化了 KubeSphere 网关扩展组件的安装操作

### 缺陷修复
- 修复了网关日志导出异常的 bug

### 其他
- nginx-ingress 版本：v1.3.1 -> v1.4.0