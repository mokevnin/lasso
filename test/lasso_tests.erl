-module(lasso_tests).

-include_lib("eunit/include/eunit.hrl").

lasso_test_() ->
  {foreach,
   fun start/0,
   fun stop/1,
   [fun check_length/1]
  }.

start() ->
  application:ensure_all_started(lasso),
  Dispatch = cowboy_router:compile([
                                    {'_', [{"/", hello_handler, []}]}
                                   ]),
  {ok, _} = cowboy:start_clear(my_http_listener, 5,
                               [{port, 8080}],
                               #{env => #{dispatch => Dispatch}}
                              ).

stop(_) -> ok.


check_length(_) ->
  ConnPid = lasso:open(#{port => 8080, protocol => http, transport => tcp}),
  {_, _, Body} = lasso:get(ConnPid, "/"),
  [?_assertEqual(<<"Hello Erlang!">>, Body)].
