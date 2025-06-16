# OceanBase Dashboard

[OceanBase Dashboard](https://github.com/oceanbase/ob-operator#oceanbase-dashboard) is a web-based dashboard that provides an interactive way to manage OceanBase-related resources in Kubernetes.

## Prerequisites

OceanBase Dashboard manages OceanBase resources through Custom Resource Definitions (CRDs). Therefore, you need to have [ob-operator](https://github.com/oceanbase/ob-operator) deployed first.

You can get the service address using the following command, and use a web browser to open the address.

```
kubectl get svc -n oceanbase-system oceanbase-dashboard-oceanbase-dashboard

## The example output
NAME                                      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
oceanbase-dashboard-oceanbase-dashboard   NodePort   10.43.12.12     <none>        80:30080/TCP   1h
```

For more detailed instructions, please refer to the [user manual of ob-operator](https://oceanbase.github.io/ob-operator/docs/manual/what-is-ob-operator).

