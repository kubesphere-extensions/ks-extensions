<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.3

### Enhancements

- The namespace and pod labels are removed from the node alerts because they are irrelevant to nodes.

### Bug Fixes

- Fix the issue where clusters without the alerting extension installed still display its entry.

### Misc

- Upgrade thanos to v0.36.1

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.0.0

**WhizardTelemetry Alerting** is an extension of the WhizardTelemetry Observability Platform for alerting based on metrics, providing multi-cluster rule group management, evaluation, and alerting functions.

This extension allows you to deploy and manage the following components:

- apiserver: provides APIs related to rule groups and alerts.
- controller-manager: ensures synchronization for rule groups.
- ruler: carries out rule evaluation and alerting.

Compared with KSE v3.5, it brings significant enhancements to the flow and efficiency, particularly in multi-cluster envrionments, from an architectural standpoint.

### API Changes

Compared to KSE 3.5, The primary changes are in the request paths:

- For cluster-level and project-level rule groups and alerts, the API path prefix has shifted from `[apis|kapis]/clusters/{cluster}/alerting.kubesphere.io/v2beta1/**` to `/proxy/alerting.kubesphere.io/v2beta1/clusters/{cluster}/**`.
- For global-level rule groups and alerts, the API path prefix has shifted from `[apis/kapis]/alerting.kubesphere.io/v2beta1/**` to `/proxy/alerting.kubesphere.io/v2beta1/**`.
- For built-in rule groups, when the Observability Center is not enabled, they can be accessed through the API path of the cluster-level rule group and a `builtin=true` request parameter. For example, requesting `/proxy/alerting.kubesphere.io/v2beta1/clusters/{cluster}/[clusterrulegroups|clusteralerts]?builtin=true` can access the built-in rule groups and their alerts.

The request body and response data structures remain unchanged.

### Enhancements

- The request flow has been streamlined, notably when the Whizard Observability Center is enabled.
- There’s a reduced load on member clusters, again, particularly noticeable when the Whizard Observability Center is in use.

### Bug Fixes

- Fix the issue of zero timestamps appearing briefly in rule check time.
- Fix issues such as data not displayed and pagination anomalies when querying alerts with multiple filter conditions on the alert page.

### Misc

- The process-exporter-rules rule group, as a built-in rule group, supports operations as a global rule group when the Whizard Observability Center is enabled.