<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.3 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.0.2

### 优化

- 应用商店页面新增使用说明

### 缺陷修复

- 修复应用管理功能中无法上传新版本应用的问题
- 修复应用商店管理，分类展示不完整的问题
- 修复应用详情中资源状态展示不完整的问题
- 修复上传 chart 应用时重复发送请求的问题

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.0.1

### 缺陷修复

- 修复应用分类超过 10 条后不显示的问题
- 修复潜在的应用名称过长的问题
- 修复潜在的 repo 同步不执行问题
- 修复 tower 模式下的集群无法安装应用的问题

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.0.0
重构了应用商店实现, 简化逻辑, 支持了yaml应用

- 支持了yaml应用
- 支持了全局repo源配置

### 弃用
- 移除了 openpitrix.io/v1系列的 api
- 移除了manifests.application.kubesphere.io 系列api

### API 更新
- 增加了一个创建yaml应用的API
- 使用ks平台统一的分页,筛选条件查询

### 新特性
- 支持了yaml应用

### 优化
- 简化了repo同步的逻辑

### 缺陷修复
- 修复了安装helm应用crd不能立即使用的问题

