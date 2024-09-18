## 功能

Loki 是一个受 Prometheus 启发的水平可扩展、高可用、多租户日志聚合系统。它的设计非常经济高效且易于操作。它不索引日志的内容，而是为每个日志流建立一组标签。

## 安装

1. 通过 **扩展市场** 页面找到 **Grafana Loki for WhizardTelemetry** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，开始安装；
3. 安装完成后，点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面；
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

> Grafana Loki for WhizardTelemetry 仅提供后端服务，无前端界面。可借助 Grafana 控制台可视化存储到 Loki 的数据，但需要先在 Grafana 中配置 Loki 数据源。

## 配置

### 在 Grafana 中配置 Loki 数据源

若 Grafana 控制台为 Grafana for WhizardTelemetry 扩展组件所部署，Grafana Loki for WhizardTelemetry 安装完成后，会自动在 Grafana 控制台为日志、审计、事件及通知历史添加 Loki 数据源。无需手动添加数据源。

若 Grafana 控制台使用其他方法部署，您需要手动添加 loki 数据源，请按以下步骤设置：

1. 在 Grafana 控制台，点击 Connections > Data sources, 点击 Add new data source, 点击 loki 进入 loki 数据源的配置页面.

2. 在 Connection 下设置 **URL** 为 **http://loki-gateway.loki.svc** 或其他 loki 网关地址。
   
3. 在 HTTP headers 下添加 HTTP Header `X-Scope-OrgID` 并将值设置为租户 ID，比如 KubeSphere 的日志、事件、审计和通知的租户 ID 分别为 `whizard-logs-ks`、`whizard-events-ks`、`whizard-auditing-ks` 和 `whizard-notification-ks`。


## 卸载

通过 **扩展市场** 页面找到 **Grafana Loki for WhizardTelemetry** 扩展，选择已安装的版本，点击 **卸载** 按钮，开始卸载。