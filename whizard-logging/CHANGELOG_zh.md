<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.2.2

### 新特性

- 支持根据 namespace 和 pod 过滤日志
- 支持使用 Loki 作为日志后端存储
- 使用 OpenSearch 作为后端存储时支持自定义 OpenSearch 的索引格式
- 新增 calico CNI 日志收集，可查询 calico 为 pod 分配和释放 ip 等信息

  
### 优化

- 使用 OpenSearch 作为后端存储时支持纳秒级排序查询

### 缺陷修复

- 修复日志接收器无法显示的问题
- 修复容器日志查询页面中的时间拓扑图显示时间范围异常的问题
- 修复容器日志关键字查询，在存在空日志时页面崩溃的问题

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
- 支持一部分集群（可用区 a 或部门 a）输出日志到一个 OpenSearch，另一部分集群（可用区 b 或部门 b）输出日志到不同的 OpenSearch，经过配置后可在同一日志控制台进行查询。具体细节请参考 [README](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-logging/README_zh.md)


### 弃用

- 原用作采集落盘日志的 filebeat 已被废弃并将在后续版本移除


