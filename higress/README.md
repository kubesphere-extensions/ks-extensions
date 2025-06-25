## What is Higress?

Higress is a cloud-native API gateway with a kernel based on Istio and Envoy. It supports writing Wasm plugins in Go/Rust/JS and other languages, provides dozens of ready-to-use common plugins, and includes an out-of-the-box console ([demo here](http://demo.higress.io/)).

Higress's AI gateway capabilities support all [mainstream model providers](https://github.com/alibaba/higress/tree/main/plugins/wasm-go/extensions/ai-proxy/provider) both domestic and international. It also supports hosting MCP (Model Context Protocol) Servers through its plugin mechanism, enabling AI Agents to easily call various tools and services. With the [openapi-to-mcp tool](https://github.com/higress-group/openapi-to-mcpserver), you can quickly convert OpenAPI specifications into remote MCP servers for hosting. Higress provides unified management for both LLM API and MCP API. 

## Installation

1. Go to the **KubeSphere Marketplace** page and find the **Higress** extension. Click the **Install** button. Select the latest version and click the **Next** button.
2. On the **Extension Installation** tab, click and modify the **Extension Config** according to your needs. After configuring, click the **Start Installation** button to start the installation.
3. After the installation is complete, click the **Next** button to go to the cluster selection page. Check the clusters you want to install and click the **Next** button to go to the **Differential Configuration** page.
4. Update the **Differential Configuration** according to your needs. After updating, start the installation and wait for the installation to complete.

> By default, the Higress Gateway is exposed via a Service of type `LoadBalancer`. If the Kubernetes cluster does not support the `LoadBalancer` type, you can change the `higress.higress-core.gateway.service.type` parameter to `NodePort` or `ClusterIP`.

## Use Cases

- **AI Gateway**:

  Higress can interface with all domestic and international LLM model providers using a unified protocol, while providing rich AI observability, multi-model load balancing/fallback, AI token flow control, AI caching, and other capabilities:

  ![](https://img.alicdn.com/imgextra/i1/O1CN01fNnhCp1cV8mYPRFeS_!!6000000003605-0-tps-1080-608.jpg)

- **MCP Server Hosting**:

  Higress, as an Envoy-based API gateway, supports hosting MCP Servers through plugins. MCP (Model Context Protocol) is essentially an AI-friendly API that enables AI Agents to more easily invoke various tools and services. Higress can uniformly handle authentication/authorization/rate limiting/observability capabilities for tool invocations, simplifying AI application development and deployment.

  ![](https://img.alicdn.com/imgextra/i3/O1CN01K4qPUX1OliZa8KIPw_!!6000000001746-2-tps-1581-615.png)

  By hosting MCP Servers through Higress, you can achieve:
  - Unified authentication and authorization mechanisms to ensure the security of AI tool invocations
  - Fine-grained rate limiting to prevent abuse and resource exhaustion
  - Complete audit logs recording all tool invocation behaviors
  - Rich observability for monitoring tool invocation performance and health
  - Simplified deployment and management through Higress plugin mechanisms to quickly add new MCP Servers
  - Zero-downtime dynamic updates: Thanks to Envoy's friendly support for long connections and the dynamic update mechanism of Wasm plugins, MCP Server logic can be updated in real-time with zero impact on traffic, without causing any connection drops

- **Kubernetes Ingress Gateway**:

  Higress can serve as an Ingress gateway for K8s clusters and is compatible with a large number of K8s Nginx Ingress annotations, allowing for quick and smooth migration from K8s Nginx Ingress to Higress.
  
  Supports the [Gateway API](https://gateway-api.sigs.k8s.io/) standard, enabling users to smoothly migrate from Ingress API to Gateway API.

  Compared to ingress-nginx, resource overhead is significantly reduced, and route change effectiveness speed is improved by ten times:

  ![](https://img.alicdn.com/imgextra/i1/O1CN01bhEtb229eeMNBWmdP_!!6000000008093-2-tps-750-547.png)
  ![](https://img.alicdn.com/imgextra/i1/O1CN01bqRets1LsBGyitj4S_!!6000000001354-2-tps-887-489.png)
  
- **Microservice Gateway**:

  Higress can serve as a microservice gateway, capable of interfacing with various types of service registries to discover services and configure routes, such as Nacos, ZooKeeper, Consul, Eureka, etc.
  
  It is deeply integrated with microservice technology stacks like [Dubbo](https://github.com/apache/dubbo), [Nacos](https://github.com/alibaba/nacos), and [Sentinel](https://github.com/alibaba/Sentinel). Based on the excellent performance of the Envoy C++ gateway kernel, it can significantly reduce resource utilization and costs compared to traditional Java microservice gateways.

  ![](https://img.alicdn.com/imgextra/i4/O1CN01v4ZbCj1dBjePSMZ17_!!6000000003698-0-tps-1613-926.jpg)
  
- **Security Protection Gateway**:

  Higress can serve as a security protection gateway, providing WAF capabilities and supporting multiple authentication and authorization strategies, such as key-auth, hmac-auth, jwt-auth, basic-auth, oidc, etc.

## Core Advantages

- **Production Grade**

  Derived from Alibaba's internal product with over 2 years of production validation, supporting large-scale scenarios with hundreds of thousands of requests per second.

  Completely eliminates traffic jitter caused by Nginx reloads, with configuration changes taking effect in milliseconds and being transparent to business operations. Particularly friendly to long-connection scenarios like AI services.

- **Streaming Processing**

  Supports true full streaming processing of request/response bodies, with Wasm plugins easily customizing the processing of streaming protocol messages like SSE (Server-Sent Events).

  In high-bandwidth scenarios like AI services, it can significantly reduce memory overhead.
    
- **Easy to Extend**
  
  Provides a rich official plugin library covering AI, traffic management, security protection, and other common functions, meeting over 90% of business scenario requirements.

  Features Wasm plugin extensions with sandbox isolation ensuring memory safety, supporting multiple programming languages, allowing independent plugin version upgrades, and achieving zero-downtime hot updates of gateway logic.

- **Secure and Easy to Use**
  
  Based on Ingress API and Gateway API standards, providing an out-of-the-box UI console with ready-to-use WAF protection plugins and IP/Cookie CC protection plugins.

  Supports integration with Let's Encrypt for automatic issuance and renewal of free certificates, and can be deployed independently of K8s with a single Docker command, making it convenient for individual developers.
