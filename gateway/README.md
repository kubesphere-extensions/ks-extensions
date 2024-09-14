## Features

- Multi-level network configuration: Utilizing Nginx Ingress, it provides management for cluster gateways, enterprise space gateways, and project gateways.
- Flexible governance: Integrated with KubeSphere's permission system, it supports granular control and management at the tenant level.
- Flexible access: Supports multiple gateway access modes, such as NodePort, LoadBalancer, and ClusterIP.
- Day-2 operations: Based on WhizardTelemetry's monitoring and logging components, it enables operational capabilities such as gateway monitoring and gateway log searching.

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **KubeSphere Gateway** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Quick Start

After installation, **Gateway Settings** will be displayed under the **Cluster Settings** menu in the left navigation pane of the cluster; under the **Workspace Settings** menu in the left navigation pane of the workspace; and under the **Project Settings** menu in the left navigation pane of the project.

In these menus, you can enable, disable, view, and edit the cluster gateway, workspace gateway, and project gateway. These gateways provide reverse proxy for services in the cluster, the workspace, and the project.


## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **KubeSphere Gateway** extension, and click the **Uninstall** button to begin the uninstallation process.