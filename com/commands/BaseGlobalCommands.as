package com.commands
{
	import com.PageParse.Page.Elements.Element;
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
				commands.fontBigger= fontSize(1);
				
				commands.imageSmaller
				commands.imageBigger
				
				commands.darkScheme
				commands.lightScheme;
				
				commands.github = _github;
				
				commands['goto'] = gotoP;
			}
		}
		
		private function gotoP(pageName:String):void{
			callBackF(GOTO_PAGE,pageName);
		}
		
		public function _github(data:Object):void{
			//do nothing
		}
		
		private function fontSize(num:int):Function{
			var f:Function = function():void{
				var size:int=BasicText.fontSize;
				
				size+=num;
				BasicText.fontSize=size;
				Element.FONT_SIZE=size;
				requestUpdate();
				
			}	
			return f;
		}
		
		public function requestUpdate():void{
			stage.dispatchEvent(new Event(Event.CHANGE));
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

