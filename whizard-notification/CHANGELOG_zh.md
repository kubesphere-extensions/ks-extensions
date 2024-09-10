<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.5.9

### 新特性

- 支持配置企业微信群机器人，可将通知发往企业微信群

### 优化

- 通知订阅页面的用户体验优化
- 在通知消息中增加时间信息
- 支持相同的告警重复触发通知

### 缺陷修复

- 修复多集群环境中存在异常集群时其他集群的租户信息无法更新的问题
- 修复在低版本 K8s 集群(1.22 以下)的安装兼容性问题
- 修复 alertmanager 在某些网络环境下无法正常启动的问题

### 其他

- 升级 alertmanager 至 v0.27.0
- 升级 alertmanager-proxy 至 v0.2.0


<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.5.1

`WhizardTelemetry 通知` 是 WhizardTelemetry 可观测平台中提供通知功能的扩展组件，可提供电子邮件、Slack、企业微信、钉钉、飞书、Webhook 等多渠道通知功能。
可通过 `WhizardTelemetry 通知` 部署与管理如下组件：

- Notification Manager
- Alertmanager
- Alertmanager Proxy

### 优化

- 支持在通知中显示 receiver 名称
- 支持为 notification manager deployment 添加注解和标签

### 缺陷修复

- 修复了正则匹配会匹配所有告警的问题
- 修复了编辑订阅条件，选择过滤条件为“包含”后，页面白屏的问题

### 其他

- 升级 Notification Manager 至 v2.5.1
- 升级 Alertmanager 至 v0.26.0

### 弃用

- v2beta1 版本的 CRD 已被移除
- 移除了 notification adaptor 组件

