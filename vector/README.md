## Installation

1. Navigate to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Data Pipeline** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. Once configuration is complete, click the **Start Installation** button and wait for the installation to complete.

The WhizardTelemetry Data Pipeline extension only provides backend services and does not have a user interface.

> Note: WhizardTelemetry Data Pipeline extension components are dependencies for extensions such as WhizardEvents event management, WhizardLogging log management, WhizardAuditing auditing management, WhizardNotification notification management, etc. Therefore, before installing the aforementioned extensions, it's necessary to install the WhizardTelemetry Data Pipeline extension component, otherwise log, notification, auditing, event functionalities will not work properly! 
> 
> Note: WhizardTelemetry Observability Platform supports querying logs, audits, events, and notification history from OpenSearch. Therefore, you should configure the OpenSearch information in the WhizardTelemetry Data Pipeline extension to receive data such as logs, audits, events, and notification history. The OpenSearch service can either be a user-deployed instance or an OpenSearch service installed through the "OpenSearch Distributed Search and Analytics Engine" extension.

## Configuration

### Configure OpenSearch Settings

* api_version: Version of OpenSearch API. Choose the correct API version based on the version of OpenSearch being used.
* auth.strategy: Authentication strategy. For OpenSearch, "basic" or other supported authentication strategies can be chosen.
* auth.user: Authentication username.
* auth.password: Authentication password.
* endpoints: Addresses of OpenSearch nodes. (Note: The addresses of OpenSearch must be accessible to each member cluster. If OpenSearch is installed within a K8s cluster, the OpenSearch service needs to be configured with a NodePort and the default OpenSearch address should be changed!)
* tls.verify_certificate: Whether to verify the certificate.
* tls.cacert: Path to the CA certificate.
* ssl: Whether to use TLS/SSL connection.

```yaml
sinks:
  opensearch:
    api_version: v8
    auth:
      strategy: basic
      user: admin
      password: admin
    endpoints:
      - https://opensearch-cluster-data.kubesphere-logging-system.svc:9200
    tls:
      verify_certificate: false
```

### Set Docker Root Directory

If the Docker root directory is not located in the `/var/lib` directory, it needs to be configured under `agent.extraVolumes` and `agent.extraVolumeMounts`. Please note that before installation, you need to confirm the Docker root directory. Otherwise, after installation, you will need to modify the configuration for each agent.

```yaml
agent:
  extraVolumes:
    - name: docker-root
      hostPath:
        path: /path
        type: ''
  extraVolumeMounts:
    - name: docker-root
      mountPath: /path
```

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **WhizardTelemetry Data Pipeline** extension, and click the **Uninstall** button to begin the uninstallation process.