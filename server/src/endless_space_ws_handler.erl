-module(endless_space_ws_handler).
-behaviour(cowboy_websocket_handler).


-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).


init({tcp,http},_Req,_Opts)->
	io:format("init",[]),
	{upgrade,protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts)->
	{ok, Req,[]}.


websocket_handle({text,Msg},Req,State) ->
%	io:format("Msg:~p",[Msg]),
	{reply, {text,Msg}, Req, State};
websocket_handle(Data,Req,State)->
	io:format("Data:~p",[Data]),
	{ok,Req,State}.

websocket_info(_Info,Req,State) ->
	{ok,Req,State}.

websocket_terminate(_Reason,_Req,_State)->
	ok.
