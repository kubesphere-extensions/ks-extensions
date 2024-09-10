## 功能

WhizardTelemetry 日志用于收集和查询 KubeSphere 平台的日志。

## 安装

### 安装依赖扩展组件

安装下列依赖的扩展组件：

- ***WhizardTelemetry 平台服务*** (必需)
- ***WhizardTelemetry 数据流水线*** (必需)

### 安装 WhizardTelemetry 日志

1. 通过 **扩展市场** 页面找到 **WhizardTelemetry 日志** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，静待安装完成。

## 快速开始

安装完成后，页面右下角的⼯具箱中将显⽰**容器⽇志查询**选项。KubeSphere 默认使用 OpenSearch 作为日志接收器。您可以在这里查询 OpenSearch 收集的日志。

> 若未收集到日志，请确保 Docker 的根目录在 /var/lib 下，否则需要修改 WhizardTelemetry 数据流水线扩展组件中 agent 的挂载配置。

集群左侧导航栏的**集群设置**菜单下将显示**日志接收器**选项，日志接收器页面将显示**容器日志**页签，支持添加多种类型的日志接收器。

## 配置

### 启用落盘日志收集功能

通过设置 logsidecar-injector.enabled 决定是否启用落盘日志收集功能。
```yaml
logsidecar-injector:
  enabled: false
```

> 注意，由于控制此参数更新的 job 只会在 host 集群运行，因此如果想仅开启或关闭某些 member 集群的落盘日志收集功能，只设置 member 集群的 logsidecar-injector.enabled 是不会生效的。对于这个参数的修改每次都需要同时修改 host 集群的参数，以此来触发参数更新。
> 例如，当需要将某个 member 集群的日志收集功能关闭，只需要在该 member 集群的配置中设置 logsidecar-injector.enabled: false，然后在 host 集群的配置中设置 logsidecar-injector.updateVersion: 1。后续再进行同样操作只需要更新 logsidecar-injector.updateVersion 即可，即可触发更新。


### 日志输出到指定的 OpenSearch

如果需要某个集群的日志输出到指定的 OpenSearch，请修改日志扩展组件的 `vector-logging` 中 OpenSearch 的相关配置。

如果其被配置为非默认的 OpenSearch，请参阅 WhizardTelemetry 平台服务的详情页说明，修改相关配置。

```yaml
vector-logging:
  sinks:
    opensearch:
      # Create opensearch sink or not
      enabled: true
      # Configurations for the opensearch sink, more info for https://vector.dev/docs/reference/configuration/sinks/elasticsearch/
      # Usually users needn't change the following OpenSearch sink config, and the default sinks in secret "kubesphere-logging-system/vector-sinks" created by the WhizardTelemetry Data Pipeline extension will be used.
      metadata:
        api_version: v8
        auth:
          strategy: basic
          user: admin
          password: admin
        batch:
          timeout_secs: 5
        buffer:
          max_events: 10000
        endpoints:
          - https://<the opensearch cluster url>:<port>
        tls:
          verify_certificate: false
```

### 自定义 OpenSearch 索引

启用 OpenSearch sink 时，可以自定义 OpenSearch 索引的格式。

```yaml
vector-logging:
  sinks:
    opensearch:
      enabled: true
      index:
        prefix: "{{ .cluster }}-logs"
        timestring: "%Y.%m.%d"
```

**prefix** 用于指定索引的前缀，支持模板。**timestring** 用于指定索引的时间格式，为 **strftime** 格式。最终的索引格式为 **{{ prefix }}-{{ timestring }}**。

例如：

按周创建索引

```
      index:
        prefix: "{{ .cluster }}-logs"
        timestring: "%Y.%V"
```

按月创建索引

```
      index:
        prefix: "{{ .cluster }}-logs"
        timestring: "%Y.%m"
```

日志按 namespace 存储

```
      index:
        prefix: "{{ .cluster }}-{{ .kubernetes.namespace_name }}-logs"
        timestring: "%Y.%V"
```

> 修改索引格式后需修改 **WhizardTelemetry 平台服务** 配置。

## 卸载

通过 **扩展市场** 页面找到 **WhizardTelemetry 日志**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。

