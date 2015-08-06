-module(endless_space_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	%webtool:start(standard_path,[{port,8080},{bind_address,{10,0,0,101}},{server_name,"webtool"}]),

	%webtool:start(standard_path,[{port,8080},{bind_address,{0,0,0,0}},{server_name,"webtool"}]),
	Dispatch = cowboy_router:compile([
		{'_',[
			{"/",cowboy_static,{file,"/root/share/EndlessSpace/server/priv/index.html"}},
			{"/common/:_",endless_space_handler,[]},
			{"/ws",endless_space_ws_handler,[]}
		]}
	]),
	cowboy:start_http(endless_space_http,1,
			[{port,8080}],[
				{env,[{dispatch,Dispatch}]},
				{middlewares,[cowboy_router,cowboy_handler]}
	]),
    endless_space_sup:start_link().

stop(_State) ->
    ok.
