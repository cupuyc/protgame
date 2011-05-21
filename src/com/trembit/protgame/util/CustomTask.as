package com.trembit.protgame.util
{
	import org.spicefactory.lib.task.Task;

	public class CustomTask extends Task
	{

		public var fun : Function;

		public function CustomTask(fun : Function)
		{
			super();
			this.fun = fun;
		}

		override protected function doStart():void {
			fun(complete);
		}
	}
}