## Functionality

This is a UI management interface for Calico's IPPool and NetworkPolicy based on Calico. It allows users to manage and configure Calico's IPPool and NetworkPolicy through a user-friendly interface.

- IPPool Management: Users can create, update, and delete IPPools. Additionally, users can view detailed information for each IPPool, including its CIDR and whether NAT is disabled.
- NetworkPolicy Management: Users can create, update, and delete NetworkPolicies. Additionally, users can view detailed information for each NetworkPolicy, including its selectors and rules.

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **KubeSphere Network** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Quick Start

After installation, you can make use of the extension on the following pages:

- Under the **Network** menu in the left navigation pane of the cluster, you will find **Network Policies** and **Pod IP Pools**.
- On the **Basic Info** page in the left navigation pane of the workspace, you will find support for enabling workspace network isolation.
- Under the **Project Settings** menu in the left navigation pane of the project, you will find **Network Isolation**.
- When creating workloads or jobs, the **Advanced Settings** tab will show the **Pod IP Pool** option.

### Network Policies

Network policies are used to control access and permissions for pods within a cluster, allowing network isolation within the cluster. You can use network policies to achieve the following goals: Only allow pods to access specific other pods or IP ranges; Only allow pods to be accessed by specific other pods or IP ranges.

Under the **Network Policies** menu in the cluster, you can create, view, and edit network policies.

Network isolation is used to control outbound and inbound traffic for pods within workspaces and projects. 

On the **Basic Info** page of the workspace, you can enable workspace network isolation. Once enabled, network policies will be automatically created for all projects within that workspace in the corresponding cluster. Under the **Project Settings** menu of the project, you can enable project network isolation, add or remove whitelists. Once enabled, network policies will be automatically created for that project in the corresponding cluster.

### Pod IP Pools

Pod IP pools are used to allocate IP addresses for pods. Each pod IP pool contains a private IP address range that can be accessed within the cluster.

Under the **Pod IP Pools** menu in the cluster, you can create, view, edit, disable, and enable pod IP pools, assign pod IP pools to projects, edit overlay modes, and automatically select suitable nodes for pod IP pools.

When creating workloads or jobs, in the **Advanced Settings** tab, you can specify the pod IP pool using the **Pod IP Pool** option, which will assign IP addresses from the specified pod IP pool to the pods created for the workload or job.

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **KubeSphere Network** extension, and click the **Uninstall** button to begin the uninstallation process.