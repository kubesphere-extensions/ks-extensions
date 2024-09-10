## 功能

通知管理器管理多租户 K8s 环境中的通知。它从不同的发送者那里接收告警、云事件和其他（如审计、k8s 事件），然后根据租户标签（如命名空间或用户）将通知发送到不同的租户接收器。

## 安装

### 安装依赖扩展组件

安装下列依赖的扩展组件：

- ***WhizardTelemetry 平台服务*** (必需)
- ***WhizardTelemetry 数据流水线*** (必需)

### 安装 WhizardTelemetry 通知

1. 通过 **扩展市场** 页面找到 **WhizardTelemetry 通知** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，静待安装完成。

## 快速开始

安装完成后，**平台设置**左侧导航栏下将显⽰**通知管理**菜单。在该页面，可设置通知渠道（邮件、钉钉、企业微信等）、订阅通知、设置通知静默策略和通知语言、查看已发送给用户的通知。

在页面右上角点击当前用户名，然后在下拉列表中选择**通知设置**，可设置多个通知接收人的信息，设置通知过滤条件等。

集群左侧导航栏的**集群设置**菜单下将显示**日志接收器**选项，日志接收器页面将显示**通知历史**页签，支持添加多种类型的日志接收器。

## 配置

### 配置 notification-history 和 notification-manager

notification-manager 部分为通知相关配置，配置方法请参考[通知配置](https://github.com/kubesphere/notification-manager)。

```yaml
notification-manager:
  kubesphere:
  enabled: true
  version: v4.0.0
  
  operator:
    containers:
      operator:
        image:
          tag: v2.5.1
          
  notificationmanager:
    annotations:
      kubesphere.io/serviceaccount-name: notification-tenant-sidecar
    image:
      tag: v2.5.1
```

## 卸载

通过 **扩展市场** 页面找到 **WhizardTelemetry 通知**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。

