# 更新日志

## 0.4.0 (发布于 2025.04.21)

### 新功能
1. 支持管理跨多个 K8s 集群的 obcluster。
2. 添加租户恢复页面。

### 增强功能
1. 创建 obcluster 时支持指定 proxyro 密码。
2. 支持管理节点标签和污点。
3. 增强 obcluster 参数管理。
4. 添加对创建后修改 OBCluster 的支持。

## 0.3.3 (发布于 2025.01.16)

### 新功能
1. 创建 OBCluster 时支持设置亲和性、污点容忍和节点选择器。
2. 支持设置独立 PVC 和删除保护。

### 增强功能
1. 添加对独立 PVC 生命周期和删除保护的支持。
2. 添加对删除和重启特定 OBServers 的支持。
3. 添加对设置 OBCluster 和 OBTenant 的优化场景的支持。
4. 添加对创建后修改 OBCluster 的支持。

### 错误修复
1. 修复编辑备份策略时的无限刷新问题。

## 0.3.2 (发布于 2024.11.08)

### 错误修复
1. 优化 obproxy 参数搜索。
2. 通过从指标服务器获取数据优化节点资源查询。
3. 修复告警规则中的错误配置。
4. 修复设置亲和性时的场景。
5. 删除集群时适配路由。
6. 优化状态和调度时间显示。

## 0.3.1 (发布于 2024.09.06)

### 新功能
1. 添加访问控制模块。

### 错误修复
1. 修复存储值以字节单位打印的错误。

## 0.3.0 (发布于 2024.06.28)

### 新功能
1. 添加对告警管理的支持。
2. 添加对 OBProxy 管理的支持。
3. 添加通过 ODC 临时会话连接数据库的支持。

### 错误修复
1. 修复租户的拓扑图显示规格而非状态的错误。

## 0.2.1 (发布于 2024.04.25)

### 新功能
1. 在连接选项卡中添加对连接集群 sys 和租户的支持。

### 错误修复
1. 修复服务模式下 OBCluster 中显示的错误 IP。
2. 移除租户名称中不允许使用数字的限制。
3. 修复从备份数据恢复后同步主租户时发生的错误。

## 0.2.0 (发布于 2024.04.12)

### 新功能
1. 租户管理：我们引入了全面的租户管理工具，使您能够轻松处理 OceanBase 集群中的多个租户。这对于完成 Dashboard 的功能至关重要。
2. 租户监控：实时监控各个租户的性能和使用情况。这种定制化的监控有助于对 OceanBase 的多租户架构进行细粒度控制，确保高效的资源分配和故障排除。
3. 备份管理：通过我们新的租户内备份管理功能保护您的数据。自信地安排备份和恢复数据。

### 增强功能
1. UI/UX 改进：体验更直观和流畅的导航，我们优化了页面布局。我们增强了 Dashboard 的整体美观性和可用性，以提供更吸引人的体验。
2. 内容审查：我们重新审视了我们的文本内容，使其更简洁和用户友好。改进的文档和应用内文本旨在提供更清晰的指导和支持。

## 0.1.0 (发布于 2024.01.06)

### 新功能
1. 集群管理：轻松在 Kubernetes 环境中部署、扩展和管理 OceanBase 集群。Dashboard 允许用户快速配置和管理 OceanBase 集群的生命周期，只需点击几下。
2. 监控：密切关注 OceanBase 集群的性能和健康状况。我们的 Dashboard 提供实时指标、日志和警报，帮助您确保数据库的最佳性能。

