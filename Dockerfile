FROM docker.io/kubesphere/extensions-museum:latest as base

COPY bin/_output/ /charts/

ENTRYPOINT ["/chartmuseum","--storage.local.rootdir","/charts"]

FROM ghcr.io/helm/chartmuseum:v0.16.1

COPY --from=base /charts/ /charts/

ENTRYPOINT ["/chartmuseum","--storage-local-rootdir","/charts","--storage","local"]
