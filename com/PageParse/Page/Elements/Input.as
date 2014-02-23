package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.BasicInput;	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com.PageParse.Page.Elements.Primitives.CenterText;

	public class Input extends Element implements IElement, IGiveValue
	{
		
		private var combined:Sprite = new Sprite;
		private var label:CenterText = new CenterText;
		private var input:BasicInput = new BasicInput;
		private var name:String;
		
		
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
			label.render(width *.5);
			input.render(width *.5);
			
			label.x=0;
			input.x=label.width;			
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