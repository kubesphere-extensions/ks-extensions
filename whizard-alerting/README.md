## Features

- Provides CRUD, enable/disable operations, and other flexible configurations on rule groups and rules.  
- Provides template-based rule configuration to simplify common scenarios and custom configuration of rule expressions. 
- Supports multi-tenant and multi-cluster alerting with project, cluster, and global multi-level rule groups.  
- Provides built-in rule groups to cover common alerting for platform components and applications.

## Installation

### Install dependent extensions

Install the following dependent extensions:  

- ***WhizardTelemetry Monitoring*** (Required)
- ***WhizardTelemetry Platform Service*** (Required)
- ***WhizardTelemetry Notification*** (Optional)

### Install WhizardTelemetry Alerting

> Please modify the configuration of the extension according to the instructions in the **Configuration** section before clicking "Start Installation". 

1. Go to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Alerting** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Configuration

Configure `agent.ruler.alertmanagersUrl` with the address of the alertmanager-proxy service (which is provided by the ***WhizardTelemetry Notification*** extension, installed in the host cluster, and is accessible by default at `http://<host node ip>:31093`)。

```yaml
agent:
  ruler:
    alertmanagersUrl:
    - 'http://<host node ip>:31093'
```
> **Please note that `ruler.alertmanagersUrl` here is under `agent`**。

> If the ***WhizardTelemetry Notification*** extension is not enabled and you want alerts to be sent to an external alertmanager, please configure the external service address to the `agent.ruler.alertmanagersUrl` above.

## Quick Start

After installation, under the **Monitoring & Alerting** menu on the left navigation pane for clusters and projects., you will find **Alerts** and **Rule Groups**.

Alerting rules defined in **Rule Groups** are used to monitor cluster resources. You can create, edit, disable, enable rule groups, and reset built-in rule groups.

When the metrics defined in the rule group meet the preset conditions and duration, the system generates an alert. You can view the alerts on the **Alerts** page.

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **WhizardTelemetry Alerting** extension, and click the **Uninstall** button to begin the uninstallation process.
