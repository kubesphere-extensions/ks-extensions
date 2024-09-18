# HTTP API

The HTTP API can be accessed at `/alerting.kubesphere.io/v2beta1` on the extension apiserver. When integrating with KSE 4.x and making API requests through the KubeSphere APIServer, which provides user authorization and authentication, an additional `/proxy` prefix is required.

## Project Level

| Operation | Http Method | Subpath
| --- | --- | ---
| create a rulegroup | POST |  `/clusters/{cluster}/namespaces/{namespace}/rulegroups`
| update a rulegroup | PUT/PATCH | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| list rulegroups | GET | `/clusters/{cluster}/namespaces/{namespace}/rulegroups`
| delete a rulegroup | DELETE | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| list alerts of rulegroups | GET | `/clusters/{cluster}/namespaces/{namespace}/alerts`

## Cluster Level

| Operation | Http Method | Subpath
| --- | --- | ---
| create a clusterrulegroup | POST |  `/clusters/{cluster}/clusterrulegroups`
| update a clusterrulegroup | PUT/PATCH | `/clusters/{cluster}/clusterrulegroups/{name}`
| list clusterrulegroups | GET | `/clusters/{cluster}/clusterrulegroups`
| delete a clusterrulegroup | DELETE | `/clusters/{cluster}/clusterrulegroups/{name}`
| list alerts of clusterrulegroups | GET | `/clusters/{cluster}/clusteralerts`

When the Whizard Observability Center is not enabled (without whizard), there are some built-in cluster rule groups distinguished from the custom cluster rule groups by a `builtin` parameter: `builtin=true` for built-in cluster rule groups, but `builtin=false` for custom cluster rule groups. (Only for query)

## Global Level

Supported only when the Whizard Observability Center is enabled (with whizard).

| Operation | Http Method | Subpath
| --- | --- | ---
| create a globalrulegroup | POST |  `/globalrulegroups`
| update a globalrulegroup | PUT/PATCH | `/globalrulegroups/{name}`
| list globalrulegroups | GET | `/globalrulegroups`
| delete a globalrulegroup | DELETE | `/globalrulegroups/{name}`
| list alerts of globalrulegroups | GET | `/globalalerts`

There are some built-in global rule groups distinguished from the custom global rule groups by a `builtin` parameter: `builtin=true` for builtin global rule groups, but `builtin=false` for custom global rule groups. (Only for query)

## Changes compared to KSE 3.5

Compared to KSE 3.5, the primary changes are in the request paths as follows:

| Operation | Http Method | KSE 3.5 | KSE 4.1 (with a same prefix `/proxy/alerting.kubesphere.io/v2beta1`)
| --- | --- | --- | ---
| create a rulegroup | POST | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups` | `/clusters/{cluster}/namespaces/{namespace}/rulegroups` 
| update a rulegroup | PUT/PATCH |	`/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups/{name}` | `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| list rulegroups | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups` | `/clusters/{cluster}/namespaces/{namespace}/rulegroups`
| get a rulegroup | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups/{name}` |	`/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| delete a rulegroup | DELETE | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/rulegroups/{name}`	| `/clusters/{cluster}/namespaces/{namespace}/rulegroups/{name}`
| list alerts of rulegroups | GET	| `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/namespaces/{namespace}/alerts` | `/clusters/{cluster}/namespaces/{namespace}/alerts`
| create a clusterrulegroup | POST | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups` | `/clusters/{cluster}/clusterrulegroups`
| update a clusterrule group | PUT/PATCH | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups/{name}` | `/clusters/{cluster}/clusterrulegroups/{name}`
| list custom clusterrulegroups | GET	| `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups` | `/clusters/{cluster}/clusterrulegroups?builtin=false`
| get a clusterrulegroup | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups/{name}` |	`/clusters/{cluster}/clusterrulegroups/{name}`
| delete a clusterrulegroup | DELETE | `/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusterrulegroups/{name}` | `/clusters/{cluster}/clusterrulegroups/{name}`
| list alerts of custom clusterrulegroups | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/clusteralerts` | `/clusters/{cluster}/clusteralerts?builtin=false`
| update a builtin rule group<br/>(when the Whizard Observability Center is not enabled)  | PUT/PATCH |	`/apis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` |	`/clusters/{cluster}/clusterrulegroups/{name}`
| list builtin rule groups<br/>(when the Whizard Observability Center is not enabled) | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalrulegroups` | `/clusters/{cluster}/clusterrulegroups?builtin=true`
| get a builtin rule group<br/>(when the Whizard Observability Center is not enabled) | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/clusters/{cluster}/clusterrulegroups/{name}`
| list alerts of builtin rule groups<br/>(when the Whizard Observability Center is not enabled) | GET | `/kapis/clusters/{cluster}/alerting.kubesphere.io/v2beta1/globalalerts` |	`/clusters/{cluster}/clusteralerts?builtin=true`
| create a globalrulegroup | POST | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups` | `/globalrulegroups`
| update a globalrulegroup | PUT/PATCH | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| list custom globalrulegroups | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalrulegroups?builtin=false` | `/globalrulegroups?builtin=false`
| get a globalrulegroup | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| delete a globalrulegroup | DELETE | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| list alerts of custom globalrulegroups | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalalerts?builtin=false` | `/globalalerts?builtin=false`
| update a globalrulegroup | PUT/PATCH | `/apis/alerting.kubesphere.io/v2beta1/globalrulegroups/{name}` | `/globalrulegroups/{name}`
| list builtin rule groups<br/>(when the Whizard Observability Center is enabled) | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalrulegroups?builtin=true` | `/globalrulegroups?builtin=true`
| list alerts of builtin rule groups<br/>(when the Whizard Observability Center is enabled) | GET | `/kapis/alerting.kubesphere.io/v2beta1/globalalerts?builtin=true` | `/globalalerts?builtin=true`

The request body and response data structures remain unchanged.

For more details, please refer to [the swagger api document](https://github.com/kubesphere-extensions/kse-extensions/blob/v4.1.0/whizard-alerting/swagger.yaml).