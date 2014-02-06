package com.PageParse.Page.Elements
{

	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Button extends Element implements IElement
	{
		private var button:BasicText = new BasicText;
		private var backSpr:Sprite = new Sprite;
		private var width:int;
		
		override public function compose(params:Object):void
		{
			super.compose(params);
			params.autoSize=true;
			button.compose(params);
			button.selectable=false;
			backSpr.addChild(button);
			listeners(true);
		}
		
		public function render(width:int):void
		{
			this.width = width;
			colorBackground(0x335566);
			button.render(width);	
			button.x=backSpr.width*.5-button.width*.5;
			button.y=backSpr.height*.5-button.height*.5;
			

		}
		
		private function colorBackground(col:int):void{
			backSpr.graphics.clear();
			backSpr.graphics.beginFill(col);
			backSpr.graphics.drawRoundRect(0,0,width,100,10,10);
		}
		
		private function listeners(ON:Boolean):void{
			var f:Function;
			if(ON)f=backSpr.addEventListener;
			else  f=backSpr.removeEventListener;
			
			f(MouseEvent.MOUSE_OVER,mouseOverL);
			f(MouseEvent.MOUSE_OUT,mouseAwayL);
			f(MouseEvent.MOUSE_DOWN,mouseDownL);
			f(MouseEvent.MOUSE_UP,mouseUpL);
		}
		
		private function mouseOverL(e:MouseEvent):void{
			colorBackground(0x668899);
		}
		
		private function mouseAwayL(e:MouseEvent):void{
			colorBackground(0x335566);
		}
		
		private function mouseDownL(e:MouseEvent):void{
			colorBackground(0x6699FF);
		}
		
		private function mouseUpL(e:MouseEvent):void{
			colorBackground(0x668899);
		}
		
		public function kill():void{
			backSpr.removeChild(button);
			backSpr=null;
			listeners(false);
		}
		

		public function giveElement():DisplayObject{
			return backSpr;
		}

		

	}
}