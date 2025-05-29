# Changelog

## 0.4.0 (Release on 2025.04.21)

### New Feature
1. Support to manage obcluster across multiple K8s clusters.
2. Add tenant restore page. 

### Enhancement
1. Support to specify proxyro password when creating obcluster.
2. Support to manage node labels and taints. 
3. Enhance obcluster parameter management.
4. Add support for modifying OBCluster after creation.

## 0.3.3 (Release on 2025.01.16)

### New Features
1. Support for setting affinity, taint toleration and node selector when creating OBCluster.
2. Support for setting independent PVC and deletion protection.

### Enhancements
1. Add support for independent PVC lifecycle and deletion protection.
2. Add support for deleting and restarting specific OBServers.
3. Add support for setting the optimization scenario for OBCluster and OBTenant.
4. Add support for modifying OBCluster after creation.

### Bugfixes
1. Fixed infinite refresh when editing backup policy.

## 0.3.2 (Release on 2024.11.08)

### Bugfixes
1. Optimize obproxy parameter search.
2. Optimize node resource query by fetching data from metrics server.
3. Fix wrong configs in alarm rule.
4. Fix scenarios when affinity is set.
5. Fit route when deleted a cluster.
6. Optimize status and schedule time display.

## 0.3.1 (Release on 2024.09.06)

### New Features
1. Added access control module.

### Bugfixes
1. Fixed the bug where storage values are printed in byte unit.

## 0.3.0 (Release on 2024.06.28)

### New Features
1. Added support for Alarm management.
2. Added support for OBProxy management.
3. Added support for connecting to database via ODC temporary session.

### Bugfixes
1. Fixed the bug where tenant's topology diagram show spec instead of status.

## 0.2.1 (Release on 2024.04.25)

### New Features
1. Added support for connecting cluster sys and tenant in Connection tab.

### Bugfixes
1. Fixed wrong IP displays in OBCluster with service mode.
2. Removed restriction for tenant name that digits are not permitted.
3. Fixed error that occurs when syncing a primary tenant after restoring from backup data.

## 0.2.0 (Release on 2024.04.12)

### New Features
1. Tenant Management: We've introduced comprehensive tools for managing tenants, empowering you to handle multiple tenants within OceanBase clusters with ease. This is crucial for completing the functionality of the Dashboard.
2. Tenant Monitoring: Monitor the performance and usage of individual tenants in real-time. This tailored monitoring facilitates granular control over multi-tenant architecture of OceanBase, ensuring efficient resource allocation and troubleshooting.
3. Backup Management: Secure your data with our new backup management capabilities within tenants. Schedule backups and restore data with confidence.

### Enhancements
1. UI/UX Improvements: Experience a more intuitive and streamlined navigation with our polished page layouts. We've enhanced the overall aesthetic and usability of the dashboard to facilitate a more engaging experience.
2. Content Review: We've revisited our text content, making it more concise and user-friendly. Improved documentation and in-app text aim to provide clearer guidance and support.

## 0.1.0 (Release on 2024.01.06)

### New Features
1. Cluster Management: Easily deploy, scale, and manage OceanBase clusters within your Kubernetes environment. The dashboard allows users to quickly configure and manage the lifecycle of OceanBase clusters with just a few clicks.
2. Monitoring: Keep a close eye on the performance and health of your OceanBase clusters. Our dashboard provides live metrics, logs, and alerts to help you ensure that your databases are performing optimally.

