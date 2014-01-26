package com.PageParse.Page.Elements
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import flash.display.DisplayObject;

	public class Text extends Element implements IElement
	{	
		private var txt:BasicText = new BasicText;
		
		public function compose(arr:Array):void
		{
			txt.compose(arr);
			txt.selectable=false;
			txt.render(MobileScreen.stageWidth);
		}
		
		public function render(width:int):void{
			txt.render(MobileScreen.stageWidth);
			
		}
		
		public function giveElement():DisplayObject{
		
			return txt;
		}
		
		public function kill():void{
			txt = null;
		}
	}
}