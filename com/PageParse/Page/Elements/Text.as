package com.PageParse.Page.Elements
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import flash.display.DisplayObject;

	public class Text extends Element implements IElement
	{	
		public var basicTxt:BasicText = new BasicText;
		
		override public function compose(params:Object):void
		{
			super.compose(params);
			basicTxt.compose(params);
			basicTxt.selectable=false;
			basicTxt.render(MobileScreen.stageWidth);
			alignment=LEFT;
		}
		
		public function setText(txt:String):void{
			basicTxt.htmlText=txt;
		}
		
		public function render(width:int):void{
			basicTxt.render(width);
			basicTxt.x=0;
		}
		
		public function giveElement():DisplayObject{
		
			return basicTxt;
		}
		
		public function kill():void{
			basicTxt = null;
		}
	}
}