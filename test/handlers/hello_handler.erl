-module(hello_handler).

-export([init/3]).
-export([terminate/3]).
-export([handle/2]).

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req0, State) ->
  Req = cowboy_req:reply(200,
                         [{<<"content-type">>, <<"text/plain">>}],
                         <<"Hello Erlang!">>,
                         Req0),
  {ok, Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.
