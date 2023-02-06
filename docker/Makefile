ROOT_DIR := $(realpath $(dir)../)
DOCKER_DIR := $(ROOT_DIR)/docker
API_DIR := $(ROOT_DIR)/cytrums-api
FRONT_DIR := $(ROOT_DIR)/cytrums-front

include .env
include $(DOCKER_DIR)/make/variables.mk
include $(DOCKER_DIR)/make/docker.mk
include $(DOCKER_DIR)/make/vendors.mk
include $(DOCKER_DIR)/make/cs.mk
include $(DOCKER_DIR)/make/symfony.mk
include $(DOCKER_DIR)/make/project.mk
include $(DOCKER_DIR)/make/tests.mk

# Misc
.DEFAULT_GOAL = help
.PHONY        : # Not needed here, but you can put your all your targets to be sure
                # there is no name conflict between your files and your targets.

help: ## Outputs this help screen
	@echo "\033[33mUsage:\033[0m"
	@echo "  make [command]"
	@echo ""
	@echo "\033[33mAvailable commands:\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = "[:]"}; {printf "  \033[32m%s\033[0m___%s\n", $$2, $$3}' | column -ts___
