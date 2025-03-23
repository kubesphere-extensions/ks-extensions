KSBUILDER_VERSION?=v0.3.11
ARCH?=amd64


help:
	@grep -hE '^[ a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-17s\033[0m %s\n", $$1, $$2}'

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
	    mkdir .extensions-museum; \
	fi
	for chart in $$(find . -mindepth 1 -maxdepth 1 -type d); do \
		if [ -f $${chart}/extension.yaml ] && grep -q "name" $${chart}/extension.yaml; then \
			bin/ksbuilder package $${chart}; \
			mv $${chart}-*.tgz .extensions-museum; \
		fi \
	done
