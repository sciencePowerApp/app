package com.commands
{
	import com.GitHubLink;
	import com.PageParse.Page.Menu;
	import com.PageParse.Page.Page;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.Primitives.BasicText;
	
	import flash.display.Stage;
	import flash.events.Event;

	public class GlobalCommands
	{
		
		public static var commands:Object;
		
		private var stage:Stage;
		private var menu:Menu;
		private var page:Page;
		private var githubLink:GitHubLink;
		
		public function GlobalCommands(stage:Stage,page:Page,menu:Menu)
		{
			this.stage=stage;

			
			init();
			
		}
		
		private function init():void
		{
			commands = {};
			commands.fontSmaller = fontSize(-1);
			commands.fontBigger= fontSize(1);
				
			commands.imageSmaller
			commands.imageBigger
				
			commands.darkScheme
			commands.lightScheme;
			
			commands.github = github;
		}
		
		private function github(data:Object):void{
			var messaging:MessagingToUser = new MessagingToUser(stage);
			messaging.doingStuff(true);
			
			function saveDataF(DO:Boolean):void{
				trace(123,DO);
				messaging.yesNo(false);
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
	}
}