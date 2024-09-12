# WhizardTelemetry 监控开发者文档

## 概述

WhizardTelemetry 监控是 KubeSphere 提供的云原生可观测平台里提供监控功能的扩展组件。其中包含了 Whizard 可观测中心，可提供多租户视角的云原生资源监控能力, 包括针对多集群, 节点, 工作负载、GPU、K8s 控制面等对象的核心监控指标实时和历史数据展示等功能。

WhizardTelemetry 监控是建立在 [Kube-Prometheus-Stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) 上的定制化解决方案, 为用户提供丰富的仪表板和功能, 帮助用户实时监控  Kubernetes 集群的健康状况和性能.

WhizardTelemetry 监控是基于 [KubeSphere 4.0 扩展机制](https://dev-guide.kubesphere.io/extension-dev-guide/zh/overview/) 开发, 拥有如下特点:

* 组件可脱离 KubeSphere 独立进行迭代, 更及时的满足用户的需求；
* 组件代码更轻量, 且与 KubeSphere Core 松耦合, 开发更易上手；
* 兼容原生 [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus),  可基于已有原生监控栈进行部署;
* 后续会支持更多常见、成熟的应用监控接入;

## 系统架构

WhizardTelemetry 监控后端主要分为两部分, 定制化的 Kube-Prometheus-Stack 与 Whizard-Telemetry APIServer.

### 定制化的 Kube-Prometheus-Stack

定制化的 Kube-Prometheus-Stack 借助 [Prometheus-Operator](https://github.com/prometheus-operator/prometheus-operator) 项目，通过自定义资源定义（Custom Resource Definitions，CRD）描述和管理 Prometheus 和 Alertmanager 的配置，监控规则、服务发现等。

Prometheus 定期从 Kube-State-Metrics、 Node-Exporter、 Kubelet 等组件中抓取指标数据，并将其存储在 TSDB 中。Prometheus 使用自己的查询语言 PromQL 来查询和分析这些指标。如果检测到警报条件满足，Prometheus将生成警报，并将其发送给 Alertmanager。

![prom-stack-arch](https://github.com/WhizardTelemetry/WhizardTelemetry/blob/main//docs/img/prometheus-stack-architecture.png)

WhizardTelemetry 监控与 [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) 完全兼容，如果您已基于 kube-prometheus 进行部署，可参照 [Kube-Prometheus-Stack 定制](#kube-prometheus-stack-定制) 进行调整， 以满足 WhizardTelemetry 监控展示需求。

### WhizardTelemetry APIServer

WhizardTelemetry APIServer 是 KubeSphere 团队开发的 WhizardTelemetry 可观测平台中各扩展组件的公共服务。它是各个可观测性扩展组件通用的 APIServer，为所有可观测性扩展组件提供公共的后端平台服务。

## 接入参考

### 服务发现接入

WhizardTelemetry 监控是基于 [Prometheus-Operator](https://github.com/prometheus-operator/prometheus-operator) 项目，通过 CRD 进行配置、管理和维护监控资源的。因此服务发现也接入也推荐使用  [PodMonitor](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#monitoring.coreos.com/v1.PodMonitor) 和 [ServiceMonitor](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#monitoring.coreos.com/v1.ServiceMonitor)。

注意： 为避免环境同时部署多个 Prometheus 后监控目标过多或杂乱，可能会开启 ServiceMonitorSelector 及 PodMonitorSelector 进行过滤，建议 ServiceMonitor 及 PodMonitor 增加 KubeSphere 通用的label `app.kubernetes.io/vendor=kubesphere`， 以便能正常选择并采集。

### 查询接入

#### 1. 通过 WhizardTelemetry Monitoring API 查询

WhizardTelemetry Monitoring API 是在 Prometheus Query API 之上的封装实现，它内置大量指标查询模版，对指标进行聚合计算，同时支持并发查询、分页查询、指标排序等诸多能力。您可以通过 API 参考章节详细查看。

#### 2. 通过原生 Prometheus Query API 查询

您也可以通过 Prometheus Query API 查询，请参考 [Prometheus Querying API](https://prometheus.io/docs/prometheus/latest/querying/api/)， Prometheus 的默认端点为 `prometheus-k8s.kubesphere-monitoring-system.svc:9009`。

### 告警接入

尽管 WhizardTelemetry 监控允许您通过原生 PrometheusRule 直接创建告警规则，但还是推荐您通过 [WhizardTelemetry 告警](https://github.com/WhizardTelemetry/WhizardAlerting/) 进行管理和下发告警。

### 自定义监控接入

您可以参考 [自定义应用监控-可视化](https://kubesphere.io/zh/docs/v3.4/project-user-guide/custom-application-monitoring/visualization/overview/) 来接入 KubeSphere 自定义监控。

### Grafana 接入

您可以将 Prometheus 的端点 `prometheus-k8s.kubesphere-monitoring-system.svc:9009` 作为数据源接入 Grafana。

## Kube-Prometheus-Stack 定制

### Metrics 裁剪

Kube-Prometheus-Stack 默认会采集大量的指标数据，为了减少数据存储和查询的压力，我们可以对指标进行裁剪。裁剪指标的常见方式有两种：

  1. 通过 ServiceMonitor 和 PodMonitor 的 metricRelabelings 选择性采集指标；
  2. 部分应用提供的参数允许选择暴露指标，如 node-exporter、 kube-state-metrics 等。

因此，定制的 `kube-prometheus-stack` 对指标进行了裁剪，你可以参考 [kube-prometheus-stack](https://github.com/WhizardTelemetry/prometheus-charts/tree/main/charts/kube-prometheus-stack) 进行调整。

### Recording Rules 定制

定制的 `kube-prometheus-stack` 完全继承了 [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) 的 Recording Rules，同时也增加了一些自定义的 Recording Rules, 用于界面展示及告警规则的支持。您可以参考 [ks-prometheus](https://github.com/WhizardTelemetry/prometheus-charts/blob/main/ks-prometheus/manifests/whizard-telemetry-prometheusRule.yaml) 项目定制。

如果您基于 [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) 部署 Kube-Prometheus-Stack，请务必加载自定义的 Recording Rules，以保证 WhizardTelemetry 监控一切正常。

## WhizardTelemetry Monitoring API 参考

### 说明

WhizardTelemetry Monitoring API 在保有原来 API 监控风格的前提下，有了较大的调整及变更。
首先，它调整并优化了多集群监控 API，由 KubeSphere 进行转发改为自行选择转发，解决引入 [Whizard 可观测中心](https://github.com/WhizardTelemetry/whizard) 后多集群监控链路过长转发不合理等问题；
其次，它优化自定义组件查询， 您可以配合更新 [内置监控查询模版](#内置监控查询模版)，将新的组件查询集成化内置到 WhizardTelemetry Monitoring API 中；
最后，WhizardTelemetry Monitoring API 屏蔽了底层监控组件部署架构(单集群/多集群/ Whizard 可观测中心)，实现统一 Monitoring API 接口。

### 1. 监控资源聚合查询

资源聚合查询类的 API 是 WhizardTelemetry Monitoring API 最为常见的 API 类型，我们以 cluster 为例，cluster_pod_count、cluster_cpu_utilisation 分别为以 cluster 为粒度，对集群 pod 数量、集群节点 cpu 使用率进行聚合计算； 内置监控查询模版中 cluster_{resource_name}_{type} 中则全是以 cluster 为粒度资源聚合查询计算模版。同理，其他资源聚合查询也是如此。

| 资源聚合查询描述                                                       | uri                                                                   |
|:------------------------------------------------------------------- |:--------------------------------------------------------------------- |
| 对 Cluster 资源聚合查询                                                | /kapis/monitoring.kubesphere.io/v1beta1/cluster_metrics               |
| 对 Node 资源聚合查询                                                   | /kapis/monitoring.kubesphere.io/v1beta1/node_metrics                  |
| 对 KubeSphere 企业空间资源聚合查询                                      | /kapis/monitoring.kubesphere.io/v1beta1/workspace_metrics             |
| 对 Namespace 资源聚合查询                                              | /kapis/monitoring.kubesphere.io/v1beta1/namespace_metrics             |
| 对 Workload 资源聚合查询                                               | /kapis/monitoring.kubesphere.io/v1beta1/workload_metrics              |
| 对 Pod 资源聚合查询                                                    | /kapis/monitoring.kubesphere.io/v1beta1/pod_metrics                   |
| 对 Container 资源聚合查询                                              | /kapis/monitoring.kubesphere.io/v1beta1/container_metrics             |
| 对 PVC 资源聚合查询                                                    | /kapis/monitoring.kubesphere.io/v1beta1/persistentvolumeclaim_metrics |
| 对自定义的组件的聚合查询，内置有Etcd、Kube-APiserver、Kube-Scheduler等     | /kapis/monitoring.kubesphere.io/v1beta1/component_metrics             |

以 Pod 资源聚合查询为例， 提供以下资源过滤的 Query Parameter 提供：

```go
Param(ws.QueryParameter("cluster", "Cluster name.").DataType("string").Required(false)).
Param(ws.QueryParameter("cluster_resources_filter", "The cluster filter consists of a regexp pattern. It specifies which cluster data to return.").DataType("string"Required(false)).
Param(ws.QueryParameter("node", "Node name.").DataType("string").Required(false)).
Param(ws.QueryParameter("node_resources_filter", "The node filter consists of a regexp pattern. It specifies which node data to return.").DataType("string").Requir(false)).
Param(ws.QueryParameter("worksapce", "Workspace name.").DataType("string").Required(false)).
Param(ws.QueryParameter("workspace_resources_filter", "The workspace filter consists of a regexp pattern. It specifies which workspace data to return.`.").DataTy("string").Required(false)).
Param(ws.QueryParameter("namespace", "Namespace name.").DataType("string").Required(false)).
Param(ws.QueryParameter("namespace_resources_filter", "The namespace filter consists of a regexp pattern. It specifies which namespace data to return.").DataTy("string").Required(false)).
Param(ws.QueryParameter("workload_name", "Workload name.").DataType("string").Required(false)).
Param(ws.QueryParameter("workload_resources_filter", "The workload name filter consists of a regexp pattern. It specifies which workload name data to return.").DataTy("string").Required(false)).
Param(ws.QueryParameter("pod", "Pod name.").DataType("string").Required(false)).
Param(ws.QueryParameter("resources_filter", "The pod filter consists of a regexp pattern. It specifies which pod data to return.").DataType("string").Required(false)).
```

通过上述资源过滤的 Query Parameter，可以定位及聚合查询到指定资源的监控数据。

除了以上资源选择的 Params 外，还会有以下常见 Query Parameters:

```go
Param(ws.QueryParameter("metrics_filter", "The metric name filter consists of a regexp pattern. It specifies which metric data to return. For example, the following filter matches both pod CPU usage and memory usage: `pod_cpu_usage|pod_memory_usage`.").DataType("string").Required(false)).
Param(ws.QueryParameter("start", "Start time of query. Use **start** and **end** to retrieve metric data over a time span. It is a string with Unix time format, eg. 1559347200. ").DataType("string").Required(false)).
Param(ws.QueryParameter("end", "End time of query. Use **start** and **end** to retrieve metric data over a time span. It is a string with Unix time format, eg. 1561939200. ").DataType("string").Required(false)).
Param(ws.QueryParameter("step", "Time interval. Retrieve metric data at a fixed interval within the time range of start and end. It requires both **start** and **end** are provided. The format is [0-9]+[smhdwy]. Defaults to 10m (i.e. 10 min).").DataType("string").DefaultValue("10m").Required(false)).
Param(ws.QueryParameter("time", "A timestamp in Unix time format. Retrieve metric data at a single point in time. Defaults to now. Time and the combination of start, end, step are mutually exclusive.").DataType("string").Required(false)).
Param(ws.QueryParameter("sort_metric", "Sort pods by the specified metric. Not applicable if **start** and **end** are provided.").DataType("string").Required(false)).
Param(ws.QueryParameter("sort_type", "Sort order. One of asc, desc.").DefaultValue("desc.").DataType("string").Required(false)).
Param(ws.QueryParameter("page", "The page number. This field paginates result data of each metric, then returns a specific page. For example, setting **page** to 2 returns the second page. It only applies to sorted metric data.").DataType("integer").Required(false)).
Param(ws.QueryParameter("limit", "Page size, the maximum number of results in a single page. Defaults to 5.").DataType("integer").Required(false).DefaultValue("5")).
```

这些 Query Parameters 则用于设置查询的指标名称，时间戳或时刻、排序、分页等操作。

### 2. 临时查询及元数据查询

临时查询则是用户根据需求自行构建 PromQL 表达式，进行直接查询并返回结果。可以设置查询的时间戳，时间段等，也可以对指定集群进行查询限制、查询指定集群指定命名空间

```yaml
/kapis/monitoring.kubesphere.io/v1beta1/targets/query
```

元数据查询用于监控数据中指标名称、标签值等，同样可设置集群及命名空间的限定查询。

```yaml
/kapis/monitoring.kubesphere.io/v1beta1/targets/metadata
/kapis/monitoring.kubesphere.io/v1beta1/targets/labelsets
/kapis/monitoring.kubesphere.io/v1beta1/targets/labelvalues
```

详细的 API 及 params 可参考 [SwaggerAPI](https://github.com/WhizardTelemetry/WhizardTelemetry/blob/main/api/openapi-spec/swagger.json)。

### 3. 自定义组件查询

用于内置组件 ETCD/Kube-APIServer/Kube-Scheduler 等查询。您也可以参考 [Ingress 内置查询模版](https://github.com/WhizardTelemetry/WhizardTelemetry/blob/main/tools/cmd/monitoring-query-template-gen/main.go)，增加新的自定义组件并维护模版，将内置组件查询到 WhizardTelemetry Monitoring API 中，可参考该 PR [add ingress metrics](https://github.com/WhizardTelemetry/WhizardTelemetry/pull/130) 实现及代码提交。

```yaml
/kapis/monitoring.kubesphere.io/v1beta1/component_metrics
```

### Swagger API

请参见 [SwaggerAPI](https://github.com/WhizardTelemetry/WhizardTelemetry/blob/main/api/openapi-spec/swagger.json).

### 内置监控查询模版

请参见 [internal-monitoring-query-template](https://github.com/WhizardTelemetry/WhizardTelemetry/blob/main/docs/internal-monitoring-query-template.md).