DOCKER_REGISTRY := docker.dragonfly.co.nz
IMAGE_NAME := $(shell basename `git rev-parse --show-toplevel`)-shiny
IMAGE := $(DOCKER_REGISTRY)/$(IMAGE_NAME)
RUN ?= docker run $(DOCKER_ARGS) -p $(PORT):$(PORT) --rm -v $$(pwd)/..:/work -w /work/shiny -u $(UID):$(GID) $(IMAGE)
UID ?= $(shell id -u)
GID ?= $(shell id -g)
DOCKER_ARGS ?= 
GIT_TAG ?= $(shell git log --oneline | head -n1 | awk '{print $$1}')
HOST ?= 127.0.0.1
PORT ?= 3077

all:

.PHONY: data run local

run: data
	 $(RUN) Rscript -e "shiny::runApp('.', port=$(PORT), host = '$(HOST)')"

local: data
	 $(RUN) Rscript -e "shiny::runApp('.', port=$(PORT), host = '127.0.0.1')"

ngrok:
	/home/yvan/ngrok http 3077

data: data/.data
data/.data: data.r
	$(RUN) Rscript data.r  &&  touch data/.data

deploy:
	$(RUN) Rscript -e "rsconnect::deployApp('.', appName='app-demo')"

.PHONY: docker
docker:
	docker build --tag $(IMAGE):$(GIT_TAG) .
	docker tag $(IMAGE):$(GIT_TAG) $(IMAGE):latest

.PHONY: docker-push
docker-push:
	docker push $(IMAGE):$(GIT_TAG)
	docker push $(IMAGE):latest

.PHONY: docker-pull
docker-pull:
	docker pull $(IMAGE):$(GIT_TAG)
	docker tag $(IMAGE):$(GIT_TAG) $(IMAGE):latest

.PHONY: enter
enter: DOCKER_ARGS=-it
enter:
	$(RUN) bash

.PHONY: enter-root
enter-root: DOCKER_ARGS=-it
enter-root: UID=root
enter-root: GID=root
enter-root:
	$(RUN) bash
