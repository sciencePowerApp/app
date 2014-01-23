package com.PageParse.Page.Elements.Primitives
{	;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	public class BasicText extends TextField
	{
		private var t:Timer;
		public function compose(arr:Array):void
		{
			//this.background=true;
			//this.backgroundColor=0x335566;
			//this.border=true;
			this.htmlText=arr.data;
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
		

		
		public function kill():void
		{
			
		}
		
		
			
		
	}
}