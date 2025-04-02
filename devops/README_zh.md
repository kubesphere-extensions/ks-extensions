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

### 访问 jenkins console
1. 获取 jenkins 管理员用户名和密码
```shell
kubectl -n kubesphere-devops-system get secret devops-jenkins -o yaml
```

输出示例：
```yaml
data:
  jenkins-admin-password: aXMxZno1Z3lnQWFTaGRIU2EwUDZkbg==
  jenkins-admin-token: MTE5NTQ4NDY3MTE4MDQ4ODAzMDI1MTc3MDk1OTUwNTM2MQ==
  jenkins-admin-user: YWRtaW4=
```

将 `jenkins-admin-user` 和 `jenkins-admin-password` 对应的内容 base64 解码后，即得到 jenkins 管理员的用户名和密码。

2. 访问 jenkins console 

通过以下命令获取 jenkins 服务的节点端口， devops 默认使用 30180 作为节点端口。
```shell
kubectl -n kubesphere-devops-system get svc devops-jenkins
```

输出示例：
```
NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
devops-jenkins   NodePort   10.233.27.225   <none>        80:30180/TCP   42d
```

浏览器打开 <master-node-ip:30180>，然后使用第一步获取的用户名和密码登录即可。

#### LDAP
如果你想以 LDAP 的方式登录 jenkins console, 请参考 https://plugins.jenkins.io/ldap/ 。

配置示例（对接 KubeSphere LDAP) : 
```yaml
agent:
  jenkins:
    exactSecurityRealm:
      ldap:
        configurations:
        - displayNameAttributeName: "uid"
          mailAddressAttributeName: "mail"
          inhibitInferRootDN: false
          managerDN: "cn=admin,dc=kubesphere,dc=io"
          managerPasswordSecret: "admin"
          rootDN: "dc=kubesphere,dc=io"
          userSearchBase: "ou=Users"
          userSearch: "(&(objectClass=inetOrgPerson)(|(uid={0})(mail={0})))"
          groupSearchBase: "ou=Groups"
          groupSearchFilter: "(&(objectClass=posixGroup)(cn={0}))"
          server: "ldap://openldap.kubesphere-system.svc:389"
        disableMailAddressResolver: false
        disableRolePrefixing: true
```

#### OpenId Connect
如果你想以 OpenId Connect 的方式登录 jenkins console, 请参考 https://plugins.jenkins.io/oic-auth/ 。

配置示例（对接 KubeSphere OpenId Connect）:
```yaml
agent:
  jenkins:
    exactSecurityRealm:
      oic:
        clientId: "jenkins"
        clientSecret: "jenkins"
        tokenServerUrl: "http://192.168.1.20:30880/oauth/token"
        authorizationServerUrl: "http://192.168.1.20:30880/oauth/authorize"
        userInfoServerUrl: "http://192.168.1.20:30880/oauth/userinfo"
        endSessionEndpoint: "http://192.168.1.20:30880/oauth/logout"
        logoutFromOpenidProvider: true
        scopes: openid profile email
        fullNameFieldName: url
        userNameField: preferred_username
    redirectURIs:
    - http://192.168.1.20:30180/securityRealm/finishLogin
```

## 快速开始

安装完成后，企业空间左侧导航栏将显⽰ **DevOps 项⽬**。

您可以在 DevOps 项目中将 KubeSphere 与第三方代码仓库对接，然后通过流水线或持续部署使源代码变化自动更新到目标环境中。

更多信息，请参阅 [DevOps 使用指南](https://docs.kubesphere.com.cn/v4.1.1/11-use-extensions/01-devops/)。

## 卸载

通过 **扩展市场** 页面找到 **DevOps**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。
