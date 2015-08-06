-module(endless_space_dispatcher).



-export([dispatcher/0,ref/0]).
-export([update/0]).
%-on_load(update/0).
update()->
	Dispatcher = cowboy_router:compile(?MODULE:dispatcher()),
	cowboy:set_env(ref(),dispatch,Dispatcher).


ref()->
	endless_space_http.

dispatcher()->
	[
		{'_',[
			{"/",cowboy_static,{file,"/root/share/EndlessSpace/server/priv/index.html"}},
			{"/common/:_",endless_space_handler,[]},
			{"/ws",endless_space_ws_handler,[{module,game}]},
			{"/[...]",cowboy_static,{dir,"/root/share/EndlessSpace/server/priv/"}}
		]}
	].

	
