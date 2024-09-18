## Functionality

Grafana allows you to query, visualize, alert on and understand your metrics no matter where they are stored. Create, explore, and share dashboards with your team and foster a data-driven culture:

- **Visualizations:** Fast and flexible client side graphs with a multitude of options. Panel plugins offer many different ways to visualize metrics and logs.
- **Dynamic Dashboards:** Create dynamic & reusable dashboards with template variables that appear as dropdowns at the top of the dashboard.
- **Explore Metrics:** Explore your data through ad-hoc queries and dynamic drilldown. Split view and compare different time ranges, queries and data sources side by side.
- **Explore Logs:** Experience the magic of switching from metrics to logs with preserved label filters. Quickly search through all your logs or streaming them live.
- **Alerting:** Visually define alert rules for your most important metrics. Grafana will continuously evaluate and send notifications to systems like Slack, PagerDuty, VictorOps, OpsGenie.
- **Mixed Data Sources:** Mix different data sources in the same graph! You can specify a data source on a per-query basis. This works for even custom datasources.

## Installation

1. Navigate to the **KubeSphere Marketplace** page and find the **Grafana for WhizardTelemetry** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. Once configuration is complete, click the **Start Installation** button and wait for the installation to complete.

## Configuration

### Expose the grafana service

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

| Parameter | Description |
| -------- | -------- |
| type: ClusterIP | Access the Grafana service only within the cluster via a virtual IP address. |
| type: NodePort | Expose the service using NodePort, please specifying the `nodePort` parameter. The default nodePort for Grafana service is 32000. Once configured, you can access the Grafana console via `<NodeIP>:<nodePort>`. |
| type: LoadBalancer | Expose the Grafana service using the load balancer provided by the cloud service provider. For more information, please contact your infrastructure environment provider. |

## Quick Start

After exposing the Grafana service as the above configurations, access the Grafana console and log in using the default credentials (**admin/admin**).

Navigate to **Dashboards** on the left pane to view all built-in dashboards from Grafana for WhizardTelemetry.

## Uninstallation

To uninstall, go to the **KubeSphere Marketplace** page, find the **Grafana for WhizardTelemetry** extension, select the installed version, and click the **Uninstall** button to start the uninstallation process.
