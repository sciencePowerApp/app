package com.PageParse.Page.Elements.Primitives
{
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;

	public class InputText extends BasicText
	{
		public var allowText:String='false';
		public static var css:Object;
		
		public function composeInput(params:Object):void
		{

			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseL);
			if(!(params.hasOwnProperty('allowText') && params.allowText.toLowerCase()=="true"))
				this.restrict="0-9";
			
			if(params.hasOwnProperty("default"))
				this.text=params['default'];
			
			this.type = TextFieldType.INPUT;
			
			this.background=true;
			this.border=true;
		}
		
		public function style():void
		{
			if(css){
				if(css.backgroundColor)	this.backgroundColor=int(css.backgroundColor);
				if(css.color)	this.textColor=int(css.textColor);
			}
			setSize();
		}
		
		protected function mouseL(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
		
		
		
	
	}
}