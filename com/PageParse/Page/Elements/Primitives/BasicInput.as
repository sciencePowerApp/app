package com.PageParse.Page.Elements.Primitives
{
	import flash.text.TextFieldType;

	public class BasicInput extends BasicText
	{
		public var allowText:String='false';
		
		public function composeInput(params:Object):void
		{


			if(!(params.hasOwnProperty('allowText') && params.allowText.toLowerCase()=="true"))
				this.restrict="0-9";
			
			if(params.hasOwnProperty("default"))
				this.text=params['default'];
			
			this.type = TextFieldType.INPUT;
			
			this.background=true;
			this.backgroundColor=0x335566;
			this.border=true;
		}

		
		override public function kill():void
		{
			super.kill();
		}
		
		
		
		
	
	}
}