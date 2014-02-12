package com.PageParse.Page.Elements.Primitives
{
	import flash.text.TextFieldAutoSize;

	public class ButtonText extends BasicText
	{
		override public function render(myWidth:int):void
		{
			setSize();
			this.autoSize = TextFieldAutoSize.LEFT;
		}
	}
}