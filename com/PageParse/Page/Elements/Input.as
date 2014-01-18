package com.PageParse.Page.Elements
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.DisplayObject;

	public class Input implements IElement
	{
		private var txt:BasicText = new BasicText;
		
		public function compose(arr:Array):void
		{
			txt.compose(arr.toString());
			txt.render(MobileScreen.stageWidth);
		}
		
		public function render():void{
			txt.render(MobileScreen.stageWidth);
			
		}
		
		public function giveElement():DisplayObject{
			return txt;
		}
	}
}