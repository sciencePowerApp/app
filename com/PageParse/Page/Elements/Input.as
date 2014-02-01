package com.PageParse.Page.Elements
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com.PageParse.Page.Elements.Primitives.BasicInput;

	public class Input  extends Element implements IElement
	{
		
		private var combined:Sprite = new Sprite;
		private var label:BasicText = new BasicText;
		private var input:BasicInput = new BasicInput;
		
		override public function compose(params:Object):void
		{
			super.compose(params);
			
			label.compose(params);
			label.selectable=false;
			input.composeInput(params);
			
			
			combined.addChild(label);
			combined.addChild(input);	
		}
		
		public function render(width:int):void{
			label.render(MobileScreen.stageWidth *.5);
			input.render(MobileScreen.stageWidth *.5);
			
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