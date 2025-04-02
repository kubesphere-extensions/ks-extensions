<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.3 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.4

### Enhancements

- Upgrade `ingress-nginx` to v4.12.1.

## v1.0.3

### Enhancements

- Upgrade `ingress-nginx` to v4.10.3.

### Bug Fixes

- Fix the abnormal log output by the gateway.
- Fix the issue where the gateway monitoring could not display the average latency.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.2

### Enhancements

- Improve user experience on the Gateway Settings page.

### Bug Fixes

- Fix the issue where all gateways of the cluster are displayed in the kubesphere-system namespace.
- Fix the issue where all gateways use the same lease, resulting in only one gateway running.
- Fix the issue where ingress-nginx cannot use global image configuration.
- Fix the issue where multiple project gateways selecting the master lead to the inability to update the ingress loadBalancer IP.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0

The `Gateway` is an extension that aggregates services and manages external access to the KubeSphere platform. It has been refactored based on the new microkernel architecture KubeSphere LuBan. It supports one-click enabling and management of cluster gateways, workspace gateways, and project gateways, facilitating comprehensive network configuration at different levels.

### Features

- Adjust the architecture of the gateway to facilitate decoupling from different vendors' gateways.
- Integrate the configuration steps for creating and editing gateways.
- Manage all configuration items in the gateway values through editing the gateway YAML.
- Configurable display of gateway address when exposed through NodePort.
- Support for more granular permission configuration, including gateway management and viewing.

### Bug Fixes

- Fix the exceptions when exporting gateway logs.

### Deprecations

- Remove Gateway v1alpha1 CRD.
- Remove Nginx v1alpha1 CRD.

### API Changes

- Add Gateway v2alpha1 CRD.

### Misc

- Upgrade nginx-ingress from v1.3.1 to v1.4.0.