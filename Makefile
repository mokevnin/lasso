install:
	bin/rebar3 get-deps

compile:
	bin/rebar3 compile

release:
	bin/rebar3 release
test:
	bin/rebar3 eunit

.PHONY: test
