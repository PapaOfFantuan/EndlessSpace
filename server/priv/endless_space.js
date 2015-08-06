var endless_space={
	init:function(){
		var parent = this
		network.init(
		function(){
			network.bindHandler(10000,parent.loginHandler);
			network.send(10000,{account:"test"})	
		})
	},
	loginHandler:function(cmd,data){
		console.log("cmd:" + cmd + ",data:" + data)
		
	},
	render:function(){
	}
}
