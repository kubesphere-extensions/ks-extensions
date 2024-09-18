## Functionality

Loki is a horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus. It is designed to be very cost effective and easy to operate. It does not index the contents of the logs, but rather a set of labels for each log stream.

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **Grafana Loki for WhizardTelemetry** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. After configuration, click the **Start Installation** button to start the installation.
3. After the installation is completed, click the **Next** button to go to the cluster selection page. Check the clusters you want to install the extension and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

> Grafana Loki for WhizardTelemetry provides only backend services without a UI interface. You can use the Grafana console to visualize the data stored in Loki, but you should config the loki data source in Grafana first.

## Configuration

### Config Loki data source in Grafana

If the Grafana console is deployed by the Grafana for WhizardTelemetry extension, once Grafana Loki for WhizardTelemetry is installed, Loki data sources will automatically be added to Grafana console for logs, audits, events, and notification history. No need to manually add data sources.

However, if the Grafana console is deployed by other methods, you need to manually add the Loki data source by following these steps:

1. In the Grafana console, navigate to **Connections** > **Data sources**, click on **Add new data source**, and click **Loki** to access the configuration page for the Loki data source.

2. Under Connection, set the **URL** to `http://loki-gateway.loki.svc` or another Loki gateway address.

3. Under HTTP headers, add **HTTP Header** `X-Scope-OrgID` and set the value to a tenant ID. For example, the tenant ID for KubeSphere logging, events, auditing, and notifications are `whizard-logs-ks`, `whizard-events-ks`, `whizard-auditing-ks`, and `whizard-notification-ks` respectively.

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the **Grafana Loki for WhizardTelemetry** extension, select the installed version, and click the **Uninstall** button to begin the uninstallation process.