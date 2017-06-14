-module(lasso).

-export([open/4, close/1, get/2, get/3]).

open(Transport, Host, Port, Options) ->
  {ok, ConnRef} = hackney:connect(Transport, Host, Port, Options),
  ConnRef.

close(ConnRef) ->
  hackney:close(ConnRef).

get(ConnRef, Path) ->
  get(ConnRef, Path, []).

get(ConnRef, Path, Headers) ->
  erlang:display("I AM IN GET!!!!!"),
  Request = {get, Path, Headers, <<>>},
  {ok, StatusResponse, HeadersResponse, _} = hackney:send_request(ConnRef, Request),
  {ok, Body} = hackney:body(ConnRef),
  {StatusResponse, HeadersResponse, Body}.


% post(ConnPid, Path, RequestHeaders, RequestBody) ->
%   Ref = gun:post(ConnPid, Path, RequestHeaders, RequestBody),
%   {response, _, Status, Headers} = gun:await(ConnPid, Ref),
%   {ok, Body} = gun:await_body(ConnPid, Ref),
%   {Status, Headers, Body}.
