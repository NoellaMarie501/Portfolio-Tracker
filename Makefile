ROOT_DIR       := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SHELL          := $(shell which bash)
PROJECT_NAME    = portfolio-tracker
ARGS            = $(filter-out $@,$(MAKECMDGOALS))

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
default: help-default;   # default target
Makefile: ;              # skip prerequisite discovery

.title:
	$(info Phalcon Compose: $(VERSION))
	$(info )

help-default help: .title
	@echo "                          ====================================================================="
	@echo "                          Help & Check Menu"
	@echo "                          ====================================================================="
	@echo "                   help: Show Phalcon Compose Help Menu: type: make help"
	@echo "                   status: List containers status"
	@echo "                          ====================================================================="
	@echo "                          Main Menu"
	@echo "                          ====================================================================="
	@echo "                   up: Create and start application in detached mode (in the background)"
	@echo "                   pull: Pull latest dependencies"
	@echo "                   deploy: build an image from the deployment dockerfile"
	@echo "                   stop: Stop application"
	@echo "                   dev: Setup developer build"
	@echo "                   root:  Login to the 'app' container as 'root' user"
	@echo "                   shell: Login to the 'app' container as 'nobody' user"
	@echo "                   start: Start application"
	@echo "                   test: Run all application tests"
	@echo "                   analysis: Run code analysis and send result to sonarqube"
	@echo "                   build: Build or rebuild services"
	@echo "                   reset: Reset all containers, delete all data, rebuild services and restart"
	@echo "                   php-cli: Run PHP interactively (CLI)"
	@echo ""

build:
	docker-compose --project-name $(PROJECT_NAME) build

up:
	docker-compose --project-name $(PROJECT_NAME) up -d
	
dev: build up
	docker exec -it -u root $$(docker-compose --project-name $(PROJECT_NAME) ps -q app) sh 

status:
	docker-compose --project-name $(PROJECT_NAME) ps

reset: stop clean build up

root:
	docker exec -it -u root $$(docker-compose --project-name $(PROJECT_NAME) ps -q app) /bin/bash

clean: stop
	docker-compose --project-name $(PROJECT_NAME) down --remove-orphans
logs:
	docker logs -f $$(docker-compose --project-name $(PROJECT_NAME) ps -q app)
%:
	@:
