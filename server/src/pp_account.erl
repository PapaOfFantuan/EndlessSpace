-module(pp_account).

-include("player.hrl").
-export([handle/3]).


handle(10000,Data,State)->
	#{"account" := Account} = Data,	
	account_manager:add_account(Account),	
	Resp = #{},
	endless_space_proto:reply(10000,Resp),	
	State.
