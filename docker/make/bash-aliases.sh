#!/usr/bin/env sh

# Docker-Compose helpers
alias run-in-container='docker-compose run --rm'
alias docker-restart='docker-compose kill && docker-compose rm && sudo service docker restart' # sometimes, Docker cache must be reinitialized
alias docker-stop-all='docker stop $(docker ps -a -q)' # stop all containers

# App
alias te-start-nginx='docker-compose up -d nginx && docker-compose up -d php-fpm'
alias te-console='docker-compose run --rm php-fpm php -d memory_limit=-1 bin/console'
alias te-php='docker-compose run --rm php-fpm php'
alias te-chmod='sudo chmod -R 777 ./*'

# Composer
alias te-composer='docker-compose run --rm php-fpm composer'

alias te-composer-require='te-composer require'
alias te-composer-update='te-composer update'
alias te-composer-install='te-composer install'
alias te-composer-remove='te-composer remove'
alias te-cache-clear='sudo rm -fr var/cache/* && te-console cache:clear && sudo chmod -R 777 var/logs/* var/cache/*'

# Adminer
alias te-start-adminer='docker-compose up -d --no-deps adminer'

# App
alias te-fixtures-load='te-console hautelook:fixtures:load --no-bundles'
alias te-chmod-mysqlconf='chmod 0644 docker/mysql/shared/conf.d/my.cnf && docker-compose up -d --force-recreate mysql'
alias te-all-data-not-safe='te-chmod-mysqlconf && te-console doc:dat:drop --force && te-console doc:dat:create && te-console doc:mig:mig --no-interaction && te-fixtures-load --no-interaction --append'

# Utils
alias te-phpcs='te-php ./tools/php-cs-fixer/vendor/bin/php-cs-fixer fix'
alias te-delete-logs='sudo rm -rf var/log/*'
alias te-copy-fixtures-to-test="cp -a src/Fixtures/dev/. src/Fixtures/test"
alias te-copy-fixtures-to-staging="cp -a src/Fixtures/dev/. src/Fixtures/staging"

# Test
alias te-tests-reset-database='te-chmod && rm -f var/app.db && rm -f var/app.db.bak && te-console doc:dat:create --env=test && te-console doc:schema:create --env=test && te-console doc:schema:update --force --env=test && te-console hautelook:fixtures:load  --no-interaction --no-bundles --env=test && cp var/app.db var/app.db.bak'
alias te-phpunit='te-php -d memory_limit=-1 vendor/bin/phpunit --configuration /var/www/phpunit.xml.dist'
alias te-phpunit-verbose='te-phpunit --testdox'
alias te-phpunit-filter='te-phpunit --filter'
alias te-phpunit-coverage='te-phpunit --coverage-html=test-coverage'
