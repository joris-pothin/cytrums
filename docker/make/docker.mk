.PHONY: ssh-php ssh-sql up build down logs restart

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
ssh-php:
	@$(DOCKER_PHP_BASH)

ssh-sql:
	@$(DOCKER_MYSQL_BASH)

up: ## Start all docker containers
	$(DOCKER_COMPOSE) up --no-recreate --detach --remove-orphans

build: ## Builds the containers
	$(DOCKER_COMPOSE) build --pull --no-cache

down: ## Stop the docker hub
	$(DOCKER_COMPOSE) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMPOSE) logs --tail=0 --follow

restart-force: ## Kill and restart all containers
	$(DOCKER_COMPOSE) kill && $(DOCKER_COMPOSE) rm && sudo service docker restart

restart: down up reset-fixtures  ## Stop and start all containers
