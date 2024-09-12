## Functionality

This extension contains the following utilities:

- **snapshot-controller**: create snapshots for PVC.
- **snapshotclass-controller**: count volume snapshots per snapshot class.
- **pvc-auto-resizer**: expand the PVC's capacity automatically when it's short of storage space.
- **storageclass-accessor**: validate if a PVC can be created in a specific project and workspace by providing a admission webhook.

### Limitations

`pvc-auto-resizer` requires connection to the Prometheus service.

If you have installed or modified the Prometheus service after installing the storage-utils (the KubeSphere Storage extension), you may need to restart the storage-utils workload using the following command, so that the pvc-auto-resizer can connect to Prometheus:

```
kubectl -n extension-storage-utils rollout restart deployment storage-utils
```

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **KubeSphere Storage** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Quick Start

After installation, you can use the features of this extension on the following pages:

- Under the **Storage** menu in the left navigation pane of the cluster, you will find **Volume Snapshots** and **Volume Snapshot Classes**; under **Storage Classes** of the **Storage** menu, you will find the settings for Storage Classes - **Set Authorization Rules** and **Set Auto Expansion**.
- Under the **Storage** menu in the left navigation pane of the project, you will see **Volume Snapshots**.

> Usually, the local storage system of cluster nodes does not support volume snapshot and volume expansion. You should install storage plugins for the KubeSphere cluster to ensure that the backend storage system supports volume snapshot and volume expansion. For more information, please contact your storage system provider.

### Storage Classes

In the **Storage Classes** details page under the **Storage** menu in the left navigation pane of the cluster, click **More** > **Set Authorization Rules**/**Set Auto Expansion**.

- Set Authorization Rules: The storage class can only be used in specific projects and workspaces.
- Set Auto Expansion: The system automatically expands the volume capacity when the remaining volume space is below a threshold.

> Ensure that the backend storage system supports volume expansion and that the storage class has the volume expansion feature enabled. Method: Storage Class > More > Set Volume Operations > Enable Volume Expansion.

### Volume Snapshot Classes

Volume snapshot classes are used to define the storage type for volume snapshots. Under the **Volume Snapshot Classes** menu in the cluster, you can create, view, and edit volume snapshot classes.

> Before creating volume snapshot classes, ensure that the backend storage system supports volume snapshot.

### Volume Snapshots

Volume snapshots store the current data of storage volumes and can be used to create persistent volume claims and their corresponding persistent volumes. Once a volume snapshot is created, the system will save the snapshot in the backend storage system.

> Before creating volume snapshots, ensure that the backend storage system supports volume snapshot and that the volume snapshot functionality has been enabled on the storage class corresponding to the persistent volume claim. Method: Storage Class > More > Set Volume Operations > Enable Volume Snapshot Creation.
> 
> Before creating volume snapshots, ensure that volume snapshot classes have been created.

In the **Volume Snapshots** menu in the cluster, you can create volume snapshots for persistent volume claims, create persistent volumes using volume snapshots, and view or edit the volume snapshot content.

In the **Volume Snapshots** menu in the project, you can create volume snapshots for persistent volume claims, and create persistent volumes using volume snapshots.

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **KubeSphere Storage** extension, and click the **Uninstall** button to begin the uninstallation process.
