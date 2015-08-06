-module(account_manager).


-export([init/0]).
-export([add_account/1]).
-export([has_account/1]).

-define(ETS_ACCOUNT,ets_account).
init()->
	ets:new(?ETS_ACCOUNT,[{key_pos,1},set,public]).


add_account(Account) ->
	ets:insert(?ETS_ACCOUNT,{Account}).

has_account(Account) ->
	ets:memeber(ETS_ACCOUNT,Account).
