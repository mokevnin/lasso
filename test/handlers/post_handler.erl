-module(post_handler).

-export([init/2]).

init(Req0, State) ->
  {ok, Body, Req1} = cowboy_req:read_body(Req0),
  Req2 = cowboy_req:reply(200,
                         #{<<"content-type">> => <<"application/json">>},
                         Body,
                         Req1),
  {ok, Req2, State}.
