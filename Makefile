THIS_FILE := $(lastword $(MAKEFILE_LIST))
.PHONY: help init new-project up down destroy stop restart remake exec a composer db-clear
help:
	make -pRrq  -f $(THIS_FILE) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
init:
	composer install
	docker compose  up -d
	php artisan migrate
new-project:
	composer create-project laravel/laravel $(path)
	docker compose  up -d
	php artisan migrate
up:
	docker compose  up -d $(c)
down:
	docker compose  down $(c)
destroy:
	docker compose  down -v $(c)
stop:
	docker compose  stop $(c)
restart:
	docker compose  stop
	docker compose  up -d
remake:
	docker compose  down -v
	docker compose  up -d
exec:
	docker compose exec -it app $(c)
a:
	docker compose exec -it app php artisan $(c)
composer:
	docker compose exec -it app composer $(c)
db-clear:
	sudo rm -rf docker/database
