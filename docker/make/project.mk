.PHONY: init start stop commands reset-fixtures jwt-generate-keys

## —— Project 🍊 ———————————————————————————————————————————————————————————————
init: build up jwt-generate-keys reset-fixtures cs-install start ## Build, configure, load fixtures and start the containers (webserver, DB...)

start: up ## Build docker if changes occurred and up all containers
	@echo "${GREEN}The Application should be up and running on ${BLUE}https://api.cytrums.local:${NGINX_PORT_HTTPS}/ping${RESET}"
	@echo "${GREEN}The Api should be up and running on ${BLUE}https://api.cytrums.local:${NGINX_PORT_HTTPS}/documentation${RESET}"
	@echo "${YELLOW}Execute ${RESET}make logs${YELLOW} to show application logs${RESET}"

stop: down ## Stop dockers

commands: ## Display all commands in the project namespace
	@$(SYMFONY) list app

reset-fixtures: ## Build the DB, control the schema validity, load fixtures and check the migration status
	@$(SYMFONY) doctrine:database:drop --force
	@$(SYMFONY) doctrine:database:create
	@$(SYMFONY) doctrine:mig:mig --no-interaction
	@$(SYMFONY) doctrine:schema:validate
	@$(SYMFONY) hautelook:fixtures:load --no-interaction

## —— JWT 🕸 ———————————————————————————————————————————————————————————————————
jwt-generate-keys: ## Generate the main JWT ket set (you can use the "lexik:jwt:generate-keypair" command now)
	@mkdir -p config/jwt
	@$(SYMFONY) lexik:jwt:generate-keypair --overwrite --no-interaction
