-module(game).
-include("player.hrl").

-export([app_init/0]).
-export([init/2]).

-export([check_result/1]).


app_init()->
	account_manager:init().


init(PID,Req)->
	#player{pid = PID,req = Req}.


check_result(State) when is_record(State,player) ->
	true;
check_result(_State) ->
	false.
