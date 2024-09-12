# WhizardTelemetry 日志、事件开发者文档

## 概述

WhizardTelemetry 提供了对日志、事件等数据的查询接口。

* 组件可脱离 KubeSphere 独立进行迭代, 更及时的满足用户的需求；
* 组件代码更轻量, 且与 KubeSphere Core 松耦合, 开发更易上手；

## 系统架构

WhizardTelemetry 查询后端主要分为两部分, OpenSearch 存储 与 Whizard-Telemetry APIServer.

### WhizardTelemetry APIServer

WhizardTelemetry APIServer 是 KubeSphere 团队开发的 WhizardTelemetry 可观测平台中各扩展组件的公共服务。它是各个可观测性扩展组件通用的 APIServer，为所有可观测性扩展组件提供公共的后端平台服务。

## WhizardTelemetry API 参考

### 查询

| 资源聚合查询描述                                            | uri                                            |
|:----------------------------------------------------|:-----------------------------------------------|
| 日志查询                                                | /kapis/logging.kubesphere.io/v1alpha2/logging  |
| 事件查询                                                | /kapis/logging.kubesphere.io/v1alpha2/events   |

以日志查询为例， 提供以下资源过滤的 Query Parameter 提供：

```go
Param(ws.QueryParameter("operation", "Operation type. This can be one of four types: query (for querying logs), statistics (for retrieving statistical data), histogram (for displaying log count by time interval) and export (for exporting logs). Defaults to query.").DefaultValue("query").DataType("string").Required(false)).
Param(ws.QueryParameter("namespaces", "A comma-separated list of namespaces. This field restricts the query to specified namespaces. For example, the following filter matches the namespace my-ns and demo-ns: `my-ns,demo-ns`").DataType("string").Required(false)).
Param(ws.QueryParameter("namespace_query", "A comma-separated list of keywords. Differing from **namespaces**, this field performs fuzzy matching on namespaces. For example, the following value limits the query to namespaces whose name contains the word my(My,MY,...) *OR* demo(Demo,DemO,...): `my,demo`.").DataType("string").Required(false)).
Param(ws.QueryParameter("workloads", "A comma-separated list of workloads. This field restricts the query to specified workloads. For example, the following filter matches the workload my-wl and demo-wl: `my-wl,demo-wl`").DataType("string").Required(false)).
Param(ws.QueryParameter("workload_query", "A comma-separated list of keywords. Differing from **workloads**, this field performs fuzzy matching on workloads. For example, the following value limits the query to workloads whose name contains the word my(My,MY,...) *OR* demo(Demo,DemO,...): `my,demo`.").DataType("string").Required(false)).
Param(ws.QueryParameter("pods", "A comma-separated list of pods. This field restricts the query to specified pods. For example, the following filter matches the pod my-po and demo-po: `my-po,demo-po`").DataType("string").Required(false)).
Param(ws.QueryParameter("pod_query", "A comma-separated list of keywords. Differing from **pods**, this field performs fuzzy matching on pods. For example, the following value limits the query to pods whose name contains the word my(My,MY,...) *OR* demo(Demo,DemO,...): `my,demo`.").DataType("string").Required(false)).
Param(ws.QueryParameter("containers", "A comma-separated list of containers. This field restricts the query to specified containers. For example, the following filter matches the container my-cont and demo-cont: `my-cont,demo-cont`").DataType("string").Required(false)).
Param(ws.QueryParameter("container_query", "A comma-separated list of keywords. Differing from **containers**, this field performs fuzzy matching on containers. For example, the following value limits the query to containers whose name contains the word my(My,MY,...) *OR* demo(Demo,DemO,...): `my,demo`.").DataType("string").Required(false)).
Param(ws.QueryParameter("log_query", "A comma-separated list of keywords. The query returns logs which contain at least one keyword. Case-insensitive matching. For example, if the field is set to `err,INFO`, the query returns any log containing err(ERR,Err,...) *OR* INFO(info,InFo,...).").DataType("string").Required(false)).
Param(ws.QueryParameter("interval", "Time interval. It requires **operation** is set to histogram. The format is [0-9]+[smhdwMqy]. Defaults to 15m (i.e. 15 min).").DefaultValue("15m").DataType("string").Required(false)).
Param(ws.QueryParameter("start_time", "Start time of query. Default to 0. The format is a string representing seconds since the epoch, eg. 1559664000.").DataType("string").Required(false)).
Param(ws.QueryParameter("end_time", "End time of query. Default to now. The format is a string representing seconds since the epoch, eg. 1559664000.").DataType("string").Required(false)).
Param(ws.QueryParameter("sort", "Sort order. One of asc, desc. This field sorts logs by timestamp.").DataType("string").DefaultValue("desc").Required(false)).
Param(ws.QueryParameter("from", "The offset from the result set. This field returns query results from the specified offset. It requires **operation** is set to query. Defaults to 0 (i.e. from the beginning of the result set).").DataType("integer").DefaultValue("0").Required(false)).
Param(ws.QueryParameter("size", "Size of result to return. It requires **operation** is set to query. Defaults to 10 (i.e. 10 log records).").DataType("integer").DefaultValue("10").Required(false)).
Param(ws.QueryParameter("cluster", "cluster name.").DataType("string").DefaultValue("host").Required(false)).
```

### Swagger API

请参见 [SwaggerAPI](https://github.com/WhizardTelemetry/WhizardTelemetry/blob/main/api/openapi-spec/swagger.json).