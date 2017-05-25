-module(lasso_tests).

-include_lib("eunit/include/eunit.hrl").

lasso_test_() ->
  {setup,
   fun start/0,
   fun stop/1,
   fun(SetupData) ->
       {inparallel,
        [
         check_length(SetupData)
        ]}
   end}.

start() ->
  application:ensure_all_started(lasso),
  Dispatch = cowboy_router:compile([
                                    {'_', [{"/", hello_handler, []}]}
                                   ]),
  {ok, _} = cowboy:start_clear(my_http_listener, 5,
                               [{port, 8080}],
                               #{env => #{dispatch => Dispatch}}
                              ),
  ok.

stop(_) -> ok.


check_length(_) ->
  ConnPid = lasso:open(#{port => 8080, protocol => http, transport => tcp}),
  {_, _, <<"Hello Erlang!">>} = lasso:get(ConnPid, "/"),
  ok.
