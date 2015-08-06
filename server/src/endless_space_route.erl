-module(endless_space_route).

-export([route/4]).



route(Cmd,Data,Module,State)->
	Result =
	case Cmd div 1000 of
		10 ->
			pp_account:handle(Cmd,Data,State);
		11 ->
			pp_scene:handle(Cmd,Data,State);
		_ ->
			State
	end,
	Result1 = 
	case Result of
		ok ->
			State;
		{ok,NewState} ->
			NewState;
		NewState ->
			NewState
	end,
	case Module:check_result(Result1) of
		true ->
			Result1;	
		false ->
			State
	end.
	
