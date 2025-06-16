# OceanBase Dashboard

[OceanBase Dashboard](https://github.com/oceanbase/ob-operator#oceanbase-dashboard) 是一个基于 web 的应用，提供了一种交互式的方式来管理 Kubernetes 集群中的 OceanBase 相关资源。

## 前提条件

OceanBase Dashboard 通过自定义资源定义（CRDs）管理 OceanBase 资源。因此，您需要先部署 [ob-operator](https://github.com/oceanbase/ob-operator)。

您可以使用以下命令查看 service 地址并使用浏览器来打开。

```
kubectl get svc -n oceanbase-system oceanbase-dashboard-oceanbase-dashboard

## The example output
NAME                                      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
oceanbase-dashboard-oceanbase-dashboard   NodePort   10.43.12.12     <none>        80:30080/TCP   1h
```

有关更详细的说明，请参阅 [ob-operator 用户手册](https://oceanbase.github.io/ob-operator/docs/manual/what-is-ob-operator)。

