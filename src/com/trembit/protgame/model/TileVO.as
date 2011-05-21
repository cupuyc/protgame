package com.trembit.protgame.model
{
	
	[Bindable]
	[RemoteClass(alias="TileVO")]
	public class TileVO 
	{
		public var id : String;
		
		public var x : Number;

		public var y : Number;

		public function TileVO(x : Number = NaN, y : Number = NaN)
		{
			super();
			this.x = x;
			this.y = y;
		}
	}
}