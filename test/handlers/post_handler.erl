-module(post_handler).

-export([handle/2]).
-export([init/3]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req0, State) ->
  {ok, Body, Req1} = cowboy_req:body(Req0),
  Req2 = cowboy_req:reply(200,
                         [{<<"content-type">>, <<"application/json">>}],
                         Body,
                         Req1),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
	ok.
