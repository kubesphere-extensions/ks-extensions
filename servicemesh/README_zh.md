## 核心功能

- 蓝绿部署：创建相同备用环境并运行新应用版本，确保避免宕机或者服务中断。
- 金丝雀发布：缓慢地向一小部分用户推送变更，将版本升级风险降到最低。
- 流量镜像：复制实时生产流量并发送至镜像服务。
- 流量监控：可视化展示各个微服务间的流量情况，支持用户支持配置限流熔断。
- 链路追踪：可视化展示各个微服务间相互的调用关系、跨度与耗时等关键信息。

## 安装

- 通过 扩展市场 页面找到 KubeSphere 服务网格 扩展组件，选择最新版本，点击 下一步 按钮；
- 在 扩展组件安装 标签页面中，根据需求点击并修改 扩展组件配置， 配置完成后，点击 安装 按钮， 开始安装；
- 安装完成后， 点击 下一步 按钮，进入集群选择页面，勾选需要安装的集群，点击 下一步 按钮，进入 差异化配置 页面；
- 根据需求更新 差异化配置，更新完成，开始安装，静待安装完成。

## 注意事项

- 需要在配置中配置可用的 Prometheus 服务和 OpenSearch 服务后，方可使用 KubeSphere 服务网格的相关功能。


| 参数                                             | 含义                 | 默认值                                                               | 取值 |
| ------------------------------------------------ | -------------------- | -------------------------------------------------------------------- | -------- |
| backend.istio.meshConfig.defaultConfig.tracing.sampling | 链路追踪采样率       | 1.0                                                                  | 1-100    |
| backend.kiali.prometheus_url                     | promethus 地址       | http://prometheus-k8s.kubesphere-monitoring-system.svc:9090     |          |
| backend.jaeger.storage.options.es.server-urls           | OpenSearch/ES 地址   | https://opensearch-cluster-data.kubesphere-logging-system.svc:9200 |          |
| backend.jaeger.storage.options.es.username              | OpenSearch/ES 账户名 | admin                                                                |          |
| backend.jaeger.storage.options.es.password              | OpenSearch/ES 密码   | admin                                                                |          |
| backend.jaeger.storage.options.secretName         |         OpenSearch/ES 访问 Secret 名             |                                                                      |          |
