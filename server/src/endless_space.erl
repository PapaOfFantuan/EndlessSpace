-module(endless_space).

-export([start/0]).


start()->
	application:ensure_all_started(endless_space).
