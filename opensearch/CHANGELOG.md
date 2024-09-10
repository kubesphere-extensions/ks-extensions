<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v2.11.1

`OpenSearch 分布式检索与分析引擎` 是 WhizardTelemetry 可观测平台中内置的分布式检索与分析引擎， 是用于存储、检索与分析日志、审计、事件、通知历史等可观测数据的扩展组件。

可通过 `OpenSearch 分布式检索与分析引擎` 部署与管理如下组件：

- OpenSearch 的 Master 节点
- OpenSearch 的 Data 节点
- OpenSearch Dashboard
- OpenSearch Curator (用于定期清理过期数据)

### 优化

- 调整 OpenSearch Data 节点的 Service 为 NodePort 类型（端口 30920）
- 降低 OpenSearch Master 节点与 Data 节点 request 的 CPU 与 Memory
- 调整 OpenSearch Curator 索引清理规则

### 其他

- 升级 OpenSearch 到 `2.11.1`
- 升级 OpenSearch Dashboard 到 `2.11.1`
