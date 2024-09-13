## v1.1.0

`WhizardTelemetry 监控` 是 WhizardTelemetry 可观测平台中提供监控功能的扩展组件，可提供多租户视角的云原生资源监控能力, 包括针对集群, 节点, 工作负载、GPU、K8s 控制面等对象的核心监控指标实时和历史数据展示等功能。

可通过 `WhizardTelemetry 监控` 部署与管理如下组件：

- Kube-Prometheus-Stack
  
  Kube-Prometheus-Stack 是使用 Prometheus 监控 Kubernetes 集群及运行在上面的应用监控栈，包含 Prometheus Operator、kube-state-metrics、node-exporter 等组件，以及 Kubernetes 组件指标收集配置清单和相关 Prometheus Rules。

- Whizard Monitoring Helper

  便于部署 `WhizardTelemetry 监控` 的助手工具

- DCGM-Exporter

  DCGM-Exporter 是一个用于收集 Nvidia GPU 性能和健康度指标的指标导出器。

- cAdvisor

  支持独立部署 cAdvisor， 用于容器的资源使用和性能数据的指标导出(默认 cAdvisor 已集成 kubelet 中，正常场景下无需部署)。

### API 更新

- 监控 API 已集成入 `WhizardTelemetry 平台服务` 中，API 变更请参考 [WhizardTelemetry 平台服务变更日志](https://github.com/kubesphere-extensions/ks-extensions/tree/main/whizard-telemetry/CHANGELOG_zh.md#api-%E6%9B%B4%E6%96%B0)

### 新特性

- Kube-Prometheus-Stack 与社区项目 [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) 完全兼容
- DCGM-Exporter 优化默认指标配置，支持更多 GPU 指标采集
- 支持单独部署 cAdvisor，用于修复 Kubernetes 1.24 及以上版本在使用 Docker Engine 的场景下容器指标的关键标签缺失，容器监控无法展示问题。

### 优化

- 优化 Kube-Prometheus-Stack 中 recording rules 配置，同步社区最新更新
- 优化 Kube-Prometheus-Stack 中 recording rules 配置，增强稳定性
- 优化 Kube-Prometheus-Stack 各组件资源配额，剪裁无用指标，提升性能

### 其他

- 升级 Prometheus Operator 至 v0.75.1
- 升级 Prometheus 至 v2.51.2
- 升级 kube-state-metrics 至 v2.12.0
- 升级 node-exporter 至 v1.8.1
- 升级 DCGM-Exporter 至 3.3.5-3.4.0
