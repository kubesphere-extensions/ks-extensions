<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.2

### Enhancements

- Improve user experience on the Gateway Settings page.

### Bug Fixes

- Fix the issue where all gateways of the cluster are displayed in the kubesphere-system namespace.
- Fix the issue where all gateways use the same lease, resulting in only one gateway running.
- Fix the issue where ingress-nginx cannot use global image configuration.
- Fix the issue where multiple project gateways selecting the master lead to the inability to update the ingress loadBalancer IP.

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