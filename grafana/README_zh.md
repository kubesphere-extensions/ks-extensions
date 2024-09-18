## 功能

Grafana 允许您查询、可视化、报警和理解存储在任何地方的指标。创建、探索和与团队共享仪表板，培养数据驱动的文化：

- **可视化：** 使用多种选项快速灵活的客户端图形。面板插件提供了许多不同的方式来可视化指标和日志。
- **动态仪表板：** 使用模板变量创建动态和可重用的仪表板，这些变量显示为仪表板顶部的下拉列表。
- **探索指标：** 通过自发查询和动态钻取探索您的数据。拆分视图并比较不同的时间范围、查询和数据源。
- **探索日志：** 体验从指标切换到日志的魔法，保留标签过滤器。快速搜索所有日志或实时流式传输。
- **报警：** 视觉上定义您最重要的指标的报警规则。Grafana将持续评估并向诸如Slack、PagerDuty、VictorOps、OpsGenie等系统发送通知。
- **混合数据源：** 在同一图表中混合不同的数据源！您可以根据每个查询指定数据源。甚至适用于自定义数据源。

## 安装

1. 通过 **扩展市场** 页面找到 **Grafana for WhizardTelemetry** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，静待安装完成。

## 配置

### 暴露 Grafana 服务

```yaml
  ## Expose the grafana service to be accessed from outside the cluster (LoadBalancer service).
  ## or access it from within the cluster (ClusterIP service). Set the service type and the port to serve it.
  ## ref: http://kubernetes.io/docs/user-guide/services/
  ##
  service:
    enabled: true
    type: ClusterIP
    loadBalancerIP: ""
    loadBalancerClass: ""
    loadBalancerSourceRanges: []
    port: 80
    targetPort: 3000
    # nodePort: 32000
```

|参数 |描述 |
| -------- | -------- |
|type: ClusterIP  |只能在集群内部通过虚拟 IP 地址访问 Grafana 服务。|
|type: NodePort  |使用 NodePort 方式暴露服务，可通过 `nodePort` 参数指定端口。Grafana 服务的默认端口为 32000。配置后，可通过 <NodeIP>:<nodePort> 访问 Grafana 控制台。|
|type: LoadBalancer |使用云服务商提供的负载均衡器向外部暴露 Grafana 服务。有关更多信息，请联系您的基础设施环境提供商。|

## 快速入门

按照以上配置暴露 Grafana 服务后，访问 Grafana 控制台，使用默认帐户和密码 (**admin/admin**) 登录。

点击左侧导航栏的 **Dashboards**，查看 Grafana for WhizardTelemetry 预置的 Dashboard 模板。


## 卸载

通过 **扩展市场** 页面找到 **Grafana for WhizardTelemetry** 扩展，选择已安装的版本，点击 **卸载** 按钮，开始卸载。
