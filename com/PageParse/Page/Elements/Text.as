package com.PageParse.Page.Elements
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import flash.display.DisplayObject;

	public class Text extends Element implements IElement
	{	
		private var txt:BasicText = new BasicText;
		
		override public function compose(params:Object):void
		{
			super.compose(params);
			
			txt.compose(params);
			txt.selectable=false;
			txt.render(MobileScreen.stageWidth);
			alignment=LEFT;
		}
		
		public function render(width:int):void{
			txt.render(width);
			
		}
		
		public function giveElement():DisplayObject{
		
			return txt;
		}
		
		public function kill():void{
			txt = null;
		}
	}
}