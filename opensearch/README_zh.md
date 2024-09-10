## 功能

OpenSearch  是 KubeSphere 内置的日志存储扩展组件，用于存储日志、审计、事件、通知历史等信息。

## 安装

1. 通过 **扩展市场** 页面找到 **OpenSearch 分布式检索与分析引擎** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，开始安装；
3. 安装完成后，点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面；
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

## 快速开始

OpenSearch 分布式检索与分析引擎仅提供后端服务，无前端界面。通过该扩展组件提供的 OpenSearch 服务为 KubeSphere 默认使用的日志接收器。

安装完成后，需在 WhizardTelemetry 数据流水线中修改 OpenSearch 的相关配置，以便能够从 OpenSearch 获取日志、审计、事件、通知历史等数据。如果您的 OpenSearch 是安装在 K8s 集群内，需要给 OpenSearch 服务配置好 NodePort 后更改 WhizardTelemetry 数据流水线中默认设置的 OpenSearch 地址！更多信息，请参阅扩展中心“WhizardTelemetry 数据流水线”扩展组件的详情页说明。


## 配置

OpenSearch 分布式检索与分析引擎扩展组件除了可部署 OpenSearch 外，还可以部署 OpenSearch Dashboard 和 OpenSearch Curator 插件。支持配置相应参数来控制插件的启用和禁用。以下是相关插件的配置方法：

### OpenSearch Dashboard
OpenSearch Dashboard 用于可视化 OpenSearch 数据以及管理 OpenSearch 集群的用户界面。通过设置 `opensearch-dashboards.enabled` 可以启用 OpenSearch Dashboards 插件。默认情况下，此功能处于关闭状态。

```yaml
opensearch-dashboards:
  enabled: false
```

### OpenSearch Curator
OpenSearch Curator 是一个定时任务，定期清理超过配置日期（默认为 7 天）的 Kubernetes 事件日志、Kubernetes 审计日志、Kubernetes 应用程序日志以及通知历史日志。通过设置 `opensearch-curator.enabled` 可以决定是否启用 OpenSearch Curator 插件。默认情况下，该插件已启用。

```yaml
opensearch-curator:
  enabled: true
```

## 卸载

通过 **扩展市场** 页面找到 **OpenSearch 分布式检索与分析引擎**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。