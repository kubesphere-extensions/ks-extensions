
## Dockerless

As we know, Kubernetes can run on several [different container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/). 
For example, it could be [containerd](https://github.com/containerd/containerd), docker, etc.

Now the chart can auto-detect container runtime for agent in `_helpers.tpl`;
