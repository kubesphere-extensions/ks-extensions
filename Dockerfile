FROM ghcr.io/helm/chartmuseum:v0.16.1

ARG branch

COPY .extensions-museum/*.tgz /charts/

ENTRYPOINT ["/chartmuseum","--storage-local-rootdir","/charts","--storage","local"]