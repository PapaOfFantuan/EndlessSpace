-module(endless_space_ws_handler).
-behaviour(cowboy_websocket_handler).


-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

-record(state,{module,module_state}).
init({tcp,http},_Req,_Opts)->
	{upgrade,protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, Opts)->
	{_,Module} = lists:keyfind(module,1,Opts),	
	State = Module:init(self(),Req), 
	{ok,Req,#state{module_state = State,module = Module}}.


websocket_handle({text,Msg},Req,State = #state{module = Module,
		module_state = ModuleState}) ->
	#{<<"cmd">> := Cmd,<<"data">> := Data} = json:from_binary(Msg),	
	io:format("~p,~p",[Cmd,Data]),
	NewState = endless_space_route:route(Cmd,Data,Module,ModuleState),
	{ok,Req,State#state{module_state = NewState}};
websocket_handle(Data,Req,State)->
	io:format("Data:~p",[Data]),
	{ok,Req,State}.

websocket_info({reply,Cmd,Data},Req,State)->
	Result = #{cmd => Cmd,data => Data},
	{reply, {text,json:to_binary(Result)}, Req, State};

websocket_info(_Info,Req,State) ->
	{ok,Req,State}.

websocket_terminate(_Reason,_Req,_State)->
	ok.
