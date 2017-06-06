REBAR=./bin/rebar3

install:
	@$(REBAR) get-deps

compile:
	@$(REBAR) compile

release:
	@$(REBAR) release

test:
	@$(REBAR) eunit

.PHONY: test
