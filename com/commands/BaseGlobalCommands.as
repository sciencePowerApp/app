package com.commands
{
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.Image;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	public class BaseGlobalCommands
	{
		
		public static var commands:Object;
		
		protected var stage:Stage;
		protected var callBackF:Function;
		
		public static const GOTO_PAGE:String = "goto_page";
		public static const RESET_APP:String = "reset_app";
		public static const THEME:String = "change theme";
		public static const PAGEFLIP:String = 'page flip';
		
		public function BaseGlobalCommands(stage:Stage,callBackF:Function)
		{
			this.stage=stage;
			this.callBackF = callBackF;
			
			init();
			
		}
		
		private function init():void
		{
			if(!commands){
				commands = {};
				commands.fontSmaller = fontSize(-1);
				commands.fontBigger  = fontSize(1);
				
				commands.imageSmaller= imageSize(-.1);
				commands.imageBigger = imageSize(.1)
				
				commands.darkScheme  = scheme('dark');
				commands.lightScheme = scheme('light');
				
				commands.github = github();
				
				commands['goto'] = gotoP;
				
				commands.pageFlip = pageFlip;
				
			}
		}
		
		private function pageFlip(direction:String):void{
			callBackF(PAGEFLIP,direction);
		}
		
		private function imageSize(size:Number):Function
		{
			return function():void{
				Image.scaleX+=size;
				Image.scaleY+=size;
				requestUpdate();
			}
		}
		
		private function scheme(sche:String):Function
		{
			return function():void{
				callBackF(THEME,"#"+sche);
			}
		}
		
		private function gotoP(pageName:String):void{
			callBackF(GOTO_PAGE,pageName);
		}
		
		public function github():Function{
			return function():void{}; //nb override this function;
		}
		
		private function fontSize(num:int):Function{
			return function():void{
				var size:int=BasicText.fontSize;
				size+=num;
				BasicText.fontSize=size;
				Element.FONT_SIZE=size;
				requestUpdate();
				
			}	
		}
		
		public function requestUpdate():void{
			stage.dispatchEvent(new Event(Event.CHANGE));
		}
		
		public static function SET(what:String,value:int):void{
			
		}
		
		public static function GET():Object
		{
			var copy:Object = {};
			for(var key:String in commands){
				copy[key]=new Vector.<Function>;
				copy[key].push(commands[key]);
			}
			return copy;
		}
		
		public function render():void
		{
			//
		}
	}
}

