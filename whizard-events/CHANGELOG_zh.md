<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.2.0

### 新特性

- 支持使用 Loki 作为事件后端存储
- 使用 OpenSearch 作为后端存储时支持自定义 OpenSearch 的索引格式

### 优化

- 使用 OpenSearch 作为后端存储时支持纳秒级排序查询

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0

`WhizardTelemetry 事件` 是 WhizardTelemetry 可观测平台中用于 Kubernetes 原生事件导出的扩展组件，该扩展可以部署与管理 kube-events-exporter。该组件主要负责：

- 收集Kubernetes 原生事件并导出到 stdout
- 由 vector agent 收集落盘的 Kubernetes 事件日志并进行格式转换后，发送给用户指定的接收者如 OpenSearch
- UI 上支持查询各集群的 Kubernetes 事件日志

### 新特性

- 新增用于导出 Kubernetes 原生事件的 kube-events-exporter
- Kubernetes 事件由之前的 Webhook 方式接收改为由 Vector Agent 收集由 kube-events-exporter 输出到 stdout 进而落盘的 Kubernetes 事件，并发送到 OpenSearch 等用于归档或查询


### 弃用

- 弃用并移除原 kube-events 项目定义的 CRDs, Ruler 及 Controller