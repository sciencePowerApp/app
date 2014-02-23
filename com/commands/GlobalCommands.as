package com.commands
{
	import com.GitHubLink;
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import com.Stored.Stored;
	
	import flash.display.Stage;
	import flash.events.Event;

	public class GlobalCommands
	{
		
		public static var commands:Object;
		
		private var stage:Stage;
		private var githubLink:GitHubLink;
		private var messaging:MessagingToUser;
		private var callBackF:Function;
		
		public static const GOTO_PAGE:String = "goto_page";
		public static const RESET_APP:String = "reset_app";
		
		public function GlobalCommands(stage:Stage,callBackF:Function)
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
				
				commands.github = github;
				
				commands['goto'] = gotoP;
			}
		}
		
		private function gotoP(pageName:String):void{
			callBackF(GOTO_PAGE,pageName);
		}
		
		private function github(data:Object):void{
			messaging = new MessagingToUser(stage);
			messaging.doingStuff(true);
			
			function finishedSavingF():void{
				callBackF(RESET_APP);
			}
			
			function saveDataF(DO:Boolean):void{
				if(true){
					Stored.saveFiles(githubLink.files,finishedSavingF);
					messaging.yesNo(false);
				}
				githubLink.kill();
					
			}
			
			function resultF(result:Boolean):void{
				messaging.doingStuff(false);				
				if(githubLink.message!='')	messaging.yesNo(true, githubLink.message,saveDataF);
			}
			
			githubLink = new GitHubLink(data.toString(),resultF);
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
			if(messaging)messaging.render(MobileScreen.stageWidth);
		}
	}
}