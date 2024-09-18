# HTTP API

HTTP API 可从扩展组件 apiserver 的 `/alerting.kubesphere.io/v2beta1` 路径下访问。当与 KSE 4.x 集成并通过 KubeSphere APIServer（提供用户授权和认证）发起 API 请求时，请添加额外的 `/proxy` 前缀，即从 KubeSphere APIServer 的 `/proxy/alerting.kubesphere.io/v2beta1` 路径下访问。

## 项目层级

| 操作 | Http 方法 | 请求子路径
| --- | --- | ---
| 创建一个项目级规则组 | POST |  `/clusters/{cluster}/namespaces/{namespace}/rulegroups`
| 更新一个项目级规则组 | PUT/PATCH | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| 获取一个项目级规则组 | GET | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| 列出项目级规则组 | GET | `/clusters/{cluster}/namespaces/{namespace}/rulegroups`
| 删除一个项目级规则组 | DELETE | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| 列出项目级规则组的告警 | GET | `/clusters/{cluster}/namespaces/{namespace}/alerts`

## 集群层级

| 操作 | Http 方法 | 请求子路径
| --- | --- | ---
| 创建一个集群级规则组 | POST |  `/clusters/{cluster}/clusterrulegroups`
| 更新一个集群级规则组 | PUT/PATCH | `/clusters/{cluster}/clusterrulegroups/{name}`
| 获取一个集群级规则组 | GET | `/clusters/{cluster}/clusterrulegroups/{name}`
| 列出集群级规则组 | GET | `/clusters/{cluster}/clusterrulegroups`
| 删除一个集群级规则组 | DELETE | `/clusters/{cluster}/clusterrulegroups/{name}`
| 列出集群级规则组的告警 | GET | `/clusters/{cluster}/clusteralerts`

当未启用可观测中心时，内置规则组在集群层级进行管理，进行查询请求时，可添加一个 `builtin` 请求参数：
`builtin=true` 表示请求内置规则组，`builtin=false` 表示请求集群层级的自定义规则组。

## 全局层级

仅在启用可观测中心的场景支持。

| 操作 | Http 方法 | 请求子路径
| --- | --- | ---
| 创建一个全局级规则组 | POST |  `/globalrulegroups`
| 更新一个全局级规则组 | PUT/PATCH | `/globalrulegroups/{name}`
| 获取一个全局级规则组 | PUT/PATCH | `/globalrulegroups/{name}`
| 列出全局级规则组 | GET | `/globalrulegroups`
| 删除一个全局级规则组 | DELETE | `/globalrulegroups/{name}`
| 列出全局级规则组的告警 | GET | `/globalalerts`

进行查询请求时，可添加一个 `builtin` 请求参数：
`builtin=true` 表示请求内置规则组，`builtin=false` 表示请求全局层级的自定义规则组。

## 对比 KSE 3.5

与 KSE 3.5 相比，API 更新主要体现在请求路径的变更上，具体如下：

| 操作(Operation) | Http 方法 | KSE 3.5 | KSE 4.1 (需添加前缀 `/proxy/alerting.kubesphere.io/v2beta1`)
| --- | --- | --- | ---
| 创建一个项目级规则组 | POST | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups` | `/clusters/{cluster}/namespaces/{namespace}/rulegroups` 
| 更新一个项目级规则组 | PUT/PATCH |	`/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups/{name}` | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| 列出项目级规则组 | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups` | `/clusters/{cluster}/namespaces/{namespace}/rulegroups`
| 获取一个项目级规则组 | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups/{name}` |	`/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| 删除一个项目级规则组 | DELETE | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups/{name}`	| `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| 列出项目级规则组的告警 | GET	| `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/alerts` | `/clusters/{cluster}/namespaces/{namespace}/alerts`
| 创建一个集群级规则组 | POST | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups` | `/clusters/{cluster}/clusterrulegroups`
| 更新一个集群级规则组 | PUT/PATCH | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups/{name}` | `/clusters/{cluster}/clusterrulegroups/{name}`
| 列出集群级规则组(非内置) | GET	| `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups` | `/clusters/{cluster}/clusterrulegroups?builtin=false`
| 获取一个集群级规则组 | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups/{name}` |	`/clusters/{cluster}/clusterrulegroups/{name}`
| 删除一个集群级规则组 | DELETE | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups/{name}` | `/clusters/{cluster}/clusterrulegroups/{name}`
| 列出集群级规则组(非内置)的告警 | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusteralerts` | `/clusters/{cluster}/clusteralerts?builtin=false`
| 更新一个内置规则组<br/>(未启用可观测中心场景)  | PUT/PATCH |	`/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` |	`/clusters/{cluster}/clusterrulegroups/{name}`
| 列出内置规则组<br/>(未启用可观测中心场景) | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalrulegroups` | `/clusters/{cluster}/clusterrulegroups?builtin=true`
| 获取一个内置规则组<br/>(未启用可观测中心场景) | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/clusters/{cluster}/clusterrulegroups/{name}`
| 列出内置规则组的告警<br/>(未启用可观测中心场景) | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalalerts` |	`/clusters/{cluster}/clusteralerts?builtin=true`
| 创建一个全局级规则组 | POST | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups` | `/globalrulegroups`
| 更新一个全局级规则组 | PUT/PATCH | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| 列出全局级规则组(非内置) | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalrulegroups?builtin=false` | `/globalrulegroups?builtin=false`
| 获取一个全局级规则组 | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| 删除一个全局级规则组 | DELETE | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| 列出全局级规则组(非内置)的告警 | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalalerts?builtin=false` | `/globalalerts?builtin=false`
| 更新一个全局级规则组 | PUT/PATCH | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| 列出内置规则组<br/>(启用可观测中心场景) | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalrulegroups?builtin=true` | `/globalrulegroups?builtin=true`
| 列出内置规则组的告警<br/>(启用可观测中心场景) | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalalerts?builtin=true` | `/globalalerts?builtin=true`

请求体和响应的数据结构保持不变。

更多细节请参考 [Swagger API 文档](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-alerting/swagger.yaml)。
