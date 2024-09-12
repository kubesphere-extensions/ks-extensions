<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.2.2

### Features

- Support filtering logs by namespace and pod.
- Support using Loki as the backend storage for logs.
- Support customizing the index format of OpenSearch when using it as the backend storage.
- Introduce calico CNI log collection, allowing querying of information such as IP allocation and release for pods by calico.

### Enhancements

- Support nanosecond-level sorting queries when using OpenSearch as the backend storage.

### Bug Fixes

- Fix the issue where the Log Receiver page is blank.
- Fix wrong display of time range for topology graphs on the Container Log Search page.
- Fix the issue where the page crashes when empty logs are present during container log keyword queries.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.0.0

`WhizardTelemetry 日志` 是 WhizardTelemetry 可观测平台中用于日志采集、处理、存储和查询的扩展组件。 可通过 WhizardTelemetry 日志 部署与管理如下组件：

- logsidecar-injector：用于采集 Pod 中容器输出的落盘日志（不同于普通容器输出到 stdout 的日志）
- K8s 日志采集与转换
- 缺省的 OpenSearch sink

### 缺陷修复

- 修复了日志查询前端页面访问缓慢的问题

### 新特性

- 新增 vector 作为缺省的落盘日志采集 agent
- 原每个集群都会部署的 OpenSearch 改为可以多集群共用，不同的集群会创建以集群名称为前缀的 index
- 支持一部分集群（可用区 a 或部门 a）输出日志到一个 OpenSearch，另一部分集群（可用区 b 或部门 b）输出日志到不同的 OpenSearch，经过配置后可在同一日志控制台进行查询。具体细节请参考 [README](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-logging/README.md)


### 弃用

- 原用作采集落盘日志的 filebeat 已被废弃并将在后续版本移除
