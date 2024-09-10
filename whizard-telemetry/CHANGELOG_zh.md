<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.2.2

### 新特性

- 使用 OpenSearch 作为日志后端存储时支持自定义索引格式。

### 优化

- 使用 OpenSearch 作为日志后端存储时支持纳秒级排序查询。

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0

`WhizardTelemetry 平台服务` 是从原 `KubeSphere APIServer` 中将可观测相关功能剥离出来形成的新增服务，是 `WhizardTelemetry 可观测平台` 中各个可观测服务共用的 `APIServer`，为所有可观测功能提供公共的后端平台服务，目前提供了监控、日志、审计、事件、通知等服务的 API。

### API 更新

- 监控 API 已升级为 `monitoring.kubesphere.io/v1beta1` 版本，更多 API 细节可参考 [WhizardTelemetry 监控开发者文档](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/montoring-extension-dev-guide.md#whizardtelemetry-monitoring-api-%E5%8F%82%E8%80%83) 及 [Swagger](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/swagger.json)
- 日志、事件 API 已升级为 `logging.kubesphere.io/v1beta2` 版本，更多 API 细节可参考 [WhizardTelemetry 日志开发者文档](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/logging-dev-guide.md#whizardtelemetry-api-%E5%8F%82%E8%80%83) 及 [Swagger](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/swagger.json)

### 新特性

- 接入 KubeSphere 鉴权认证，支持用户权限校验
- 监控 API 支持通过模板文件加载 PromQL 查询表达式
- 监控 API 支持自定义组件查询

### 优化

- 优化监控 API 查询性能
- 优化日志 API 查询性能
- 优化事件 API 查询性能

### 弃用

- 监控 API `monitoring.kubesphere.io/v1alpha3` 已于 KSE 3.5 弃用，并且在 KSE v4.1.0 正式移除
- 日志、事件 API `tenant.kubesphere.io/v1alpha2` 已在 KSE v4.1.0 正式移除
