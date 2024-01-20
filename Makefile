# Executables (local)
DOCKER_COMP = docker-compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec app

# Executables
PHP      = $(PHP_CONT) php
COMPOSER = $(PHP_CONT) composer
SYMFONY  = $(PHP) bin/console
FIXTURES = `cat tests/fixtures/fixtures.sql`

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up start down logs sh composer vendor sf cc test

## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
start: ## Start docker containers
	@echo "Start Containers"
	@$(DOCKER_COMP) up -d
	@$(DOCKER_COMP) ps

stop: ## Stop docker containers
	@echo "Stop Containers"
	@$(DOCKER_COMP) stop ${DOCKER_SERVICES}
	@sleep 1
	@$(DOCKER_COMP) ps

rm: stop ## Remove docker containers
	@echo "Remove Containers"
	@$(DOCKER_COMP) rm -v -f ${DOCKER_SERVICES}

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=100 --follow

sh: ## Connect to the FrankenPHP container
	@$(PHP_CONT) sh

## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

composer-install: ## Run composer install
	@$(COMPOSER) install

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

cc: c=c:c ## Clear the cache
cc: sf

migration-generate: ## Generate new migration file
	@$(SYMFONY) doctrine:migrations:generate

migration-up: ## Run migration up
	@$(SYMFONY) doctrine:migrations:migrate -n

migration-down: ## Run migration down
	@$(SYMFONY) doctrine:migrations:migrate prev -n

test-functional: ## Run functional tests
	@$(PHP) ./vendor/bin/phpunit --configuration=phpunit.functional.xml

load-fixtures: ## Load database fixtures
	$(SYMFONY) doctrine:query:sql "$(FIXTURES)"
