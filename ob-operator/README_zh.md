# OB-Operator

[OB-Operator](https://github.com/oceanbase/ob-operator) 是一个Kubernetes operator，提供管理Kubernetes集群中的OceanBase相关资源的能力。

## 前提条件

在开始之前，请确保您有一个功能完善的Kubernetes集群，并满足以下最低可用资源要求：
- **CPU核心数：** 2
- **内存：** 10GB
- **存储空间：** 100GB

OB-Operator依赖于[cert-manager](https://cert-manager.io/docs/)进行证书管理。有关安装说明，请参考[cert-manager安装指南](https://cert-manager.io/docs/installation/)。

此外，请确保集群中至少有一个存储类可用，以便为OceanBase集群提供卷。我们已经测试了几种主要存储解决方案的兼容性：

| 存储解决方案            | 测试版本       | 兼容性 | 备注                                        |
| ----------------------- | -------------- | ------ | ------------------------------------------- |
| local-path-provisioner  | 0.0.23         | ✅     | 推荐用于开发和测试                          |
| Rook CephFS             | v1.6.7         | ❌     | CephFS不支持`fallocate`系统调用             |
| Rook RBD (Block)        | v1.6.7         | ✅     |                                             |
| OpenEBS (cStor)         | v3.6.0         | ✅     |                                             |
| GlusterFS               | v1.2.0         | ⚠️     | 需要内核版本 >= 5.14                        |
| Longhorn                | v1.6.0         | ✅     |                                             |
| JuiceFS                 | v1.1.2         | ✅     |                                             |
| NFS                     | v5.5.0         | ❌     | 使用NFS协议 >= 4.2引导，但无法回收租户资源。 |

## 主要功能

- **OceanBase集群管理**
- **OceanBase集群灾难自动恢复**
- **OceanBase在多Kubernetes集群中部署运维**
- **OceanBase租户管理**
- **OceanBase租户备份和恢复**

有关更详细的说明，请参阅[用户手册](https://oceanbase.github.io/ob-operator/docs/manual/what-is-ob-operator)。

