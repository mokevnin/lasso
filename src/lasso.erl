-module(lasso).

-export([open/2, close/1, get/2, get/3, post/4]).

open(Port, Options) ->
  {ok, ConnPid} = hackney:connect(hackney_tcp, <<"localhost">>, Port, Options),
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
