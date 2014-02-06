package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.BasicInput;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Input extends Element implements IElement
	{
		
		private var combined:Sprite = new Sprite;
		private var label:BasicText = new BasicText;
		private var input:BasicInput = new BasicInput;
		
		
		public function what():String{
			return label.text;
		}
		
		public function request():Number{
			return Number(input.text);
		}
		
		override public function compose(params:Object):void
		{
			params.autoSize=true;
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
			combined.removeChild(label);
			combined.removeChild(input);
			label=null;
			input.kill();
			input=null;
		}
	}
}