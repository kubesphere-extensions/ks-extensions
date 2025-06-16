## 功能

cert-manager 为 Kubernetes 中的工作负载创建 TLS 证书，并在证书过期前续订。

cert-manager 可以从各种证书颁发机构获取证书，包括：Let’s Encrypt、HashiCorp Vault、Venafi 和私有 PKI。


## 安装

1. 通过 **扩展市场** 页面找到 **cert-manager** 扩展组件，点击 **安装**，选择最新版本，点击 **下一步** 按钮；
2. 在 **扩展组件安装** 标签页面中，根据需求点击并修改 **扩展组件配置**，配置完成后，点击 **开始安装** 按钮，静待安装完成。

## 配置

### 生成默认的 ClusterIssuer

开启后会在安装时生成 ClusterIssuer, 名为 `default-issuer`。
默认的 ClusterIssuer 可用来给其他组件颁发证书。例如，使用 `KubeSphere 网关` 时，可为路由自动生成和更新证书。

安装时，在 **扩展组件安装** 标签页中， 点击 **扩展组件配置**，修改 `operator` 下 `defaultIssuer` 字段的值。

1. 生成自签名的证书

```yaml
# DefaultIssuer create a default ClusterIssuer
  defaultIssuer:

    selfSigned:
      enabled: true

    CA:
      enabled: false
      data:
        tlsCrt:
        tlsKey:
```
默认会生成自签名证书的 ClusterIssuer，无需修改配置。

2. 导入 CA 证书

