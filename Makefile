include .env
include .env.local

default: up

COMPOSER_ROOT ?= /var/www/html
DRUPAL_ROOT ?= /var/www/html/web

## help	:	Print commands help.
.PHONY: help
ifneq (,$(wildcard docker.mk))
help : docker.mk
	@sed -n 's/^##//p' $<
else
help : Makefile
	@sed -n 's/^##//p' $<
endif

## init	:	Initialize project.
.PHONY: init
init:
	@echo "Initializing project \`$(PROJECT_NAME)\`..."
	@make --no-print-directory up
	@cp html/web/sites/default/example.settings.local.php html/web/sites/default/settings.local.php
	@make --no-print-directory composer install
	@sleep 30
	@make --no-print-directory drush cim
	@make --no-print-directory drush pmu demo_umami_content
	@make --no-print-directory drush en demo_umami_content
	@echo "Access Drupal at http://$(PROJECT_BASE_URL)"
	@echo "Access Storybook at http://storybook.$(PROJECT_BASE_URL)"

## up	:	Start up containers.
.PHONY: up
up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	@touch -a .env.local
	@docker compose --env-file .env --env-file .env.local pull
	@docker compose --env-file .env --env-file .env.local up -d --remove-orphans
	@git config core.hooksPath .hooks

.PHONY: mutagen
mutagen:
	mutagen-compose up

## down	:	Stop containers.
.PHONY: down
down: stop

## start	:	Start containers without updating.
.PHONY: start
start:
	@echo "Starting containers for $(PROJECT_NAME) from where you left off..."
	@docker compose --env-file .env --env-file .env.local start

## stop	:	Stop containers.
.PHONY: stop
stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker compose --env-file .env --env-file .env.local stop

## prune	:	Remove containers and their volumes.
##		You can optionally pass an argument with the service name to prune single container
##		prune mariadb	: Prune `mariadb` container and remove its volumes.
##		prune mariadb solr	: Prune `mariadb` and `solr` containers and remove their volumes.
.PHONY: prune
prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker compose --env-file .env --env-file .env.local down -v $(filter-out $@,$(MAKECMDGOALS))

## ps	:	List running containers.
.PHONY: ps
ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

## shell	:	Access `php` container via shell.
##		You can optionally pass an argument with a service name to open a shell on the specified container
.PHONY: shell
shell:
	@docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_$(or $(filter-out $@,$(MAKECMDGOALS)), 'php')' --format "{{ .ID }}") sh

## composer	:	Executes `composer` command in a specified `COMPOSER_ROOT` directory (default is `/var/www/html`).
##		To use "--flag" arguments include them in quotation marks.
##		For example: make composer "update drupal/core --with-dependencies"
.PHONY: composer
composer:
	@docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") composer --working-dir=$(COMPOSER_ROOT) $(filter-out $@,$(MAKECMDGOALS))

## drush	:	Executes `drush` command in a specified `DRUPAL_ROOT` directory (default is `/var/www/html/web`).
##		To use "--flag" arguments include them in quotation marks.
##		For example: make drush "watchdog:show --type=cron"
.PHONY: drush
drush:
	@docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") drush -r $(DRUPAL_ROOT) $(filter-out $@,$(MAKECMDGOALS))

## logs	:	View containers logs.
##		You can optinally pass an argument with the service name to limit logs
##		logs php	: View `php` container logs.
##		logs nginx php	: View `nginx` and `php` containers logs.
.PHONY: logs
logs:
	@docker compose --env-file .env --env-file .env.local logs -f $(filter-out $@,$(MAKECMDGOALS))

.PHONY: chromatic
chromatic:
	@docker compose --env-file .env --env-file .env.local run storybook npm run chromatic

.PHONY: init-codespaces
init-codespaces:
	@if [ -z "$$CODESPACES" ]; then \
		exit 1; \
    fi
	@echo "Initializing Codespaces environment."
	@make --no-print-directory init


# https://stackoverflow.com/a/6273809/1826109
%:
	@:
