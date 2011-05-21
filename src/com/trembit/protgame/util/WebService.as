package com.trembit.protgame.util
{
	import com.adobe.net.URI;
	import com.adobe.serialization.json.JSONDecoder;
	
	import flash.net.URLRequestMethod;
	
	import org.httpclient.HttpClient;
	import org.httpclient.events.HttpDataEvent;
	import org.spicefactory.lib.task.Task;

	public class WebService extends Task
	{

		private var client:HttpClient;

		private var handler : Function;
		
		private var url : String;
		
		private var method : String;
		
		private var body : *;

		public function WebService(url : String, method : String, body : *, handler : Function = null)
		{
			super();
			this.url = url;
			this.method = method;
			this.handler = handler;
			this.body = body;
		}

		override protected function doStart():void {
			client = new HttpClient();
			client.listener.onData = function(event:HttpDataEvent):void {
				var stringData:String = event.readUTFBytes();
				if (handler != null) {
					handler(new JSONDecoder(stringData).getValue());
				}
				complete();
			};

			var uri:URI = new URI(Endpoint.COUCHDB + url);
			if (method == URLRequestMethod.PUT) {
				client.put(uri, body);
			} else if (method == URLRequestMethod.GET) {
				client.get(uri);
			} else if (method == URLRequestMethod.DELETE) {
				client.del(uri);
			} else if (method == URLRequestMethod.POST) {
				client.post(uri, body, "application/json");
			}
			trace(uri.toDisplayString());
		}

		override public function toString() : String {
			return method + " " + url;
		}
	}
}