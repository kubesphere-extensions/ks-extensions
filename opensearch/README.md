## Functionality

OpenSearch is the built-in log storage extension of KubeSphere, which is used to store logs, audits, events, and notification history.

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **OpenSearch distributed search and analytics engine** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. After configuration, click the **Start Installation** button to start the installation.
3. After the installation is completed, click the **Next** button to go to the cluster selection page. Check the clusters you want to install the extension and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Quick Start

The OpenSearch Distributed Search and Analytics Engine extension only provides backend services without a frontend interface. The OpenSearch service from this extension serves as the default log receiver for KubeSphere.

After installation, you need to modify the OpenSearch configurations in the WhizardTelemetry Data Pipeline to retrieve data of logs, audits, events, and notification history from OpenSearch. If your OpenSearch is installed within the Kubernetes cluster, please configure the NodePort for OpenSearch services and then change the OpenSearch endpoint in the configurations of WhizardTelemetry Data Pipeline accordingly. For more information, please refer to the details page of the "WhizardTelemetry Data Pipeline" extension in the Extensions Center.

## Configuration

The OpenSearch Distributed Search and Analytics Engine extension not only facilitate the installation of OpenSearch but also offer options for installing the OpenSearch Dashboard and OpenSearch Curator plugins. Users can precisely control the enabling and disabling of the plugins by configuring the relevant parameters. Below are the configuration methods:

### OpenSearch Dashboard
OpenSearch Dashboards serves as the user interface for visualizing OpenSearch data and managing OpenSearch clusters. Set the parameter `opensearch-dashboards.enabled` to determine whether to activate the OpenSearch Dashboard plugin. By default, it is disabled.

```yaml
opensearch-dashboards:
  enabled: false
```

### OpenSearch Curator
OpenSearch Curator is a scheduled task that regularly cleans up Kubernetes event logs, Kubernetes audit logs, Kubernetes application logs, and notification-history logs that exceed the configured period (default is 7 days). Set the parameter `opensearch-curator.enabled` to determine whether to activate the OpenSearch Curator plugin. By default, it is enabled.

```yaml
opensearch-curator:
  enabled: true
```

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the **OpenSearch distributed search and analytics engine** extension, select the installed version, and click the **Uninstall** button to begin the uninstallation process.