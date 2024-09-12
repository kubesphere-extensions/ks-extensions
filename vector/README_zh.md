## 安装

1. 通过 **扩展市场** 页面找到 **WhizardTelemetry 数据流水线** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮， 静待安装完成。

WhizardTelemetry 数据流水线仅提供后端服务，无前端界面。

> 注意： WhizardTelemetry 数据流水线是 WhizardTelemetry 事件、WhizardTelemetry 日志、WhizardTelemetry 审计、WhizardTelemetry 通知等共同依赖的扩展组件，因此在安装上述几个扩展组件之前必须先安装 WhizardTelemetry 数据流水线扩展组件，否则日志、通知、审计、事件等功能无法正常使用！
>
> 注意：WhizardTelemetry 可观测平台支持从 OpenSearch 查询日志、审计、事件、通知历史等数据，因此需要在 WhizardTelemetry 数据流水线扩展组件里统一配置接收日志、审计、事件、通知历史等数据的 OpenSearch 服务的信息， 可以是用户自行搭建的 OpenSearch 服务，也可以是通过 `OpenSearch 分布式检索与分析引擎` 这个扩展组件安装的 OpenSearch 服务。

## 配置

### 设置 OpenSearch 的相关配置

* api_version: OpenSearch API 的版本。根据使用的 OpenSearch 版本选择正确的 API 版本。
* auth.strategy: 鉴权策略。对于 OpenSearch，可以选择 "basic" 或其他支持的鉴权策略。
* auth.user: 鉴权用户名。
* auth.password: 鉴权密码。
* endpoints: OpenSearch 节点的地址。（注意：OpenSearch 的地址必须每个 member 集群都可以访问到。如果您的 OpenSearch 是安装在 K8s 集群内，需要给该 OpenSearch 服务配置好 NodePort 后更改默认安装的 OpenSearch 地址！）
* tls.verify_certificate: 是否验证证书。
* tls.cacert: CA 证书路径。
* ssl: 是否使用 TLS/SSL 连接。

```yaml
sinks:
opensearch:
  api_version: v8
  auth:
    strategy: basic
    user: admin
    password: admin
  endpoints:
    - https://opensearch-cluster-data.kubesphere-logging-system.svc:9200
  tls:
    verify_certificate: false
```

### 设置 docker root directory

如果 Docker 的根目录不在 /var/lib 目录下，需要通过 `agent.extraVolumes` 和 `agent.extraVolumeMounts` 配置。注意，在安装之前需要先确认 Docker 的根目录，否则在安装之后需要修改每个 agent 的配置。

```yaml
  agent:
    extraVolumes:
      - name: docker-root
        hostPath:
          path: /path
          type: ''
    extraVolumeMounts:
      - name: docker-root
        mountPath: /path
```

## 卸载

通过 **扩展市场** 页面找到 **WhizardTelemetry 数据流水线**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。
