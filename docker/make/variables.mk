# Executables
DOCKER        = docker
DOCKER_COMPOSE   = docker-compose

DOCKER_PHP    = $(DOCKER_COMPOSE) exec -T php-fpm
DOCKER_PHP_BASH = $(DOCKER_PHP) bash
DOCKER_PHP_RUN_PHP = $(DOCKER_PHP) php -d memory_limit=-1
DOCKER_COMPOSER = $(DOCKER_PHP) composer

DOCKER_MYSQL_BASH = $(DOCKER_COMPOSE) run --rm mysql bash

# Alias
SYMFONY       = $(DOCKER_PHP_RUN_PHP) bin/console

# Executables: vendors
PHPUNIT       = $(DOCKER_PHP_RUN_PHP) -d memory_limit=-1 ./vendor/bin/phpunit --configuration /var/www/phpunit.xml.dist
PHP_CS_FIXER  = $(DOCKER_PHP_RUN_PHP) ./tools/php-cs-fixer/vendor/bin/php-cs-fixer

# Perl Colors, with fallback if tput command not available
GREEN  := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 2 || echo "")
BLUE   := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 4 || echo "")
WHITE  := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 7 || echo "")
YELLOW := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 3 || echo "")
RED    := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 1 || echo "")
RESET  := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm sgr0 || echo "")
