.DEFAULT_GOAL := help
.PHONY: help
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: load
load: ## Dumps the autoloader
	@composer dumpautoload

.PHONY: migrate
migrate: ## Runs migrations
	@php artisan migrate

.PHONY: refresh
refresh: ## Refresh the database
	@php artisan migrate:refresh

.PHONY: seed
seed: ## Seed the database
	@php artisan db:seed

.PHONY: rollback
rollback: ## Does a rollback
	@php artisan migrate:rollback

.PHONY: test
test: ## Runs tests
	-php artisan test
	-php artisan dusk

.PHONY: tt
tt: ## Runs the watcher tests
	./vendor/bin/phpunit-watcher watch

.PHONY: lint
lint: ## Analyse the code
	-php phpcpd.phar app/ --min-lines=50
	-./vendor/bin/phpmd app,config,routes,resources,tests text phpmd.xml
	-./vendor/bin/phpstan analyse --memory-limit=2G
	-./vendor/bin/phpcs
	-./vendor/bin/tlint
	-./node_modules/.bin/eslint . --fix
	-./node_modules/.bin/stylelint '**/*.scss' --fix

.PHONY: format
format: ## Format the code
	-./vendor/bin/phpcbf
	-./vendor/bin/tlint
