-module(endless_space_handler).


-export([init/3,handle/2,terminate/3]).
init(Socket,Req, Opts)->
	io:format("Socket:~p~n,Req:~p~n,Opts:~p",[Socket,Req,Opts]),
	Req2 = cowboy_req:reply(200,[
				{<<"content-type">>,<<"text/plain">>}
			],<<"Hello World!">>,Req),
	{ok,Req2,[]}.

handle(Req,State)->
	{ok,Req,State}.
terminate(_Reason, _Req, _State)-> 
	ok.
