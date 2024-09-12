<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v1.2.2

### Features

- Support customizing the index format of OpenSearch when using it as the backend storage.

### Enhancements

- Support nanosecond-level sorting queries when using OpenSearch as the backend storage.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.0.0

The `WhizardTelemetry Platform Service` is a new service created by extracting observable-related functionalities from the original `KubeSphere APIServer` that serves as the shared `APIServer` for various observable services in the `WhizardTelemetry Observability Platform`, acting as a common backend platform service for all observable functionalities. Currently, it provides APIs for monitoring, logging, auditing, events, notifications, and other services.

### Deprecations

- The monitoring API `monitoring.kubesphere.io/v1alpha3` was deprecated in KSE 3.5 and officially removed in KSE v4.1.0.
- The logging and events API `tenant.kubesphere.io/v1alpha2` was officially removed in KSE v4.1.0.

### API Changes

- The monitoring API has been upgraded to version `monitoring.kubesphere.io/v1beta1`. For more API details, refer to [WhizardTelemetry Monitoring Developer Documentation](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/montoring-extension-dev-guide.md#whizardtelemetry-monitoring-api-%E5%8F%82%E8%80%83) and [Swagger](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/swagger.json).
- The logging and events APIs have been upgraded to version `logging.kubesphere.io/v1beta2`. For more API details, please refer to the [WhizardTelemetry Logging Developer Documentation](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/logging-dev-guide.md#whizardtelemetry-api-%E5%8F%82%E8%80%83) and [Swagger](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-telemetry/swagger.json).

### Features

- Integrated KubeSphere authentication, supporting user permission validation.
- Monitoring API supports loading PromQL query expressions via template files.
- Monitoring API supports custom component queries.

### Enhancements

- Optimized the query performance of the monitoring API.
- Optimized the query performance of the logging API.
- Optimized the query performance of the events API.
