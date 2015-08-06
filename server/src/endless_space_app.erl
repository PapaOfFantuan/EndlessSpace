-module(endless_space_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	game:app_init(),
	Dispatch = cowboy_router:compile(endless_space_dispatcher:dispatcher()),	
	cowboy:start_http(endless_space_dispatcher:ref(),1,
			[{port,8080}],[
				{env,[{dispatch,Dispatch}]},
				{middlewares,[cowboy_router,cowboy_handler]}
	]),
    endless_space_sup:start_link().

stop(_State) ->
    ok.
