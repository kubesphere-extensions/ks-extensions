## 功能

KubeSphere DevOps 提供一系列持续集成 (CI) 和持续交付 (CD) 工具，可以使 IT 和软件开发团队之间的流程实现自动化。在 CI/CD 工作流中，每次集成都通过自动化构建来验证，包括编码、发布和测试，从而帮助开发者提前发现集成错误，团队也可以快速、安全、可靠地将内部软件交付到生产环境。支持源代码管理工具，例如 GitHub、Git 和 SVN 等。用户可以通过图形编辑面板 (Jenkinsfile out of SCM) 构建 CI/CD 流水线，或者从代码仓库 (Jenkinsfile in SCM) 创建基于 Jenkinsfile 的流水线。

KubeSphere DevOps 系统为您提供以下功能：

1. 独立的 DevOps 项目，提供访问可控的 CI/CD 流水线。
2. 开箱即用的 DevOps 功能，无需复杂的 Jenkins 配置。
3. 基于 Jenkinsfile 的流水线，提供一致的用户体验，支持多个代码仓库。
4. 图形编辑面板，用于创建流水线，学习成本低。
5. 强大的工具集成机制，例如 SonarQube，用于代码质量检查。
6. 基于 ArgoCD 的持续交付能力，自动化部署到多集群环境。

详细信息可参考：[KubeSphere DevOps 官网](https://www.kubesphere.io/devops/)

## 安装

1. 通过 **扩展市场** 页面找到 **DevOps** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，开始安装；
3. 安装完成后，点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面；
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

## 配置

### 访问 jenkins

1. 请检查扩展组件配置里 `jenkins.securityRealm.openIdConnect.kubesphereCoreApi` 和 `jenkins.securityRealm.openIdConnect.jenkinsURL` ，确保已经分别修改为 ks-console 和 devops-jenkins 服务实际可访问的地址，如果不是，请修改并等待组件更新完成。

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

2. 请检查配置字典 `jenkins-casc-config` 中 `jenkins_user.yaml` 下 `securityRealm.oic` 的所有地址，确保已经改为与 `jenkins.yaml` 下 `securityRealm.oic` 里一样的，都改成 kubesphere-console 实际可访问的地址，如果不一样，请修改并等待 70s 左右使其生效。

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

3. 请检查配置字典 `kubesphere-config` 中的 `authentication.issuer.url` ，确保已经修改为 kubesphere-console 实际可访问的地址，如果不是，请修改并重启 Deployment ks-apiserver 使其生效。

    ```yaml
    authentication:
      issuer:
        url: "http://192.168.1.1:30880"
    ```

    ```shell
    kubectl -n kubesphere-system rollout restart deploy ks-apiserver
    ```

## 快速开始

安装完成后，企业空间左侧导航栏将显⽰ **DevOps 项⽬**。

您可以在 DevOps 项目中将 KubeSphere 与第三方代码仓库对接，然后通过流水线或持续部署使源代码变化自动更新到目标环境中。

更多信息，请参阅 [DevOps 使用指南](https://docs.kubesphere.com.cn/v4.1.1/11-use-extensions/01-devops/)。

## 卸载

通过 **扩展市场** 页面找到 **DevOps**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。
