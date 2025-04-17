<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.3 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.3

### 缺陷修复

- 修复从 KubeSphere 3.x 版本升级数据迁移失败的问题

## v1.1.2

### 优化

- Jenkins 控制台默认登录方式修改为本地数据库，简化登录流程
- DevOps GC CronJob 中添加了终止长久未结束的流水线的功能
- DevOps agent pod 的 activeDeadlineSeconds 默认配置为6小时，防止 pod 长久占用资源

### 缺陷修复

- 修复图形化编辑 Groovy 脚本失败的问题
- 修复更新扩展组件 agent 配置不生效的问题
- 修复 pipelinerun 的标签或注解更新失败的问题
- 修复流水线 CD 步骤运行失败的问题
- 修复添加 Gitlab 仓库失败的问题
- 修复升级时删除 Jenkins plugin 失败的问题
- 修复升级时 kubesphere-devops-worker 项目下用户 PVC 被误删除的问题



<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.1.1

### 新特性

- 支持创建 kubeconfig 类型的凭证

### 缺陷修复

- 修复规则组 devops-jenkins-rules 丢失的问题
- 修复流水线运行记录在特定情况不显示的问题
- 修复企业空间下 devops 列表页的集群选择逻辑
- 修复 devops 项目成员列表的成员登录信息未更新的问题
- 修复更新成员集群 agent 配置导致的 devops-apiserver 服务异常
- 修复流水线中发送邮件步骤失败的问题

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.0

**KubeSphere DevOps 系统**是专为 Kubernetes 中的 CI/CD 工作流设计的，它提供了一站式的解决方案，帮助开发和运维团队用非常简单的方式构建、测试和发布应用到 Kubernetes。具有**插件管理、代码依赖缓存、代码质量分析、流水线日志等功能，兼容第三方私有镜像仓库（如 Harbor）和代码库（如 GitLab/GitHub/SVN/BitBucket）**。为用户提供了全面的、可视化的 CI/CD 流水线，打造了极佳的用户体验，而且这种兼容性强的流水线能力在离线环境中非常有用。

此版本相对于 KSE 3.5 ，修复了已知 Issues ，完善了功能，优化了使用体验；适配 KubeSphere 企业版 4.1.0，大量减少对 ks-core 依赖，使 DevOps 组件更加独立，版本管理更加灵活；


### 已知问题
- 镜像构建器（S2I、B2I）功能在此版本暂不可使用。
- kubeconfig 类型的凭证在此版本不可使用。

### API 更新
- ks-core 中 DevOps 相关 APIs 移到此扩展组件中，路径中 `kapis/tenant.kubesphere.io/v1alpha2` 更新为 `kapis/devops.kubesphere.io/v1alpha3`。
- 请求路径中把 DevOps 视为普通 Namespace，即把路径中 `devops` 改成 `namespaces`， 如: `kapis/devops.kubesphere.io/v1alpha3/workspaces/../devops/../` -> `kapis/devops.kubesphere.io/v1alpha3/workspaces/../namespaces/../`。
- DevOps 项目成员管理 API 更新: `kapis/iam.kubesphere.io/v1alpha2/devops/../members` -> `kapis/iam.kubesphere.io/v1beta1/namespaces/../namespacemembers`。
- DevOps 项目角色管理 API 更新：`kapis/iam.kubesphere.io/v1alpha2/devops/../roles?annotation=kubesphere.io/creator` -> `kapis/iam.kubesphere.io/v1beta1/namespaces/../roles?annotation=kubesphere.io/creator`。
- DevOps 项目权限项管理 API 更新：`kapis/iam.kubesphere.io/v1alpha2/devops/../roles?label=iam.kubesphere.io/role-template=true` -> `kapis/iam.kubesphere.io/v1beta1/roletemplates?labelSelector=iam.kubesphere.io/scope=namespace,devops.kubesphere.io/managed=true`。

### 新特性
- 部署时自动识别运行时环境，以便自动适配 Agent 镜像。
- 支持查看已取消的流水线详情。
- 调整 DevOps RoleTemplates 适配 LuBan IAM，DevOps 权限管理更加灵活便捷。

### 优化
- 支持流水线详情页日志查看功能。
- 优化 devops-controller 日志输出，信息更明确。
- 调整多分支流水线关于过期分支清理的描述。

### 缺陷修复
- 修复 devops-controller 由于流水线 cloneOptions.time 为空导致启动失败问题。
- 修复流水线中定义的参数未传到 Jenkins 服务问题。
- 修复流水线"打印消息"步骤包含双引号报错问题。
- 修复多分支流水线里附件下载失败问题。
- 修复回放运行流水线失败问题。
- 修复查询 DevOps 项目别名过滤无效问题。

### 其他
- 更新 devops-jenkins 认证方式为 ks-core OpenId Connect Authentication，去掉对 LDAP 认证方式依赖。