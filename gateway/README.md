## Features

- Multi-level network configuration: Utilizing Nginx Ingress, it provides management for cluster gateways, enterprise space gateways, and project gateways.
- Flexible governance: Integrated with KubeSphere's permission system, it supports granular control and management at the tenant level.
- Flexible access: Supports multiple gateway access modes, such as NodePort, LoadBalancer, and ClusterIP.
- Day-2 operations: Based on WizTelemetry's monitoring and logging components, it enables operational capabilities such as gateway monitoring and gateway log searching.

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **KubeSphere Gateway** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Upgrade

After upgrading, the following fields in the **Extension Config** need to be modified:

```yaml
backend:
  enabled: true
  config:
    gateway:
      namespace: kubesphere-controls-system
      valuesOverride:
        controller:
          image:
            registry: ""
            image: kubesphere/ingress-nginx-controller
            tag: "v1.12.1"
            pullPolicy: IfNotPresent
            digest: ""
      exposeNodeLabelKey: "node-role.kubernetes.io/control-plane"
      versionConstraint: ">= 4.3.0, <= 4.12.1"
      logSearchEndpoint: "http://whizard-telemetry-apiserver.extension-whizard-telemetry.svc:9090"
```

1. Check the `backend.config.gateway.versionConstraint` parameter. `versionConstraint` is used to restrict the installable versions for ingress-nginx (helm chart version).

   The default ingress-nginx version for the current extension version is **1.12.1** and the Helm chart version is **4.12.1**. Ensure the version range is updated to: `versionConstraint: ">= 4.3.0, <= 4.12.1"`。

2. Check the `backend.config.gateway.controller.image` parameter. `controller.image` defines the image of ingress-nginx to be installed.

   Update it to use the ingress-nginx **1.12.1** image by modifying `image.tag` to  `tag: "v1.12.1"`, `image.image` to `kubesphere/ingress-nginx-controller`.


## Quick Start

After installation, **Gateway Settings** will be displayed under the **Cluster Settings** menu in the left navigation pane of the cluster; under the **Workspace Settings** menu in the left navigation pane of the workspace; and under the **Project Settings** menu in the left navigation pane of the project.

In these menus, you can enable, disable, view, and edit the cluster gateway, workspace gateway, and project gateway. These gateways provide reverse proxy for services in the cluster, the workspace, and the project.


## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **KubeSphere Gateway** extension, and click the **Uninstall** button to begin the uninstallation process.