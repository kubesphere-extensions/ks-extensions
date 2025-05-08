# What are KubeSphere Extensions?

KubeSphere 4.0 introduces a new microkernel architecture codenamed **LuBan**:

- **LuBan** enables dynamic extensibility for both frontend and backend capabilities.
- The core of KubeSphere has been modularized into **ks-core**, making the default installation much lighter.
- Many existing components have been decoupled into independent **KubeSphere Extensions**, which can be developed and released separately. This allows users to install only the components they need to customize their KubeSphere container management platform.

# Getting Started

## Prerequisites

A running KubeSphere cluster is required.

## Publishing Extensions

### Publishing via Helm

When installing the KubeSphere Helm chart, an `extension-museum` deployment will be created if `ksExtensionRepository.enabled` is set to `true`. This deployment includes the extensions from this repository.

```shell
helm upgrade --install -n kubesphere-system --create-namespace ks-core https://charts.kubesphere.io/main/ks-core-1.1.4.tgz --set ksExtensionRepository.enabled=true
```

> **Note:** The `ksExtensionRepository.enabled` flag is `true` by default.

### Publishing via KSBuilder

1. Download KSBuilder from the [GitHub Releases page](https://github.com/kubesphere/ksbuilder/releases).

2. Publish an extension to your KubeSphere cluster:

```shell
ksbuilder publish <extension-dir> --kubeconfig <kubeconfig-file>
```

- `<extension-dir>`: Path to your extension directory  
- `<kubeconfig-file>`: Path to your kubeconfig file used to connect to the cluster

### Finding Your Extension in KubeSphere

Once published, the extension will appear in the `KubeSphere Marketplace`.

# Contributing

You can develop a new extension by following the [KubeSphere Extension Development Guide](https://dev-guide.kubesphere.io/extension-dev-guide).

We welcome contributions! If you have ideas for new features or improvements, feel free to open a pull request.

# Issues

If you encounter any problems while using these extensions or running related tests, please open an issue in this repository.

# License

This repository is licensed under the Apache License 2.0. For more details, see the [LICENSE](./LICENSE) file.
