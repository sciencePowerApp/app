package com
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class BaseMobileScreen extends Sprite
	{
		public static var stageWidth:int = 500;
		public static var stageHeight:int = 500;
		
		public function BaseMobileScreen(stage:Stage)
		{
			
		}
		
		public function init():void{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}