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

### Access jenkins console

1. **Retrieve Jenkins Administrator Username and Password**
   ```shell
   kubectl -n kubesphere-devops-system get secret devops-jenkins -o yaml
   ```

   Example output:
   ```
   data:
     jenkins-admin-password: aXMxZno1Z3lnQWFTaGRIU2EwUDZkbg==
     jenkins-admin-token: MTE5NTQ4NDY3MTE4MDQ4ODAzMDI1MTc3MDk1OTUwNTM2MQ==
     jenkins-admin-user: YWRtaW4=
   ```

   Decode the values corresponding to `jenkins-admin-user` and `jenkins-admin-password` using Base64 to obtain the Jenkins administrator username and password.

2. **Access Jenkins Console**

   Use the following command to retrieve the NodePort of the Jenkins service. By default, DevOps uses 30180 as the NodePort.
   ```shell
   kubectl -n kubesphere-devops-system get svc devops-jenkins
   ```

   Example output:
   ```
   NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
   devops-jenkins   NodePort   10.233.27.225   <none>        80:30180/TCP   42d
   ```

   Open a browser and navigate to `<master-node-ip:30180>`. Then log in using the username and password obtained in step 1.

### LDAP  
If you want to log in to the Jenkins console using LDAP, please refer to https://plugins.jenkins.io/ldap/ .

Example configuration (integrating with KubeSphere LDAP):  
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

### OpenId Connect  
If you want to log in to the Jenkins console using OpenId Connect, please refer to https://plugins.jenkins.io/oic-auth/ .

Example configuration (integrating with KubeSphere OpenId Connect):  
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

## Quick Start

After installation, **DevOps Projects** will be displayed on the left navigation pane of workspaces.

You can integrate KubeSphere with third-party code repositories in the DevOps project, and then automatically update source code changes to the target environment through pipelines or continuous deployment.

For more information, please refer to the [DevOps User Guide](https://docs.kubesphere.com.cn/v4.1.1/11-use-extensions/01-devops/).


## Uninstallation

Navigate to the **KubeSphere Marketplace** page, find the installed version of the **DevOps** extension, and click the **Uninstall** button to begin the uninstallation process.
