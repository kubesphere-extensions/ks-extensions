<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.0

### 新特性

- 支持工作负载关联多个 ippool


### 缺陷修复

- 修复创建 ippool 时，未自动填充 IP 池块大小（blocksize）
- 修复选择 IP 池时列表的“刷新”、“清空”操作不正确
- 修复在工作负载中创建新 IP 池的权限问题

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.0.0

这是 Kubesphere 网络扩展组件的第一个正式版本。

该插件从 kubesphere 中抽离出来，目前包含有 IPPool 和 NetworkPolicy的管理配置，同时该组件也有一部分架构的变化和新特性的增加。 
- IPPool 弃用了原有的 kubesphere 封装的管理方式（ippools.network.kubesphere.io），直接管理 calico ippool（ippools.crd.projectcalico.org），避免与其他的三方管理工具冲突；同时支持 calico ippool 更多字段的配置
- NetworkPolicy 主要优化了用户在项目下网络隔离的外部白名单的操作的友好性。

### API 更新
- ippool 更新为 ippools.crd.projectcalico.org/v1，更多 API 细节可参考[Network API 参考](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/network/api_doc.md)及[Swagger](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/network/swagger.yaml)

### 弃用
- 弃用 ippool 绑定到企业空间，但支持原生 calico ippool 绑定 namespace 的操作
- 正式移除 network.kubesphere.io/v1alpha1 中的 ippools、ipamblocks、ipamhandles

### 新特性
- 支持用户通过 yaml 创建 IP 池以及 yaml 的动态编辑
- 支持 IP 池 nodeSelector、NatOutgoing 等更多字段的 ui 化配置
- 支持项目网络隔离外部白名单的端口范围的配置
- 支持项目网络隔离外部白名单的多网段、多端口的配置
- 支持项目网络隔离外部白名单的配置、基本信息的动态修改


