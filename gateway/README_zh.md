## 核心特性

- 多层级网络配置：使用 Nginx Ingress，提供了集群网关、企业空间网关与项目网关的管理。
- 灵活管控：集成 KubeSphere 的权限体系，支持租户级的权限下方与控制。
- 灵活访问：支持多种网关访问模式，如 NodePort、LoadBalancer 与 ClusterIP。
- Day-2 运维：基于 WizTelemetry 的监控与日志组件，实现网关监控和网关日志搜索等运维能力。

## 安装

1. 通过 **扩展市场** 页面找到 **KubeSphere 网关** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，开始安装；
3. 安装完成后，点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面；
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

## 升级

网关升级后需要修改 **扩展组件配置** 的以下字段。

```yaml
backend:
  enabled: true
  config:
    gateway:
      namespace: kubesphere-controls-system
      valuesOverride:
        controller:
          image:
            registry: ""
            image: kubesphere/ingress-nginx-controller
            tag: "v1.12.1"
            pullPolicy: IfNotPresent
            digest: ""
      exposeNodeLabelKey: "node-role.kubernetes.io/control-plane"
      versionConstraint: ">= 4.3.0, <= 4.12.1"
      logSearchEndpoint: "http://whizard-telemetry-apiserver.extension-whizard-telemetry.svc:9090"
```

1. 查看 `backend.config.gateway.versionConstraint` 参数，versionConstraint 参数用来限制可安装的 ingress-nginx 的版本范围（helm chart version）。 
   当前版本默认配置的 ingress-nginx 版本为 1.12.1，helm chart version 版本为 4.12.1。需要将版本范围修改为 `versionConstraint: ">= 4.3.0, <= 4.12.1"`。

2. 查看 `backend.config.gateway.controller.image` 参数。controller.image 用来定义要安装的 ingress-nginx 的镜像。此处要修改成 ingress-nginx 1.12.1 版本的镜像地址，
   将 image.tag 修改为 `tag: "v1.12.1"`, 将 image.image 修改为 `kubesphere/ingress-nginx-controller`。


## 快速开始

安装完成后，可在以下页面使用该扩展组件提供的功能：

- 集群左侧导航栏的**集群设置**菜单下将显⽰**网关设置**；
- 企业空间左侧导航栏的**企业空间设置**菜单下将显⽰**网关设置**；
- 项目左侧导航栏的**项目设置**菜单下将显⽰**网关设置**。

在这些菜单下，您可以启用、禁用、查看和编辑集群网关、企业空间网关和项目网关。这些网关为整个集群、单个企业空间和单个项目中的服务提供反向代理。


## 卸载

通过 **扩展市场** 页面找到 **KubeSphere 网关**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。
