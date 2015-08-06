var network={
	init:function(initCallback){
		var ws = new WebSocket("ws://10.0.0.101:8080/ws/");
		var parent = this; 
		parent.ws = ws;
		parent.inited = false;
		parent.initCallback = initCallback;
		ws.onopen = function(){
			parent.inited = true;		
			parent.initCallback();
		}
		ws.onmessage = function(evt){
			parent.receive(evt.data)
		}
	},
	raw_send:function(rawText){
		this.ws.send(rawText)
	},
	send:function(cmd,jsonObject){
		if(!this.inited)
			return;
		var sendObj = {cmd:cmd,data:jsonObject}
		var msg = JSON.stringify(sendObj)
		this.raw_send(msg)
	},
	receive:function(rawData){
		var receiveObj = JSON.parse(rawData)
		var cmd = receiveObj.cmd
		var data = receiveObj.data
		if(!this.handlerTable){
			this.handlerTable = {};
		}
		var handler = this.handlerTable[this.getHandlerName(cmd)]
		if(handler){
			handler(cmd,data)
		}
	},
	bindHandler:function(cmd,handler){
		if(!this.handlerTable){
			this.handlerTable = {}
		}
		this.handlerTable[this.getHandlerName(cmd)] = handler
	},
	getHandlerName:function(cmd){
		return "cmd" + cmd
	}

};
