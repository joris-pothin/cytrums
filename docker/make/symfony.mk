.PHONY: cc fix-perms purge console

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
cc: ## Clear the cache. DID YOU CLEAR YOUR CACHE????
	@$(SYMFONY) c:c

fix-perms: ## Fix permissions of all var files
	$(DOCKER_PHP) chmod -R 777 var/*

purge: ## Purge cache and logs
	@rm -rf var/cache/* var/log/*

console:  ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

migration: ## generate db migration file
	@$(SYMFONY) make:migration
