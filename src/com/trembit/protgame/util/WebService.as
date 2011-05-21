package com.trembit.protgame.util
{
	import com.adobe.serialization.json.JSONDecoder;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.spicefactory.lib.task.Task;

	public class WebService extends Task
	{
		private var loader : URLLoader = new URLLoader();

		private var handler : Function;
		
		private var url : String;
		
		private var method : String;

		public function WebService(url : String, method : String, handler : Function)
		{
			super();
			this.url = url;
			this.method = method;
			this.handler = handler;
		}

		override protected function doStart():void {
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			var req : URLRequest = new URLRequest(url);
			req.method = method;
			loader.load(req);
		}

		private function onLoadComplete(event : Event) : void {
			var d : JSONDecoder = new JSONDecoder(loader.data);
			handler(d.getValue());
			complete();
		}
		
		override public function toString() : String {
			return "Call " + url;
		}
	}
}