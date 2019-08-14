
NAME = paulbrodner/jenkins
VERSION = 2.176.2
JENKINSX_TAG= 0.0.70

build: ## build a new image of jenkins
	docker build . -t $(NAME):$(VERSION) --build-arg JENKINSX_TAG=$(JENKINSX_TAG)
	docker push $(NAME):$(VERSION)