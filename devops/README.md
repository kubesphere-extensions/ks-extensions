## Functionality

KubeSphere DevOps offers a series of Continuous Integration (CI) and Continuous Delivery (CD) tools, enabling the automation of processes between IT and software development teams.
In CI/CD workflows, every integration is validated through automated builds, encompassing coding, deployment, and testing. This helps developers identify integration errors early, allowing teams to rapidly, securely, and reliably deliver internal software to production environments.
The system supports source code management tools like GitHub, Git, and SVN.
Users can construct CI/CD pipelines via a graphical editing panel (Jenkinsfile out of SCM) or create Jenkinsfile-based pipelines from code repositories (Jenkinsfile in SCM).

KubeSphere DevOps provides the following functionalities:

1. Independent DevOps projects offering controlled access to CI/CD pipelines.
2. Out-of-the-box DevOps capabilities requiring no complex Jenkins configurations.
3. Jenkinsfile-based pipelines offering consistent user experiences, supporting multiple code repositories.
4. Graphical editing panel for pipeline creation, with low learning curve.
5. Robust tool integration mechanisms, such as SonarQube, for code quality checks.
6. Continuous delivery capabilities based on ArgoCD, automating deployments across multi-cluster environments.

For further details, refer to the [KubeSphere DevOps official website](https://www.kubesphere.io/devops/).

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **DevOps** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

## Configuration

### Access jenkins

1. Please check `jenkins.securityRealm.openIdConnect.kubesphereCoreApi` and `jenkins.securityRealm.openIdConnect.jenkinsURL` in the extension configuration to ensure that they have been modified to the actual accessible addresses of the ks-console and devops-jenkins services respectively. If not, please modify them and wait for the extension updated.

    ```yaml
    jenkins:
      securityRealm:
        openIdConnect:
          # The kubesphere-core api used for jenkins OIDC
          # If you want to access to jenkinsWebUI, the kubesphereCoreApi must be specified and browser-accessible
          # Modifying this configuration will take effect only during installation
          # If you wish for changes to take effect after installation, you need to update the jenkins-casc-config ConfigMap, copy the securityRealm configuration from jenkins.yaml to jenkins_user.yaml, save, and wait for approximately 70 seconds for the changes to take effect.
          kubesphereCoreApi: "http://192.168.1.1:30880"
          # The jenkins web URL used for OIDC redirect
          jenkinsURL: "http://192.168.1.1:30180"
    ```

2. Please check all addresses of `securityRealm.oic` under `jenkins_user.yaml` in the configmap `jenkins-casc-config` and make sure they have been modified to the same as `securityRealm.oic` under `jenkins.yaml`, to actual accessible address of kubesphere-console. If not, please modify them and wait for about 70s to take effect..
 
    ```yaml
        securityRealm:
          oic:
            clientId: "jenkins"
            clientSecret: "jenkins"
            tokenServerUrl: "http://192.168.1.1:30880/oauth/token"
            authorizationServerUrl: "http://192.168.1.1:30880/oauth/authorize"
            userInfoServerUrl: "http://192.168.1.1:30880/oauth/userinfo"
            endSessionEndpoint: "http://192.168.1.1:30880/oauth/logout"
            logoutFromOpenidProvider: true
            scopes: openid profile email
            fullNameFieldName: url
            userNameField: preferred_username
    ```

3. Please check `authentication.issuer.url` in the configuration dictionary `kubesphere-config` to make sure it has been modified to the address that is actually accessible to kubesphere-console. If not, please modify and restart Deployment ks-apiserver to make it take effect.

    ```yaml
    authentication:
      issuer:
        url: "http://192.168.1.1:30880"
    ```

    ```shell
    kubectl -n kubesphere-system rollout restart deploy ks-apiserver
    ```

## Quick Start

After installation, **DevOps Projects** will be displayed on the left navigation pane of workspaces.

You can integrate KubeSphere with third-party code repositories in the DevOps project, and then automatically update source code changes to the target environment through pipelines or continuous deployment.

For more information, please refer to the [DevOps User Guide](https://docs.kubesphere.com.cn/v4.1.1/11-use-extensions/01-devops/).


## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **DevOps** extension, and click the **Uninstall** button to begin the uninstallation process.
