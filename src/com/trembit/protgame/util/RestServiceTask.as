package com.trembit.protgame.util
{
	import com.adobe.net.URI;
	import com.adobe.serialization.json.JSONDecoder;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.utils.ObjectUtil;
	
	import org.httpclient.HttpClient;
	import org.httpclient.events.HttpDataEvent;
	import org.spicefactory.lib.task.Task;

	public class RestServiceTask extends Task
	{

		private var client:HttpClient;

        private var loader : URLLoader;
        
		private var handler : Function;
		
		private var url : String;
		
		private var method : String;
		
		private var body : *;

		public function RestServiceTask(url : String, method : String, body : *, handler : Function = null)
		{
			super();
			this.url = url;
			this.method = method;
			this.handler = handler;
			this.body = body;
		}

		override protected function doStart():void {
            if (method == URLRequestMethod.GET) {
                loader = new URLLoader();
                loader.addEventListener(Event.COMPLETE, onURLLoaderComplete);
                loader.load(new URLRequest(Endpoint.COUCHDB + url));
                return;
            } else {
    			client = new HttpClient();
    			client.listener.onData = onHTTPClientData;
            }

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

        private function onURLLoaderComplete(event : Event) : void {
            var stringData:String = String(loader.data);
            trace(stringData);
            if (handler != null) {
                handler(new JSONDecoder(stringData, true).getValue());
            }
            complete();
        }
        
        private function onHTTPClientData(event:HttpDataEvent):void {
            var stringData:String = event.readUTFBytes();
            //trace(stringData);
            if (handler != null) {
                handler(new JSONDecoder(stringData, true).getValue());
            }
            complete();
        }

		override public function toString() : String {
			return method + " " + url;
		}
	}
}