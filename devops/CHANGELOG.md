<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.3 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.3

### Bug Fixes

- Fix the issue of data migration failure when upgrading from KubeSphere version 3.x.

## v1.1.2

### Enhancements

- Change the default login method of the Jenkins console to the local database to simplify the login process.
- Add the function to terminate long-running pipelines in the DevOps GC CronJob.
- Set the default activeDeadlineSeconds of DevOps agent pods to 6 hours to prevent pods from occupying resources for too long.

### Bug Fixes

- Fix the issue of failing to edit Groovy scripts on the UI.
- Fix the issue where updating the extension agent configuration does not take effect.
- Fix the issue of failing to update labels or annotations of pipelinerun.
- Fix the issue of failing to run the CD (Continuous Deployment) steps in pipelines.
- Fix the issue of failing to add GitLab repositories.
- Fix the issue of failing to delete Jenkins plugins during upgrades.
- Fix the issue of mistakenly deleting user's PVCs under the `kubesphere-devops-worker` project during upgrades.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.2 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.1

### Features

- Support for creating credentials with the kubeconfig type.

### Bug Fixes

- Fix the issue where the devops-jenkins-rules rule group is missing.
- Fix the issue where pipeline running records are not shown in specific cases.
- Fix cluster selection logic on DevOps list page under workspaces.
- Fix the issue where login information of project members was not updated in DevOps project member lists.
- Fix devops-apiserver exception caused by updating member cluster agent configuration.
- Fix failure of email sending steps in pipelines.

<!---
Please do not delete this line of version tag
RELEASE_MARK v4.1.0 RELEASE_MARK
Please do not delete this line of version tag
-->
## v1.1.0

1. Support Jenkins-based CI/CD pipeline workflows with graphical editing, low-cost out-of-the-box usage.
2. Provide independent DevOps projects and fine-grained permission controls.
3. Support continuous delivery features based on ArgoCD, enabling multi-cluster deployments.
4. Update Jenkins authentication to OpenId Connect Authentication.