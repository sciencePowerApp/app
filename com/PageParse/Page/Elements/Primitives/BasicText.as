package com.PageParse.Page.Elements.Primitives
{	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class BasicText extends TextField
	{
		public function compose(str:String):void
		{
			this.background=true;
			this.backgroundColor=0x335566;
			this.border=true;
			this.htmlText=str;
		}
		
		public function render(myWidth:int):void
		{
			if (this.width > myWidth)
			{
				this.multiline = true;
				this.wordWrap = true;
				this.width = myWidth;
			}
			else{
				this.multiline = false;
				this.wordWrap = false;
				this.autoSize = TextFieldAutoSize.LEFT;
			}
		}
	}
}