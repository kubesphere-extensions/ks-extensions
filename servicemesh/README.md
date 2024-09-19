## Core Features

- Blue-green deployment: Create identical standby environments and run new application versions to ensure avoidance of downtime or service interruption.
- Canary release: Slowly push changes to a small portion of users to minimize version upgrade risks.
- Traffic mirroring: Replicate real-time production traffic and send it to mirroring services.
- Traffic monitoring: Visually displays the traffic situation between each microservice, and supports users to configure current limiting and circuit breakers.
- Link tracking: Visually displays key information such as the mutual calling relationship, span, and time consumption between each microservice.

## Installation

- Navigate to the KubeSphere Service Mesh extension component on the Extension Market page, select the latest version, and click the Next button.
- On the Extension Component Installation tab, click and modify the extension component configuration as needed. After configuration, click the Install button to begin installation.
- After installation is complete, click the Next button to proceed to the cluster selection page. Check the clusters that need to be installed, then click the Next button to proceed to the Differential Configuration page.
- Update the differential configuration according to requirements, then begin installation. Wait patiently for the installation to complete.

## Notes

- It is necessary to configure available Prometheus services and OpenSearch services in the configuration before using the related features of KubeSphere Service Mesh.

| Name | Meaning                 |Default                      | Range |
| ------------------------------------------------ | ------------------- | -------------------------------------------------------------------- | -------- |
| backend.istio.meshConfig.defaultConfig.tracing.sampling | Tracing Sampling Rate       | 1.0                                                                  | 1-100    |
| backend.kiali.prometheus_url                     | Promethus URL       | http://prometheus-k8s.kubesphere-monitoring-system.svc:9090     |          |
| backend.jaeger.storage.options.es.server-urls           | OpenSearch/ES URL   | https://opensearch-cluster-data.kubesphere-logging-system.svc:9200 |          |
| backend.jaeger.storage.options.es.username              | OpenSearch/ES Username | admin                                                                |          |
| backend.jaeger.storage.options.es.password              | OpenSearch/ES Password   | admin                                                                |          |
| backend.jaeger.storage.options.secretName         |         OpenSearch/ES  Secret 名             |                                                                      |          |
