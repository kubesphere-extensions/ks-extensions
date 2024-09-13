## Installation

1. Navigate to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Platform Service** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. Once configuration is completed, click the **Start Installation** button and wait for the installation to complete.

> The WhizardTelemetry Platform Service extension only provides backend services and does not have a user interface.

## Configuration

### Configure OpenSearch settings for logging, events

If the cluster needs to use multiple OpenSearch, you can configure them as follows.

```yaml
whizard-telemetry:
  config:
    monitoring:
      enabled: true
      kind: 0
      endpoint: http://prometheus-k8s.kubesphere-monitoring-system.svc:9090
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

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the **WhizardTelemetry Platform Service** extension, select the installed version, and click the **Uninstall** button to begin the uninstallation process.