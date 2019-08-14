# export AWS_REGION?=eu-west-3
# DOMAIN?=dbp.dev.alfresco.me
# ENV_PREFIX=dbp
# GIT_USERNAME?=paulbrodner
# JENKINS_VERSION?=v1.0.14

include config
export $(shell sed 's/=.*//' config)

.DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

jx-cli-upgrade:	## upgrade jx cli
	jx upgrade cli -v $(JENKINS_CLI)

jx-install: ## install jenkins-x (see myvalues.yaml)
	jx install --versions-ref='$(JENKINS_VERSION)' \
	--static-jenkins --provider=eks \
	--domain=$(DOMAIN) \
	--advanced-mode --user-cluster-role='cluster-admin' \
	--external-dns --long-term-storage=false \
	--default-environment-prefix=$(ENV_PREFIX) \
	--git-username $(GIT_USERNAME) \
	--git-api-token $(GIT_API_TOKEN)

jx-uninstall: ## uninstall jenkins-x
	jx uninstall

jx-upgrade: ## upgrade the Jenkins installation based on myvalues.yaml
	jx upgrade platform --local-cloud-environment=false --versions-ref='$(JENKINS_VERSION)' --always-upgrade=true
	
jx-sh: ## remote shell
	@jx namespace
	@jx rsh	

get-eks: ## show eks clusters
	jx get eks	

cluster-proxy: ## open k8s cluster
	@kubectl proxy &
	@echo Opening K8S Dashboard localy via proxy, click Skip on login page! 	
	open http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
	@make cluster-get-token	

cluster-get-token: ## get token to login
	$(eval SECRET_NAME := $(shell kubectl --namespace kube-system get secret | grep kubernetes-dashboard-token| awk '{print $$1}'))	
	kubectl --namespace kube-system describe secret $(SECRET_NAME)
