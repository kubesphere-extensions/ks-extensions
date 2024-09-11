[Gatekeeper](https://github.com/open-policy-agent/gatekeeper) is an admission controller for Kubernetes that allows flexible configuration of policies, using [Open Policy Agent (OPA)](https://www.openpolicyagent.org/) to validate requests to create and update resources on a Kubernetes cluster.

Gatekeeper enables the flexible definition of admission policies, enforcing security admission reviews at the cluster level to ensure stability and regulatory compliance of Kubernetes clusters.

Key features of Gatekeeper include:

1. **Flexibility:** Gatekeeper allows users to declaratively define admission policies that apply to selected namespaces and resource types.

2. **Programmability:** Gatekeeper uses Open Policy Agent (OPA) as its decision engine, enabling complex security policy definitions using Rego.

3. **Rollout:** Supports gradual enforcement of admission policies in a phased manner to mitigate the risk of disrupting workloads.

4. **Pre-release mechanism:** Gatekeeper provides mechanisms to test the impact and scope of security policies before enforcement.

[OPA Gatekeeper Library](https://open-policy-agent.github.io/gatekeeper-library/website/) provides a collection of commonly used security admission policies.
