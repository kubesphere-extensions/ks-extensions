# OB-Operator

[OB-Operator](https://github.com/oceanbase/ob-operator) is a Kubernetes operator designed to manage OceanBase-related resources within a Kubernetes cluster.

## Prerequisites

Before you begin, ensure that you have a functional Kubernetes cluster with the following minimum resources:
- **CPU Cores:** 2
- **Memory:** 10GB
- **Storage Space:** 100GB

OB-Operator relies on [cert-manager](https://cert-manager.io/docs/) for certificate management. For installation instructions, please refer to the [cert-manager installation guide](https://cert-manager.io/docs/installation/).

Additionally, ensure that at least one storage class is available in the cluster to provide volumes for the OceanBase cluster. We have tested the compatibility of several major storage solutions:

| Storage Solution       | Tested Version | Compatibility | Notes                                        |
| ---------------------- | -------------- | ------------- | -------------------------------------------- |
| local-path-provisioner | 0.0.23         | ✅            | Recommended for development and testing      |
| Rook CephFS            | v1.6.7         | ❌            | CephFS does not support `fallocate` sys call |
| Rook RBD (Block)       | v1.6.7         | ✅            |                                              |
| OpenEBS (cStor)        | v3.6.0         | ✅            |                                              |
| GlusterFS              | v1.2.0         | ⚠️            | Requires kernel version >= 5.14              |
| Longhorn               | v1.6.0         | ✅            |                                              |
| JuiceFS                | v1.1.2         | ✅            |                                              |
| NFS                    | v5.5.0         | ❌            | Bootstrap with NFS protocol >= 4.2, but can not recycle tenant resource. |

## Key Features

- **OceanBase Cluster Management**
- **OceanBase Cluster Disaster Auto Recovery**
- **OceanBase Cluster Inter-Kubernetes Cluster Management**
- **OceanBase Tenant Management**
- **OceanBase Tenant Backup and Restore**

For more detailed instructions, please refer to the [user manual](https://oceanbase.github.io/ob-operator/docs/manual/what-is-ob-operator).

