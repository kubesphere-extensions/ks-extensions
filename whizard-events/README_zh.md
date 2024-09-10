## 功能

提供 Kubernetes 事件导出、过滤和告警等功能。

## 安装

### 安装依赖扩展组件

安装下列依赖的扩展组件：

- ***WhizardTelemetry 平台服务*** (必需)
- ***WhizardTelemetry 数据流水线*** (必需)

### 安装 WhizardTelemetry 事件

1. 通过 **扩展市场** 页面找到 **WhizardTelemetry 事件** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，静待安装完成。

## 快速开始

安装完成后，页面右下角的⼯具箱中将显⽰**资源事件查询**选项，支持用户查询自身权限范围内的资源事件。

集群左侧导航栏的**集群设置**菜单下将显示**日志接收器**选项，日志接收器页面将显示**资源事件**页签，支持添加多种类型的日志接收器。


## 配置

### 自定义 OpenSearch 索引

启用 OpenSearch sink 时，可以自定义 OpenSearch 索引的格式。

```yaml
kube-events-exporter:
  sinks:
    opensearch:
      enabled: true
      index:
        prefix: "{{ .cluster }}-events"
        timestring: "%Y.%m.%d"
```

**prefix** 用于指定索引的前缀，支持模板。**timestring** 用于指定索引的时间格式，为 **strftime** 格式。最终的索引格式为 **{{ prefix }}-{{ timestring }}**。

例如：

按周创建索引

```
      index:
        prefix: "{{ .cluster }}-events"
        timestring: "%Y.%V"
```

按月创建索引

```
      index:
        prefix: "{{ .cluster }}-events"
        timestring: "%Y.%m"
```

事件按 namespace 存储

```
      index:
        prefix: "{{ .cluster }}-{{ .involvedObject.namespace }}-events"
        timestring: "%Y.%V"
```

> 修改索引格式后需修改 **WhizardTelemetry 平台服务** 配置。

## 卸载

通过 **扩展市场** 页面找到 **WhizardTelemetry 事件**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。

