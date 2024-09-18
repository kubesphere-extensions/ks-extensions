<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.0.3

### 优化

- 基于 Node Exporter 指标的告警消息移除了 namespace, pod 等标签，它们与节点告警无关

### 缺陷修复

- 修复未安装告警组件的集群仍显示组件入口的问题

### 其他

- 升级 thanos 至 v0.36.1

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0

**WhizardTelemetry 告警** 是 WhizardTelemetry 可观测平台中基于监控指标进行告警的扩展组件，提供多集群的规则组管理、评估和告警等功能。

可通过该扩展组件部署与管理如下组件：

- apiserver：提供规则组和告警的相关 APIs。
- controller-manager: 提供规则组的同步管理等功能。
- ruler: 负责规则组的规则评估和告警功能。

与 KSE v3.5 相比，该扩展组件还从架构设计上对多集群告警的流程以及轻量化方面进行了显著优化。

### API 更新

与 KSE 3.5 相比，API 更新主要体现在请求路径的变更上：

- 集群级别和项目级别的规则组和告警，API 路径前缀由 `[apis|kapis]/clusters/{cluster}/alerting.kubesphere.io/v2beta1/**` 更新为 `/proxy/alerting.kubesphere.io/v2beta1/clusters/{cluster}/**`。
- 全局级别的规则组和告警，API 路径前缀由 `[apis/kapis]/alerting.kubesphere.io/v2beta1/**` to `/proxy/alerting.kubesphere.io/v2beta1/**`。
- 对于内置的规则组，当可观测中心未启用时，通过集群级别规则组的 API 路径以及一个 `builtin=true` 的请求参数进行访问。例如请求 `/proxy/alerting.kubesphere.io/v2beta1/clusters/{cluster}/[clusterrulegroups|clusteralerts]?builtin=true` 可分别访问内置规则组和它们的告警。

请求体和响应的数据结构保持不变。

更多细节请参考 [API 文档](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-alerting/api_zh.md)。

### 优化

- 告警流程优化，尤其在启用可观测中心的场景下显著缩短了告警流程。
- 降低 member 集群的告警负载，在启用可观测中心的场景下实现 member 集群的告警负载轻量化。

### 缺陷修复

- 修复规则检查时间短暂出现零时间戳的问题。
- 修复在告警页面使用多个过滤条件查询告警时数据未显示和分页异常等问题。

### 其他

- process-exporter-rules 规则组作为内置规则组，支持在启用可观测中心的场景下通过全局规则组进行管理。