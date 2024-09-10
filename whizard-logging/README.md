## Functionality

WhizardTelemetry Logging is used for collecting and querying logs of the KubeSphere platform.

## Installation

### Install dependent extensions

Install the following dependent extensions:  

- ***WhizardTelemetry Platform Service*** (Required)
- ***WhizardTelemetry Data Pipeline*** (Required)


### Install WhizardTelemetry Logging

1. Navigate to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Logging** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. Once configuration is complete, click the **Start Installation** button and wait for the installation to complete.

## Quick Start

After installation, the **Container Log Search** option will be available in the toolbox located at the bottom right corner of the page. KubeSphere uses OpenSearch as the default log receiver. You can query the logs collected by OpenSearch here.

> If logs are not collected, please ensure that the Docker root directory is located in `/var/lib`. Otherwise, you will need to modify the mount configuration of the agent in the WhizardTelemetry Data Pipeline extension.

Under the **Cluster Settings** menu in the left navigation pane of the cluster, you will find **Log Receivers**. The page will display the **Container Logs** tab, which supports adding various types of log receivers.


## Configuration

### Enable disk logging collection

Set `logsidecar-injector.enabled` to decide whether to enable disk logging collection.

```yaml
logsidecar-injector:
  enabled: false
```

> Note: Since the job controlling the update of this parameter runs only on the host cluster, simply setting `logsidecar-injector.enabled` for member clusters will not take effect. Any modification to this parameter requires simultaneous changes to the host cluster's configuration to trigger the update.
> 
> For instance, to disable logging collection for a specific member cluster, set `logsidecar-injector.enabled: false` in the configuration of that member cluster, and then set `logsidecar-injector.updateVersion: 1` in the host cluster's configuration. Each time you change the parameter, you should change `logsidecar-injector.updateVersion` to trigger the update.

### Send logs to a specific OpenSearch instance

If you want to send logs from a specific cluster to a designated OpenSearch instance, please modify the relevant configuration of OpenSearch under `vector-logging` in the Logging configuration. 

If it is configured to a non-default OpenSearch, please refer to the Readme of the WhizardTelemetry Platform Service to modify the relevant configurations. 

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

### Customize OpenSearch index

When OpenSearch sink is enabled, you can customize the format of the OpenSearch index.

```yaml
vector-logging:
  sinks:
    opensearch:
      enabled: true
      index:
        prefix: "{{ .cluster }}-logs"
        timestring: "%Y.%m.%d"
```

**prefix** is used to specify the index's prefix, supporting template syntax. **timestring** is parsed from **strftime** patterns and is used to specify the time format of the index. The final index format is **{{ prefix }}-{{ timestring }}**.

Example:

Create indexes by week

```
      index:
        prefix: "{{ .cluster }}-logs"
        timestring: "%Y.%V"
```

Create indexes by month

```
      index:
        prefix: "{{ .cluster }}-logs"
        timestring: "%Y.%m"
```

Split container logs by namespace

```
      index:
        prefix: "{{ .cluster }}-{{ .kubernetes.namespace_name }}-logs"
        timestring: "%Y.%V"
```

> Please modify the **WhizardTelemetry Platform Service** configuration after changing the index format.


## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **WhizardTelemetry Logging** extension, and click the **Uninstall** button to begin the uninstallation process.
