<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.3 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.0.2

### Enhancements

- Add usage instructions to the App Store page

### Bug Fixes

- Fix an issue where new application versions could not be uploaded in App Management
- Fix incomplete category display in App Store Management
- Fix incomplete resource status display in App Details
- Fix duplicate requests when uploading chart applications

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.0.1

### Bug Fixes

- Fix the issue where application categories are not displayed when exceeding 10 entries.
- Fix potential issue with excessively long application names.
- Fix potential issue with repo synchronization not being executed.
- Fix the issue where clusters connected by tower cannot install applications.


<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->

## v2.0.0

`App Store Management` is a multi-cloud application management platform based on OpenPitrix, used for uploading, reviewing, and managing different types of applications in multi-cloud environments.

In v2.0.0, the synchronization performance of repository applications has been improved, and creating application templates using YAML files has been supported.

### Features

- Support for application uploading, review, release and unrelease.
- Support for creating application templates using YAML files.
- Support for external S3 object storage.
- Support for global application repository configuration.
- Support for more granular permission configurations, including viewing, creating, deleting, and overall management of applications, application versions, and application instances.

### Enhancements

- Improve product interaction, delineating the functional boundaries between App Store and App Store Management.
- Remove built-in open-source repositories and open-source application templates.
- Improve synchronization performance of repository applications.

### Bug Fixes

- Fix the issue where CRD could not be used immediately after installing Helm applications.

### Deprecations

- Remove APIs of the openpitrix.io/v1 series.
- Remove APIs of the manifests.application.kubesphere.io series.

### API Changes

- Add APIs for creating YAML applications.
- Utilize unified pagination and filtering conditions queries provided by the KubeSphere platform.