KSBUILDER_VERSION?=v0.3.11
ARCH?=amd64
IMAGE?=registry.cn-beijing.aliyuncs.com/kubespheredev/ks-extensions-museum
IMAGE_TAG?=dev


help:
	@grep -hE '^[ a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-17s\033[0m %s\n", $$1, $$2}'

.PHONY: generate-extensions-charts
generate-extensions-charts: generate-kse-extensions generate-kse-extensions-publish ## Generate charts template for kse-extensions and kse-extensions-publish

.PHONY: generate-kse-extensions
generate-kse-extensions: ksbuilder ## Generate kse-extensions charts code
	.deploy/hack/upgrade-kse-extensions.sh


.PHONY: generate-kse-extensions-publish
generate-kse-extensions-publish: ksbuilder ## Generate kse-extensions-publish charts code
	.deploy/hack/upgrade-kse-extensions-publish.sh

.PHONY: ksbuilder
ksbuilder: ## install ksbuilder in "bin/"
	if [ ! -d bin ]; then \
		mkdir bin; \
	fi
	if [ ! -f bin/ksbuilder ]; then \
		curl -L -O https://github.com/kubesphere/ksbuilder/releases/download/$(KSBUILDER_VERSION)/ksbuilder_$(patsubst v%,%,$(KSBUILDER_VERSION))_linux_$(ARCH).tar.gz; \
		tar -zxvf ksbuilder_$(patsubst v%,%,$(KSBUILDER_VERSION))_linux_$(ARCH).tar.gz -C bin/ ksbuilder; \
		rm -f ksbuilder_$(patsubst v%,%,$(KSBUILDER_VERSION))_linux_$(ARCH).tar.gz; \
  	fi

.PHONY: package-all-charts
package-all-charts: ksbuilder  ## package all extensions to helm charts
	if [ ! -d bin/_output  ]; then \
	    mkdir bin/_output; \
	fi
	for chart in $$(find . -mindepth 1 -maxdepth 1 -type d); do \
		if [ -f $${chart}/extension.yaml ] && grep -q "name" $${chart}/extension.yaml; then \
			bin/ksbuilder package $${chart}; \
			mv $${chart}-*.tgz bin/_output; \
		fi \
	done
