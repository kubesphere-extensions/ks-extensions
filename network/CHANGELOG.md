<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.0

### Features

- Support associating multiple ippools with workloads.

### Bug Fixes

- Fix the issue where the IP pool blocksize is not automatically populated when creating an ippool.
- Correct the wrong behavior of the "Refresh" and "Clear" operations in the IP pool selection list.
- Fix permission issues when creating a new IP pool in workloads.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.0.0

The `Network` extension has been refactored based on the new microkernel architecture KubeSphere 4.x. It currently includes the management configuration of IPPool and NetworkPolicy, along with some architectural changes and new features.

- IPPool no longer uses the previous management approach provided by KubeSphere (ippools.network.kubesphere.io) and directly manages calico ippool (ippools.crd.projectcalico.org) to avoid conflicts with other third-party management tools. It also supports more configurable fields for calico ippool.
- NetworkPolicy mainly optimizes the user experience when configuring external whitelists for project network isolation.

### Features

- Support creating IP pools using YAML and dynamically editing YAML.
- Support configuration for more IP pool fields on the UI such as nodeSelector and NatOutgoing.
- Support configuring port ranges for external whitelists in project network isolation.
- Support configuring multiple network segments and ports for external whitelists in project network isolation.
- Support dynamically modifying the configuration and basic information of external whitelists in project network isolation.

### Deprecations

- Deprecate binding IPPool to workspace, but supports binding native calico ippool to namespaces.
- Remove ippools, ipamblocks, and ipamhandles from `network.kubesphere.io/v1alpha1`.

### API Changes

- Update ippool to ippools.crd.projectcalico.org/v1. For more API details, please refer to the [Network API Reference](https://yunify-qingcloud-docs.pek3b.qingstor.com/docs/kse/v4.1/network-api_doc.md) and [Swagger](https://yunify-qingcloud-docs.pek3b.qingstor.com/docs/kse/v4.1/network-swagger.yaml).


