package com.PageParse.Page
{
	import flash.display.Stage;

	
	public class Menu extends Page
	{
		public var shown:Boolean = true;
		
		public function Menu(stage:Stage):void{
			super(stage);
		}
		
		override public function render():void{
			if(shown)super.render();
		}
	}
}