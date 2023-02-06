.PHONY: vendor-install vendor-update-lock vendor-validate-lock

## —— Composer 🧙‍♂️ ————————————————————————————————————————————————————————————
vendor-install: composer.lock ## Install vendors according to the current composer.lock file
	@$(DOCKER_COMPOSER) install --no-progress --prefer-dist --optimize-autoloader

vendor-update: ##@vendor Troll task !
	@echo "${RED}"
	@echo "  ____            _   _     _              _"
	@echo " |  _ \          | | (_)   | |            | |"
	@echo " | |_) | __ _  __| |  _  __| | ___  __ _  | |"
	@echo " |  _ < / _  |/ _  | | |/ _  |/ _ \/ _  | | |"
	@echo " | |_) | (_| | (_| | | | (_| |  __/ (_| | |_|"
	@echo " |____/ \__,_|\__,_| |_|\__,_|\___|\__,_| (_)"
	@echo "\n I'm sure you don't want to update all dependencies of the project, it's a dangerous move"
	@echo "${GREEN}If you want to update one package :"
	@echo "make ssh-php"
	@echo "composer update package-domain/super-package"
	@echo "${RESET}"

vendor-update-lock: ##@vendor Updates composer.lock hash without updating any packages
	@$(DOCKER_COMPOSER) update --lock

vendor-validate-lock: ##@vendor Check if the composer.lock is valid
	@$(DOCKER_COMPOSER) validate --no-check-all
