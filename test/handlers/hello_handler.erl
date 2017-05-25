-module(hello_handler).

-export([init/2]).

init(Req0, State) ->
  % throw('asdf'),
  Req = cowboy_req:reply(200,
                         #{<<"content-type">> => <<"text/plain">>},
                         <<"Hello Erlang!">>,
                         Req0),
  {ok, Req, State}.
