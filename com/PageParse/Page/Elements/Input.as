package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.InputText;
	import com.PageParse.Page.Elements.Primitives.OutputText;


	public class Input extends Label_and_Text_Element
	{
		
		private var border:int;
		private var background:int;
		
		public function Input(){
			specialText = new InputText;
		}
		
		public static function set css(value:Object):void
		{
			_css = value;
			InputText.css=value;
			OutputText.css=value;
		}

		
		override public function special():*{
			return specialText as InputText
		}


		override public function request(callBackF:Function):String{
			//never uses the callBackF.  Just included to passify the Interface IGiveValue
			return special().text;
		}
		
		override public function compose(params:Object):void
		{
			params.autoSize=true;
			
			
			
			label.compose(params);
			label.selectable=false;

			
			special().composeInput(params);
			
		
			
			super.compose(params);
		}
		

		
		

		

	}
}