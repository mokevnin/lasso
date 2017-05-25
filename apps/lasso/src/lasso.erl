-module(lasso).

-export([open/1, get/2]).

open(#{ port := Port, transport := Transport, protocol := Protocol }) ->
  Opts = #{
    retry => 0,
    transport => Transport,
    protocols => [Protocol]
   },
  {ok, ConnPid} = gun:open("localhost", Port, Opts),
  ConnPid.

get(ConnPid, Path) ->
  Ref = gun:get(ConnPid, Path),
  {response, nofin, Status, Headers} = gun:await(ConnPid, Ref),
  {ok, Body} = gun:await_body(ConnPid, Ref),
  {Status, Headers, Body}.
