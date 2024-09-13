## v1.1.0

`WhizardTelemetry Monitoring` is an extension component of the WhizardTelemetry observability platform that provides monitoring functionality. It offers multi-tenant views of cloud-native resource monitoring capabilities, including real-time and historical data displays of key monitoring metrics for clusters, nodes, workloads, GPUs, and Kubernetes control planes.

With `WhizardTelemetry Monitoring`, you can deploy and manage the following components:

- Kube-Prometheus-Stack
  
  Kube-Prometheus-Stack is a monitoring stack for Kubernetes clusters and the applications running on them, using Prometheus. It includes Prometheus Operator, kube-state-metrics, node-exporter, and other components, as well as configuration lists for collecting Kubernetes component metrics and related Prometheus rules.

- Whizard Monitoring Helper

  A helper tool for deploying `WhizardTelemetry Monitoring`.

- DCGM-Exporter

  DCGM-Exporter is an exporter for collecting Nvidia GPU performance and health metrics.

- cAdvisor

  Supports independent deployment of cAdvisor for exporting container resource usage and performance metrics (cAdvisor is already integrated in kubelet, and in normal scenarios, separate deployment is not needed).

### API Updates

- Monitoring APIs have been integrated into the `WhizardTelemetry Platform Service`. For API changes, refer to the [WhizardTelemetry Platform Service changelog](https://github.com/kubesphere-extensions/ks-extensions/tree/main/whizard-telemetry/CHANGELOG_en.md#api-updates).

### Features

- Kube-Prometheus-Stack is fully compatible with the community project [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus).
- DCGM-Exporter has optimized the default metric configurations, supporting the collection of more GPU metrics.
- Supports the independent deployment of cAdvisor to resolve missing key labels for container metrics in Kubernetes 1.24 and above when using Docker Engine, which previously caused container monitoring data to not display.

### Enhancements

- Optimized the recording rules configuration in Kube-Prometheus-Stack to synchronize with the latest community updates.
- Improved the recording rules configuration in Kube-Prometheus-Stack to enhance stability.
- Optimized resource quotas for Kube-Prometheus-Stack components by trimming unused metrics to improve performance.

### Misc

- Upgraded Prometheus Operator to v0.75.1
- Upgraded Prometheus to v2.51.2
- Upgraded kube-state-metrics to v2.12.0
- Upgraded node-exporter to v1.8.1
- Upgraded DCGM-Exporter to 3.3.5-3.4.0
