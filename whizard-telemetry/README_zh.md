## 安装

1. 通过 **扩展市场** 页面找到 **WhizardTelemetry 平台服务** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，静待安装完成。

> WhizardTelemetry 平台服务仅提供后端服务，无前端界面。


## 配置

### 配合 WhizardTelemetry 监控启用 Whizard 可观测中心

修改 **WhizardTelemetry 平台服务** 的 **扩展组件配置**， 将 `whizard-telemetry.config.observability.enabled` 设置为 `true`

```yaml
whizard-telemetry:
  config:
    observability:
      enabled: true
      endpoint: "http://query-frontend-whizard-operated.kubesphere-monitoring-system.svc:10902"
```

### 配置日志、事件的 OpenSearch

如果集群需要使用多个 OpenSearch 存储，可以按如下配置。

```yaml
whizard-telemetry:
  config:
    monitoring:
      enabled: true
      kind: 0
      endpoint: http://prometheus-k8s.kubesphere-monitoring-system.svc:9090
    observability:
      enabled: false
      endpoint: "http://query-frontend-whizard-operated.kubesphere-monitoring-system.svc:10902"
    notification:
      endpoint: http://notification-manager-svc.kubesphere-monitoring-system.svc:19093
    events:
      enable: true
      servers:
        - elasticsearch:
            cluster:
            - cluster1
            - cluster2
            endpoints:
              - https://opensearch-cluster-data.kubesphere-logging-system:9200
            version: opensearchv2
            indexPrefix: "{{ .cluster }}-events"
            timestring: "%Y.%m.%d"
            basicAuth: true
            username: admin
            password: admin
        - elasticsearch:
            cluster:
            - cluster3
            - cluster4
            endpoints:
              - https://opensearch-cluster-data.kubesphere-logging-system:9200
            version: opensearchv2
            indexPrefix: "{{ .cluster }}-events"
            timestring: "%Y.%m.%d"
            basicAuth: true
            username: admin
            password: admin
    logging:
      enable: true
      servers:
        - elasticsearch:
            cluster:
            - cluster1
            - cluster2
            endpoints:
              - https://<the opensearch cluster url>:<port>
            version: opensearchv2
            indexPrefix: "{{ .cluster }}-logs"
            timestring: "%Y.%m.%d"
            basicAuth: true
            username: admin
            password: admin
        - elasticsearch:
            cluster:
            - cluster3
            - cluster4
            endpoints:
              - https://<the opensearch cluster url>:<port>
            version: opensearchv2
            indexPrefix: "{{ .cluster }}-logs"
            timestring: "%Y.%m.%d"
            basicAuth: true
            username: admin
            password: admin
```

## 卸载

通过 **扩展市场** 页面找到 **WhizardTelemetry 平台服务**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。