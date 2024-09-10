## Functionality

It provides exporting, filtering, and alerting capabilities for Kubernetes events.

## Installation

### Install dependent extensions

Install the following dependent extensions:  

- ***WhizardTelemetry Platform Service*** (Required)
- ***WhizardTelemetry Data Pipeline*** (Required)

### Install WhizardTelemetry Events

1. Navigate to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Events** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. Once configuration is complete, click the **Start Installation** button and wait for the installation to complete.


## Quick Start

After installation, the **Resource Event Search** option will be available in the toolbox located at the bottom right corner of the page, which allows users to query resource events within their own permission scope.

Under the **Cluster Settings** menu in the left navigation pane of the cluster, you will find **Log Receivers**. The page will display the **Resource Events** tab, which supports adding various types of log receivers.


## Configuration

### Customize OpenSearch index

When OpenSearch sink is enabled, you can customize the format of the OpenSearch index.

```yaml
kube-events-exporter:
  sinks:
    opensearch:
      enabled: true
      index:
        prefix: "{{ .cluster }}-events"
        timestring: "%Y.%m.%d"
```

**prefix** is used to specify the index's prefix, supporting template syntax. **timestring** is parsed from **strftime** patterns and is used to specify the time format of the index. The final index format is **{{ prefix }}-{{ timestring }}**.

Example:

Create indexes by week

```
      index:
        prefix: "{{ .cluster }}-events"
        timestring: "%Y.%V"
```

Create indexes by month

```
      index:
        prefix: "{{ .cluster }}-events"
        timestring: "%Y.%m"
```

Split events by namespace

```
      index:
        prefix: "{{ .cluster }}-{{ .involvedObject.namespace }}-events"
        timestring: "%Y.%V"
```

> Please modify the **WhizardTelemetry Platform Service** configuration after changing the index format.

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **WhizardTelemetry Events** extension, and click the **Uninstall** button to begin the uninstallation process.
