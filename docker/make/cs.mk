.PHONY: cs cs-install

## —— Coding standards ✨ ——————————————————————————————————————————————————————
cs-install: ## Lint files with php-cs-fixer
	@mkdir --parents tools/php-cs-fixer
	@$(DOCKER_COMPOSER) require --working-dir=tools/php-cs-fixer friendsofphp/php-cs-fixer

cs: ## Lint files with php-cs-fixer
	@$(PHP_CS_FIXER) fix --allow-risky=yes
