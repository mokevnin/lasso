# lasso

[![Build Status](https://travis-ci.org/mokevnin/lasso.svg?branch=master)](https://travis-ci.org/mokevnin/lasso)

# Using

```erlang
-module(my_tests).

-include_lib("eunit/include/eunit.hrl").

my_test_() ->
  {foreach,
   fun start/0,
   fun stop/1,
   [
    fun check_get/1,
    fun check_post/1
   ]
  }.

start() ->
  Port = 8080,
  ListenerName = my_http_listener,
  application:ensure_all_started(lasso),
  Dispatch = cowboy_router:compile([
                                    {'_', [
                                           {"/", hello_handler, []},
                                           {"/echo", post_handler, []}
                                          ]}
                                   ]),
  {ok, _} = cowboy:start_clear(ListenerName, 5,
                               [{port, Port}],
                               #{env => #{dispatch => Dispatch}}
                              ),
  ConnPid = lasso:open(#{port => Port, protocol => http, transport => tcp}),
  #{ conn => ConnPid, listener_name => ListenerName }.

stop(#{ conn := ConnPid, listener_name := ListenerName }) ->
  lasso:close(ConnPid),
  cowboy:stop_listener(ListenerName),
  ok.


check_get(#{ conn := ConnPid }) ->
  {_, _, Body} = lasso:get(ConnPid, "/"),
  [?_assertEqual(<<"Hello Erlang!">>, Body)].

check_post(#{ conn := ConnPid }) ->
  RequestBody = <<"{\"msg\": \"Hello world!\"}">>,
  {_, _, Body} = lasso:post(ConnPid, "/echo", [{<<"content-type">>, "application/json"}], RequestBody),
  [?_assertEqual(RequestBody, Body)].
```
