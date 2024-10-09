## 功能
KubeEdge 是一个开源的系统，可将本机容器化应用编排和管理扩展到边缘端设备。它基于 Kubernetes 构建，为网络和应用程序提供核心基础架构支持，并在云端和边缘端部署应用，同步元数据。KubeEdge 还支持 MQTT 协议，允许开发人员编写客户逻辑，并在边缘端启用设备通信的资源约束。KubeEdge 包含云端和边缘端两部分。
使用 KubeEdge，可以很容易地将已有的复杂机器学习、图像识别、事件处理和其他高级应用程序部署到边缘端并进行使用。 随着业务逻辑在边缘端上运行，可以在本地保护和处理大量数据。 通过在边缘端处理数据，响应速度会显著提高，并且可以更好地保护数据隐私。

## 安装

1. 通过 **扩展市场** 页面找到 **KubeEdge 边缘计算框架** 扩展组件，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**， 配置完成后，点击 **安装** 按钮， 开始安装;
3. 安装完成后， 点击 **下一步** 按钮，进入集群选择页面，勾选需要安装的集群，点击 **下一步** 按钮，进入 **差异化配置** 页面;
4. 根据需求更新 **差异化配置**，更新完成，开始安装，静待安装完成。

## 配置

将 kubeedge.cloudCore.cloudHub.advertiseAddress 的值设置为集群的公共 IP 地址或边缘节点可以访问的 IP 地址。

```yaml
cloudcore:
  cloudCore:
    modules:
      cloudHub:
        # At least a public IP address or an IP address which can be accessed by edge nodes must be provided.
        # Note that once KubeEdge is enabled, CloudCore will malfunction if the address is not provided.
        advertiseAddress:
          - ""
```
### 收集边缘节点监控信息

如果需要收集边缘节点的监控信息，请先开启 `metrics_server`，以及在边缘节点中开启 `edgeStream`。

#### 在边缘节点中开启 edgeStream
进入 `/etc/kubeedge/config` 文件，搜索 `edgeStream`，将 `false` 更改为 `true` 并保存文件。

```
cd /etc/kubeedge/config
vi edgecore.yaml
```

```
edgeStream:
enable: true #将“false”更改为“true”。
handshakeTimeout: 30
readDeadline: 15
server: xx.xxx.xxx.xxx:10004 #如果没有添加端口转发，将端口修改为30004。
tlsTunnelCAFile: /etc/kubeedge/ca/rootCA.crt
tlsTunnelCertFile: /etc/kubeedge/certs/server.crt
tlsTunnelPrivateKeyFile: /etc/kubeedge/certs/server.key
writeDeadline: 15
```

重启 `edgecore.service`。

```
systemctl restart edgecore.service
```

如果仍然无法显示监控数据，执行以下命令：

```
journalctl -u edgecore.service -b -r
```

> 注意：如果提示 `failed to check the running environment: kube-proxy should not running on edge node when running edgecore`，需要考虑再次重启 `edgecore.service`。


## 卸载

移除边缘节点之前，请删除在该节点上运行的全部工作负载。

1. 在边缘节点上运行以下命令。

```
./keadm reset
apt remove mosquitto
rm -rf /var/lib/kubeedge /var/lib/edged /etc/kubeedge/ca /etc/kubeedge/certs
```

> 注意：如果无法删除 tmpfs 挂载的文件夹，请重启节点或先取消挂载该文件夹。

2. 运行以下命令从集群中移除边缘节点。

```
kubectl delete node <edgenode-name>
```

3. 通过 **扩展市场** 页面找到 **KubeEdge 边缘计算框架** 扩展，选择已安装的版本，点击 **卸载** 按钮，开始卸载。

> 注意：卸载完成后，您将无法为集群添加边缘节点。