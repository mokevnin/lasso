-module(lasso_tests).
-compile([export_all]).

-include_lib("eunit/include/eunit.hrl").

reverse_test() -> lists:reverse([1,2,3]).
