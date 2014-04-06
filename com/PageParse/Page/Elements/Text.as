package com.PageParse.Page.Elements
{

	import com.BaseMobileScreen;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import flash.display.DisplayObject;

	public class Text extends Element implements IElement
	{	
		public var basicTxt:BasicText = new BasicText;

		
		static public var css:Object;
		
		override public function compose(params:Object):void
		{
			super.compose(params);
			
			basicTxt.compose(params);
			basicTxt.selectable=false;
			basicTxt.background=true;
			basicTxt.render(BaseMobileScreen.stageWidth);
			alignment=LEFT;

		}
		
		public function style():void{
			
			if(css){
				basicTxt.backgroundColor=css.backgroundColor;
				basicTxt.textColor=css.color;
				basicTxt.setFont(css.fontStyle);
			}
			
		}
		
		
		public function render(width:int):void{
			style();
			basicTxt.render(width);
		}
		
		public function giveElement():DisplayObject{
			return basicTxt;
		}
		
		public function kill():void{
			basicTxt = null;
		}
	}
}