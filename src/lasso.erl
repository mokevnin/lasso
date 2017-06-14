-module(lasso).

-export([open/4, close/1, get/2, get/3, post/4]).

open(Transport, Host, Port, Options) ->
  {ok, ConnPid} = hackney:connect(Transport, Host, Port, Options),
  ConnPid.

close(ConnPid) ->
  hackney:close(ConnPid).

get(ConnPid, Path) ->
  get(ConnPid, Path, []).

get(ConnPid, Path, HeadersRequest) ->
  Request = {get, Path, HeadersRequest, <<>>},
  {ok, StatusResponse, HeadersResponse, _} = hackney:send_request(ConnPid, Request),
  {ok, BodyResponse} = hackney:body(ConnPid),
  {StatusResponse, HeadersResponse, BodyResponse}.

post(ConnPid, Path, HeadersRequest, BodyRequest) ->
  Request = {post, Path, HeadersRequest, BodyRequest},
  {ok, StatusResponse, HeadersResponse, _} = hackney:send_request(ConnPid, Request),
  {ok, BodyResponse} = hackney:body(ConnPid),
  {StatusResponse, HeadersResponse, BodyResponse}.
