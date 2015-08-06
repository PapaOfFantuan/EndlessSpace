-module(endless_space_proto).

-export([reply/2]).
-export([reply/3]).

reply(Cmd,Data)->
	reply(self(),Cmd,Data).
reply(PID,Cmd,Data)->
	PID ! {reply,Cmd,Data}.
		
