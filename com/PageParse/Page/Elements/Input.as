package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.InputText;
	import com.PageParse.Page.Elements.Primitives.CenterText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Input extends Element implements IElement, IGiveValue
	{
		
		private var combined:Sprite = new Sprite;
		private var label:CenterText = new CenterText;
		private var input:InputText = new InputText;
		private var name:String;
		
		public static function set css(value:Object):void
		{
			_css = value;
			InputText.css=value;
			CenterText.css=value;
		}

		private var giveGlobalF:Function;
		public var global:Boolean = false;
		
		private static var _css:Object;
		
		public function isGlobal():Boolean{
			return global;
		}
		
		
		public function givenGlobalf(f:Function):void{
			giveGlobalF=f;
		}
		
		public function what():String{			
			return name;
		}
		
		public function request(callBackF:Function):String{
			//never uses the callBackF.  Just included to passify the Interface IGiveValue
			return input.text;
		}
		
		override public function compose(params:Object):void
		{
			params.autoSize=true;
			name=params.name;
			super.compose(params);
			
			label.compose(params);
			label.selectable=false;

			input.composeInput(params);
			
			
			combined.addChild(label);
			combined.addChild(input);	
		}
		
		public function render(width:int):void{
			if(label){
				input.render(width *.5);
				label.render(width *.5);
				
				label.x=0;
				input.x=label.width;
			}
			else{
				
				input.render(width);
				input.x=0;
			}
			style();			
		}
		
		public function style():void{
			if(_css){
				input.textColor=_css.color;
				input.setFont(_css.fontStyle);
				//myTextFormat.font=Style.fontName;
			}
		}
		
		public function giveElement():DisplayObject{
			return combined;
		}
		
		public function kill():void{
			if(label)combined.removeChild(label);
			if(input){
				combined.removeChild(input);
				input.kill();
			}
			label=null;
			input=null;
		}
	}
}