```yaml
# DefaultIssuer create a default ClusterIssuer
  defaultIssuer:

    selfSigned:
      enabled: false

    CA:
      enabled: true
      data:
        tlsCrt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrVENDQWVHZ0F3SUJBZ0lKQUtQR3dLRGwvNUhuTUEwR0NTcUdTSWIzRFFFQkN3VUFNQk14RVRBUEJnTlYKQkFNTUNHcHZjMmgyWVc1c01CNFhEVEU1TURneU1qRTJNRFUxT0ZvWERUSTVNRGd4T1RFMk1EVTFPRm93RXpFUgpNQThHQTFVRUF3d0lhbTl6YUhaaGJtd3dnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCCkFRQ3doU0IvcVc2L2tMYjJ6cHUrRUp2RDl3SEZhcStRQS8wSkgvTGxseW83ekFGeCtISHErQ09BYmsrQzhCNHQKL0hVRXNuczVSTDA5Q1orWDRqNnBiSkZkS2R1UHhYdTVaVllua3hZcFVEVTd5ZzdPU0tTWnpUbklaNzIzc01zMApSNmpZbi9Ecmo0eFhNSkVmSFVEcVllU1dsWnIzcWkxRUZhMGM3ZlZEeEgrNHh0WnROTkZPakg3YzZEL3ZXa0lnCldRVXhpd3Vzc2U2S01PV2pEbnYvNFZyamVsMlFnVVlVYkhDeWVaSG1jdGkrSzBMV0Nmby9SZzZQdWx3cmJEa2gKam1PZ1l0MzBwZGhYME9aa0F1a2xmVURIZnA4YmpiQ29JMnRhWUFCQTZBS2pLc08zNUxBRVU3OUNMMW1MVkh1WgpBQ0k1VWppamEzVlBXVkhTd21KUEp5dXhBZ01CQUFHalVEQk9NQjBHQTFVZERnUVdCQlFtbDVkVEFaaXhGS2hqCjkzd3VjUldoYW8vdFFqQWZCZ05WSFNNRUdEQVdnQlFtbDVkVEFaaXhGS2hqOTN3dWNSV2hhby90UWpBTUJnTlYKSFJNRUJUQURBUUgvTUEwR0NTcUdTSWIzRFFFQkN3VUFBNElCQVFCK2tsa1JOSlVLQkxYOHlZa3l1VTJSSGNCdgpHaG1tRGpKSXNPSkhac29ZWGRMbEcxcFpORmpqUGFPTDh2aDQ0Vmw5OFJoRVpCSHNMVDFLTWJwMXN1NkNxajByClVHMWtwUkJlZitJT01UNE1VN3ZSSUNpN1VPbFJMcDFXcDBGOGxhM2hQT2NSYjJ5T2ZGcVhYeVpXWGY0dDBCNDUKdEhpK1pDTkhCOUZ4alNSeWNiR1lWaytUS3B2aEphU1lOTUdKM2R4REthUDcrRHgzWGNLNnNBbklBa2h5SThhagpOVSttdzgvdG1Sa1A0SW4va1hBUitSaTBxVW1Iai92d3ZuazRLbTdaVXkxRllIOERNZVM1TmtzbisvdUhsUnhSClY3RG5uMDM5VFJtZ0tiQXFONzJnS05MbzVjWit5L1lxREFZSFlybjk4U1FUOUpEZ3RJL0svQVRwVzhkWAotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
        tlsKey: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBc0lVZ2Y2bHV2NUMyOXM2YnZoQ2J3L2NCeFdxdmtBUDlDUi95NVpjcU84d0JjZmh4CjZ2Z2pnRzVQZ3ZBZUxmeDFCTEo3T1VTOVBRbWZsK0krcVd5UlhTbmJqOFY3dVdWV0o1TVdLVkExTzhvT3praWsKbWMwNXlHZTl0N0RMTkVlbzJKL3c2NCtNVnpDUkh4MUE2bUhrbHBXYTk2b3RSQld0SE8zMVE4Ui91TWJXYlRUUgpUb3grM09nLzcxcENJRmtGTVlzTHJMSHVpakRsb3c1Ny8rRmE0M3Bka0lGR0ZHeHdzbm1SNW5MWXZpdEMxZ242ClAwWU9qN3BjSzJ3NUlZNWpvR0xkOUtYWVY5RG1aQUxwSlgxQXgzNmZHNDJ3cUNOcldtQUFRT2dDb3lyRHQrU3cKQkZPL1FpOVppMVI3bVFBaU9WSTRvMnQxVDFsUjBzSmlUeWNyc1FJREFRQUJBb0lCQUNFTkhET3JGdGg1a1RpUApJT3dxa2UvVVhSbUl5MHlNNHFFRndXWXBzcmUxa0FPMkFDWjl4YS96ZDZITnNlanNYMEM4NW9PbmtrTk9mUHBrClcxVS94Y3dLM1ZpRElwSnBIZ09VNzg1V2ZWRXZtU3dZdi9Fb1V3eHFHRVMvcnB5Z1drWU5WSC9XeGZGQlg3clMKc0dmeVltbXJvM09DQXEyLzNVVVFiUjcrT09md3kzSHdUdTBRdW5FSnBFbWU2RXdzdWIwZzhTTGp2cEpjSHZTbQpPQlNKSXJyL1RjcFRITjVPc1h1Vm5FTlVqV3BBUmRQT1NrRFZHbWtCbnkyaVZURElST3NGbmV1RUZ1NitXOWpqCmhlb1hNN2czbkE0NmlLenUzR0YwRWhLOFkzWjRmeE42NERkbWNBWnphaU1vMFJVaktWTFVqbVlQSEUxWWZVK3AKMkNYb3dNRUNnWUVBMTgyaU52UEkwVVlWaUh5blhKclNzd1YrcTlTRStvVi90U2ZSUUNGU2xsV0d3KzYyblRiVwpvNXpoL1RDQW9VTVNSbUFPZ0xKWU1LZUZ1SWdvTEoxN1pvWjN0U1czTlVtMmRpT0lPSHorcTQxQzM5MDRrUzM5CjkrYkFtVmtaSFA5VktLOEMraS9tek5mSkdHZEJadGIweWtTM2t3OUIxTHdnT3o3MDhFeXFSQ2tDZ1lFQTBXWlAKbzF2MThnV2tMK2FnUDFvOE13eDRPZlpTN3dKY3E0Z0xnUWhjYS9pSkttY0x0RFN4cUJHckJ4UVo0WTIyazlzdQpzTFVrNEJobGlVM29iUUJNaUdtMGtITHVBSEFRNmJvdWZBMUJwZjN2VFdHSkhSRjRMeFJsNzc2akw4UXI4VnpxClpURVBtY0R0T0hpYjdwb2I1Z2IzSDhiVGhYeUhmdGZxRW55alhFa0NnWUVBdk9DdDZZclZhTlQrWThjMmRFYk4Kd3dJOExBaUZtdjdkRjZFUjlCODJPWDRCeGR0WTJhRDFtNTNqN2NaVnpzNzFYOE1TN25FcDN1dkFqaElkbDI3KwpZbTJ1dUUyYVhIbDN5VTZ3RzBETFpUcnVIU0Z5TVI4ZithbHRTTXBDd0s1NXluSGpHVFp6dXpYaVBBbWpwRzdmCk1XbVRncE1IK3puc3UrNE9VNFBHUW9FQ2dZQWNqdUdKbS84YzlOd0JsR2lDZTJIK2JGTHhSTURteStHcm16QkcKZHNkMENqOWF3eGI3aXJ3MytjRGpoRUJMWExKcjA5YTRUdHdxbStrdElxenlRTG92V0l0QnNBcjVrRThlTVVBcAp0djBmRUZUVXJ0cXVWaldYNWlaSTNpMFBWS2ZSa1NSK2pJUmVLY3V3aWZKcVJpWkw1dU5KT0NxYzUvRHF3Yk93CnRjTHAwUUtCZ0VwdEw1SU10Sk5EQnBXbllmN0F5QVBhc0RWRE9aTEhNUGRpL2dvNitjSmdpUmtMYWt3eUpjV3IKU25QSG1TbFE0aEluNGMrNW1lbHBDWFdJaklLRCtjcTlxT2xmQmRtaWtYb2RVQ2pqWUJjNnVGQ1QrNWRkMWM4RwpiUkJQOUNtWk9GL0hOcHN0MEgxenhNd1crUHk5Q2VnR3hhZ0ZCekxzVW84N0xWR2h0VFFZCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==
```

将 `selfSigned.enabled` 参数改为 false，`CA.enabled` 改为 true。并将准备好的 tls.crt 和 tls.key 使用 base64 编码后，
填入 `CA.data.tlsCrt` 和 `CA.data.tlsKey` 字段中。

## 使用
### 在 ingress 中使用默认的 Issuer 签发证书

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: my-ns
  annotations:
    # 指定要默认的 Issuer
    cert-manager.io/cluster-issuer: default-issuer
  name: podinfo
spec:
  rules:
    - protocol: https
      host: podinfo.example.com
      http:
        paths:
          - path: /
            backend:
              service:
                name: frontend-podinfo
                port:
                  number: 9898
            pathType: ImplementationSpecific
  tls:
    - hosts:
      - podinfo.example.com
      # 指定secret名称，将会在以这个名称存储证书到secret
      secretName: podinfo-cert
```

## 卸载

通过 **扩展市场** 页面找到 **cert-manager**，选择已安装的版本，点击 **卸载** 按钮，开始卸载。