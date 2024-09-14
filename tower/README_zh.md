# KubeSphere 多集群代理连接

KubeSphere 的组件 [Tower](https://github.com/kubesphere/tower) 用于代理连接。Tower 是一种通过代理在集群间建立网络连接的工具。如果主集群无法直接访问成员集群，您可以暴露主集群的代理服务地址，这样可以让成员集群通过代理连接到主集群。当成员集群部署在私有环境（例如 IDC）并且主集群可以暴露代理服务时，适用此连接方法。当您的集群分布部署在不同的云厂商上时，同样适用代理连接的方法。

## 设置代理服务地址

安装主集群后，将在 `kubesphere-system` 中创建一个名为 `tower` 的代理服务，其类型为 `LoadBalancer`。

### 集群中有可用的 LoadBalancer

如果集群中有可用的 LoadBalancer 插件，则可以看到 Tower 服务有相应的 `EXTERNAL-IP` 地址，该地址将由 KubeSphere 自动获取并配置代理服务地址，这意味着您可以跳过设置代理服务地址这一步。执行以下命令确认是否有 LoadBalancer 插件。

```bash
kubectl -n kubesphere-system get svc
```

命令输出结果可能如下所示：

```shell
NAME       TYPE            CLUSTER-IP      EXTERNAL-IP     PORT(S)              AGE
tower      LoadBalancer    10.233.63.191   139.198.110.23  8080:30721/TCP       16h
```

一般来说，主流公有云厂商会提供 LoadBalancer 解决方案，并且负载均衡器可以自动分配外部 IP。如果您的集群运行在本地环境中，尤其是在**裸机环境**中，可以使用 [OpenELB](https://github.com/kubesphere/openelb) 作为负载均衡器解决方案。

### 集群中没有可用的 LoadBalancer

1. 执行以下命令来检查服务。

    ```shell
    kubectl -n kubesphere-system get svc
    ```

   命令输出结果可能如下所示。在此示例中，可以看出 `NodePort` 为 `30721`：
    ```
    NAME       TYPE            CLUSTER-IP      EXTERNAL-IP     PORT(S)              AGE
    tower      LoadBalancer    10.233.63.191   <pending>       8080:30721/TCP       16h
    ```

2. 由于 `EXTERNAL-IP` 处于 `pending` 状态，您需要手动设置代理地址。例如，如果您的公有 IP 地址为 `139.198.120.120`，则需要将公网 IP 的端口，如`30721` 转发到 `NodeIP`:`NodePort`。

3. 将 `proxyPublishAddress` 的值添加 `kubesphere-config` ConfigMap 中，并按如下所示输入公有 IP 地址（此处示例 `139.198.120.120`）和端口号。

   ```bash
   kubectl -n kubesphere-system edit cm kubesphere-config
   ```

   搜寻到 `multicluster` 并添加新行输入 `proxyPublishAddress` 来定义 IP 地址，以便访问 Tower。

    ```yaml
    multicluster:
      clusterRole: host
      proxyPublishAddress: http://139.198.120.120:{NodePort} # Add this line to set the address to access tower
    ```

   请将 YAML 文件中的 {NodePort} 替换为您在步骤 2 中指定的端口。

## 自定义 agent image

默认情况下不需要配置，如果有一些特殊场景需要单独配置 agent 使用的 image 地址，可以通过设置 `kubesphere-config` ConfigMap 中的 `agentImage` 字段：

```yaml
multicluster:
  clusterRole: host
  proxyPublishAddress: ...
  agentImage: kubesphere/tower:v0.2.1
```
