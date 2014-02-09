package com.PageParse.Page.Elements
{

	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	public class Button extends Element implements IElement
	{
		private var button:BasicText = new BasicText;
		private var backSpr:Sprite = new Sprite;
		private var width:int;
		
		private var actionFs:Vector.<Function>;
		public var action:String='';
		public var gotoP:String='';
		
		
		
		override public function compose(params:Object):void
		{
			alignment=MIDDLE;
			vertical=MIDDLE;
			background=0x335566;
			
			super.compose(params);
			
			params.autoSize=true;
			params.centrePos=true;
			if(params.hasOwnProperty("goto"))gotoP=params['goto'];
			button.compose(params);
			button.selectable=false;
			backSpr.addChild(button);
			listeners(true);
		}
		
		public function whichHappen():String{
			return action;
		}
		
		public function gotoPage():String{
			return gotoP;
		}
		
		public function actions(actionFs:Vector.<Function>):void{
			this.actionFs = actionFs;
		}
		
		public function render(width:int):void
		{
			this.width = width;
			colorBackground(background);
			button.render(width);
			switch(alignment){
				case LEFT:
					button.x=0;
				case MIDDLE:
					
					button.x=backSpr.width*.5-button.width*.5;
					break;
				case TOP:
					button.x=backSpr.width*.5;
					break;
				
			}
			switch(vertical){
				case TOP:
					button.y=backSpr.height*.5-button.height;
					break;
				case MIDDLE:
					button.y=backSpr.height*.5-button.height*.5;
					break;
				case BOTTOM:
					
					button.y=backSpr.height*.5;
					break;
			}

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
			colorBackground(background);
		}
		
		private function mouseDownL(e:MouseEvent):void{
			for each(var f:Function in actionFs){
				f();
			}
			colorBackground(0x6699FF);
		}
		
		private function mouseUpL(e:MouseEvent):void{
			colorBackground(0x668899);
		}
		
		public function kill():void{
			actionFs=null;
			backSpr.removeChild(button);
			backSpr=null;
			listeners(false);
		}
		

		public function giveElement():DisplayObject{
			return backSpr;
		}

		

	}
}