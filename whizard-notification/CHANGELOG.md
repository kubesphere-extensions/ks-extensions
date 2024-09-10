<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.5.9

### Features

- Add support for configuring WeChat Work group robots to send notifications to WeChat Work groups.

### Enhancements

- Improve user experience on the notification subscription page.
- Add time information to notification messages.
- Support repeated notifications triggered by the same alerts.

### Bug Fixes

- Fix the issue in multi-cluster environments where tenant information for other clusters does not update when there is an unready cluster.
- Fix an installation compatibility issue on K8s clusters (below v1.22).
- Fix the issue where the alertmanager could not start properly in certain network environments.

### Misc

- Upgrade alertmanager to v0.27.0
- Upgrade alertmanager-proxy to v0.2.0

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

### 其他

- 升级 Notification Manager 至 v2.5.1
- 升级 Alertmanager 至 v0.26.0

### 弃用

- v2beta1 版本的 CRD 已被移除
- 移除了 notification adaptor 组件

