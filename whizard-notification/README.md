## Functionality

The Notification Manager manages notifications in a multi-tenant Kubernetes environment. It receives alerts, cloud events, and other notifications (such as audits, Kubernetes events) from various senders and then sends notifications to different tenant receivers based on tenant labels (such as namespaces or users).

## Installation

### Install dependent extensions

Install the following dependent extensions:  

- ***WhizardTelemetry Platform Service*** (Required)
- ***WhizardTelemetry Data Pipeline*** (Required)

### Install WhizardTelemetry Notification

1. Navigate to the **KubeSphere Marketplace** page and find the **WhizardTelemetry Notification** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** as needed. Once configuration is complete, click the **Start Installation** button and wait for the installation to complete.

## Quick Start

After installation, the **Notification Management** menu will be available in the left navigation pane of **Platform Settings**. In this page, you can configure notification channels (such as email, DingTalk, and WeChat Work), subscribe to notifications, set notification silence policies and language preferences, and view notifications sent to users.

Click the username in the top-right corner of the page and select **Notification Settings** from the dropdown menu. Here, you can add multiple notification recipients and set filtering conditions.

Under the **Cluster Settings** menu in the left sidebar, you will find the **Log Receivers** option. The Log Receivers page allows you to add various types of log receivers and includes a **Notification History** tab for viewing the history of notifications.

Under the **Cluster Settings** menu in the left navigation pane of the cluster, you will find **Log Receivers**. The page will display the **Notification History** tab, which supports adding various types of log receivers.

## Configuration

### Configure notification-history and notification-manager

The `notification-manager` section is for notification-related configurations. For specific configurations, please refer to the [Notification Configuration](https://github.com/kubesphere/notification-manager) documentation.

```yaml
notification-manager:
  kubesphere:
    enabled: true
    version: v4.0.0

    operator:
      containers:
        operator:
          image:
            tag: v2.5.1

    notificationmanager:
      annotations:
        kubesphere.io/serviceaccount-name: notification-tenant-sidecar
      image:
        tag: v2.5.1
```

## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **WhizardTelemetry Notification** extension, and click the **Uninstall** button to begin the uninstallation process.
