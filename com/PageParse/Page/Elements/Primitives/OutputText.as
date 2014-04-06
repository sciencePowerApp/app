package com.PageParse.Page.Elements.Primitives
{
	import flash.text.TextFieldAutoSize;

	public class OutputText extends BasicText
	{
		
		static public var css:Object;
		
		override public function render(myWidth:int):void
		{
			setSize();
			
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
			this.background=true;
			
		}
		
		public function style():void
		{
			if(css){
				if(css.backgroundColor)	this.backgroundColor=int(css.backgroundColor);
				if(css.color)	this.textColor=int(css.textColor);
			}
			
		}
	}
}