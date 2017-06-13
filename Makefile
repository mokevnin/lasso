compile:
	rebar3 compile

install:
	rebar3 get-deps

console: compile
	rebar3 shell

release:
	rebar3 release

test:
	rebar3 eunit

compose-bash:
	docker-compose run lasso bash

compose-build:
	docker-compose build

compose-release:
	docker-compose run lasso make release

compose-test:
	docker-compose run lasso make test

.PHONY: test

