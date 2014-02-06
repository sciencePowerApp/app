package com.PageParse.Page.Elements.Primitives
{	;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class BasicText extends TextField
	{

		private var autoS:Boolean=false;
		
		public function compose(params:Object):void
		{
			//this.background=true;
			//this.backgroundColor=0x335566;
			//this.border=true;
			this.htmlText=params.data;
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
				this.width = myWidth;
				this.autoSize = TextFieldAutoSize.LEFT;
			}
		}
		

		
		public function kill():void
		{
			
		}
		
		
			
		
	}
}