package com.PageParse.Page.Elements
{
	
	import com.CSS;
	import com.PageParse.Page.Elements.Primitives.ButtonText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import flash.utils.Dictionary;

	public class Button extends Element implements IElement, IWantValues
	{
		private var button:ButtonText = new ButtonText;
		private var backSpr:Sprite = new Sprite;
		private var width:int;
		private var widthMod:Number=1;
		private static var css:Object
		private var actionFs:Vector.<Function> = new Vector.<Function>;
		public var action:String='';
		public var gotoP:String;
		public var sendData:String;
		private var inputRequests:Dictionary;
		private var height:int=100;
		
		private static var downCol:int=0x668899;
		private static var overCol:int=0x668899
		private static var upCol:int=0x668899;
		private static var background:int=0x668899;
		private static var color:int=0x668899;
		
		private var my_downCol:int=0x668899;
		private var my_overCol:int=0x668899
		private var my_upCol:int=0x668899;
		private var my_background:int=0x668899;
		private var my_color:int=0xffffff;
		private static var myBevel:BevelFilter;
		
		
		public static function setCSS(value:Object):void
		{
			css = value;
			if(css.downColor)downCol = css.downColor;
			if(css.overColor)overCol= css.overColor;
			
			if(css.backgroundColor)upCol= css.backgroundColor;
			if(css.backgroundColor)background= css.backgroundColor;
		}		

		override public function compose(params:Object):void
		{
			alignment=MIDDLE;
			vertical=MIDDLE;
			//background=0x335566;
			up(true);
			
			super.compose(params);
		
			if(params.background)my_background=int(params.background);
			if(params.color)my_color=int(params.color);
			if(params.height) height=params.height.split("%").join("")*.01*height;
			if(params.width)   widthMod=params.width.split("%").join("")*.01*widthMod;

			
			
			params.autoSize=true;
			if(params.hasOwnProperty("goto")){
				gotoP=params["goto"];
				action="goto";
			}
			button.compose(params);
			
			button.selectable=false;
			backSpr.addChild(button);
			listeners(true);
		}
		
		private function up(ON:Boolean):void
		{

			if(!myBevel){
				var myBevel:BevelFilter = new BevelFilter();
				myBevel.type = BitmapFilterType.INNER;
				myBevel.distance = 3;
				myBevel.highlightColor = 0xFFFFFF;
				myBevel.shadowColor = 0x000000;
				myBevel.blurX = 5;
				myBevel.blurY = 5;
			}
			
			if(ON)	backSpr.filters=[myBevel];
			else	backSpr.filters=[];
			
		}
		
		public function variables(inputRequests:Dictionary):void{
			this.inputRequests = inputRequests;
		}
		
		public function whichHappen():Array{
			return action.split(",");
		}
		
		public function gotoPage():String{
			return gotoP;
		}
		
		public function actions(actionFs:Vector.<Function>):void{
			
			for each(var f:Function in actionFs){
				this.actionFs.push(f);
			}
		}
		
		public function render(width:int):void
		{
			this.width = width * widthMod;
			button.setTextFormat(CSS.TF(css));
			if(this['my_color']) button.textColor=this['my_color'];
			else button.textColor=this[color];
			
			colorBackground('background');

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
		

		
		private function colorBackground(type:String):void{
			
			my_downCol
			my_overCol
			my_upCol
			my_background
			
			var col:int;
			if(this['my_'+type]) col=this['my_'+type];
			else col = this[type]
			
			if(backSpr){
				backSpr.graphics.clear();			
				backSpr.graphics.beginFill(col);
				backSpr.graphics.drawRoundRect(0,0,width,height,10,10);
			}
		}
		
		private function listeners(ON:Boolean):void{
			if(backSpr){
				var f:Function;
				if(ON)f=backSpr.addEventListener;
				else  f=backSpr.removeEventListener;
				
				f(MouseEvent.MOUSE_OVER,mouseOverL);
				f(MouseEvent.MOUSE_OUT,mouseAwayL);
				f(MouseEvent.MOUSE_DOWN,mouseDownL);
				f(MouseEvent.MOUSE_UP,mouseUpL);
			}
		}
		
		private function mouseOverL(e:MouseEvent):void{
			up(false);
			colorBackground('overCol');
			
		}
		
		private function mouseAwayL(e:MouseEvent):void{
			up(true);
			colorBackground('background');
			
		}
		
		private function mouseDownL(e:MouseEvent):void{
			up(false);
			for each(var f:Function in actionFs){

				if(f.length==0)f();
				else if(f.length==1){
					if(!gotoP)	f(inputRequests[sendData](null)); //some global commands want data
					else		f(gotoP);
				}
			}
			colorBackground('downCol');
		}
		
		private function mouseUpL(e:MouseEvent):void{
			up(true);
			colorBackground('upCol');
			
		}
		
		public function kill():void{
			listeners(false);
			actionFs=null;
			wipeDictionary(inputRequests);
			if(backSpr)backSpr.removeChild(button);
			backSpr=null;
		}
		

		public function giveElement():DisplayObject{
			return backSpr;
		}

		

	}
}