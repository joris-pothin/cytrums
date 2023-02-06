.PHONY: test-reset-db test test-all test-with-coverage test-verbose

## —— Tests ✅ —————————————————————————————————————————————————————————————————
test-reset-db:
	@rm -f var/app.db
	@rm -f var/app.db.bak
	@$(SYMFONY) doc:dat:create --env=test
	@$(SYMFONY) doc:schema:create --env=test
	@$(SYMFONY) doc:schema:update --force --env=test
	@$(SYMFONY) hautelook:fixtures:load  --no-interaction --no-bundles --env=test
	@cp var/app.db var/app.db.bak

test: phpunit.xml.dist ## Run tests with optional suite and filter
	@$(eval testsuite ?= 'all')
	@$(eval filter ?= '.')
	@$(PHPUNIT) --filter=$(filter)

test-all: test-reset-db phpunit.xml.dist ## Run all tests
	@$(PHPUNIT)

test-with-coverage:
	@$(PHPUNIT) --coverage-html=test-coverage

test-verbose:
	@$(PHPUNIT) --testdox
