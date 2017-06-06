-module(lasso).

-export([open/1, close/1, get/2, get/3, post/4]).

open(#{ port := Port, transport := Transport, protocol := Protocol }) ->
  Opts = #{
    retry => 0,
    transport => Transport,
    protocols => [Protocol]
   },
  {ok, ConnPid} = gun:open("localhost", Port, Opts),
  ConnPid.

close(ConnPid) ->
  gun:close(ConnPid).

get(ConnPid, Path) ->
  get(ConnPid, Path, []).

get(ConnPid, Path, RequestHeaders) ->
  Ref = gun:get(ConnPid, Path, RequestHeaders),
  {response, _, Status, Headers} = gun:await(ConnPid, Ref),
  {ok, Body} = gun:await_body(ConnPid, Ref),
  {Status, Headers, Body}.

post(ConnPid, Path, RequestHeaders, RequestBody) ->
  Ref = gun:post(ConnPid, Path, RequestHeaders, RequestBody),
  {response, _, Status, Headers} = gun:await(ConnPid, Ref),
  {ok, Body} = gun:await_body(ConnPid, Ref),
  {Status, Headers, Body}.
