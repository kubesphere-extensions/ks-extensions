<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.4

### 新特性

- 支持将 vector 的 metrics 导出到 Prometheus。

### 其他

- 升级 vector 至 0.39.0

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0

### 新特性

- 原用于日志、审计、事件、通知历史等信息采集的 agent 由 Fluent Bit 替换为 Vector Agent
- 新增 Vector Aggregator 用于部署到 Host 集群收集通知历史等信息
- 为 Vector 新增 vector-config sidecar 容器，用于监听存储 vector 配置的 secret，并自动生成 vector 的配置文件
- 定制了 Vector Helm Chart， 使得可以将 Vector 配置存储在 secret，取代了 Vector 上游将包含敏感信息的 Vector 配置存储在 configmap 的做法

### 弃用

- 原用于日志、审计、事件、通知历史等信息采集的 Fluent Bit 及 FluentBit Operator 已被弃用并移除