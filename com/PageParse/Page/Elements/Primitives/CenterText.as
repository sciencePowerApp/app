package com.PageParse.Page.Elements.Primitives
{
	import flash.text.TextFieldAutoSize;

	public class CenterText extends BasicText
	{
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
		}
	}
}