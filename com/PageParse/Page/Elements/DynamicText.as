package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.InputText;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import com.PageParse.Page.Elements.Primitives.CenterText;
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	
	
	
	public class DynamicText extends Element implements IElement, IGiveValue
	{
		protected var combined:Sprite = new Sprite;
		protected var label:BasicText;
		protected var importantTxt:BasicText = new InputText;
		private var name:String;
		protected var giveGlobalF:Function;
		public var global:Boolean = false;
		
		public static function set css(value:Object):void
		{
			_css = value;
			InputText.css=value;
			CenterText.css=value;
			
		}
		
		
		
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
			
			return importantTxt.text;
		}
		
		override public function compose(params:Object):void
		{
			params.autoSize=true;
			name=params.name;
			super.compose(params);
			label = new CenterText;
			label.compose(params);
			label.selectable=false;
			importantTxt = new InputText;
			(importantTxt as InputText).composeInput(params);
			
			
			combined.addChild(label);
			combined.addChild(importantTxt);	
		}
		
		public function render(width:int):void{
			if(label){
				importantTxt.render(width *.5);
				label.render(width *.5);
				
				label.x=0;
				importantTxt.x=label.width;
			}
			else{
				
				importantTxt.render(width);
				importantTxt.x=0;
			}
			style();			
		}
		
		public function style():void{
			if(_css){
				importantTxt.textColor=_css.color;
				importantTxt.setFont(_css.fontStyle);
				//myTextFormat.font=Style.fontName;
			}
		}
		
		public function giveElement():DisplayObject{
			return combined;
		}
		
		public function kill():void{
			if(label)combined.removeChild(label);
			if(importantTxt){
				combined.removeChild(importantTxt);
				importantTxt.kill();
			}
			label=null;
			importantTxt=null;
		}
	}
}

