package com.PageParse.Page.Elements
{
	import flash.display.DisplayObject;
	import flash.text.TextField;

	public class Text implements IElement
	{
		
		private var txt:TextField = new TextField;
				
		
		public function compose(str:String):void
		{
			txt.htmlText=str;
		}
		
		public function giveElement():DisplayObject{
			return txt;
		}
	}
}