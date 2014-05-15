package com
{
	import com.PageParse.Page.Menu;
	import com.PageParse.Page.Page;
	import com.PageParse.Page.PageComposer;
	import com.Stored.Stored;
	import com.commands.BaseGlobalCommands;
	import com.commands.GlobalCommands;
	
	import flash.display.Stage;
	import flash.events.Event;

	public class Main
	{
		private var stage:Stage;
		private var page:Page;
		private var menu:Menu;
		private var github:GitHubLink;
		private var stored:Stored;
		private var globalCommands:GlobalCommands;
		private var pagesVisited:Vector.<String> = new Vector.<String>;
		private var pagesVisitedCounter:int=0;

		
		public function Main(stage:Stage=null)
		{
			if(stage)this.stage=stage;
			setup();
			
			PageComposer.init();
			
			globalCommands ||= new GlobalCommands(stage,commandsF);
			
			var mobileScreen:MobileScreen = new MobileScreen(stage);
			mobileScreen.addEventListener(Event.COMPLETE,function(e:Event):void{
				stage.addEventListener(Event.CHANGE,updateL);
				if(page){
					updateL(null);
				}
			});
			
			mobileScreen.init();
		}
		
		private function updateL(e:Event):void{
			if(menu)menu.render()
			if(page)page.render();
			globalCommands.render();
		}
		
		private function setup():void
		{

			stored = new Stored();
			
			stored.addEventListener(Event.COMPLETE,function(e:Event):void{
				
				if(Stored.loaded){
					initCSS();
					initMenu();
					pagesVisited.push("home");
					initPage("home");
				}
				else firstBoot();
			});
			
			stored.init();
			
		}
		
		private function initCSS():void
		{
			var css:CSS = new CSS(stored.getCSS("style"));
			UpdateCSS_appWide.DO();			
		}
		
		private function firstBoot():void
		{
			var firstBootPage:String = (<![CDATA[First time booted up
			
			<INPUT allowText:true github zip url default:github.com/sciencePowerApp/stats/archive/master.zip name:url>

				<BUTTON update stats from github sendData:url action:github>

]]> ).toString();
			
			initPage(firstBootPage,true);
		}
		
		private function initMenu():void
		{
			var menuStr:String = stored.getPage("menu")
			menu = new Menu(stage);
			PageComposer.compose(stage,menuStr,menu); //hacky way to get around a typecasting issue.
			menu.render();
			
		}		
		
		private function commandsF(command:String,params:String=''):void{
			switch(command){
				
				case BaseGlobalCommands.GOTO_PAGE:
					pagesVisited.push(params);
					pagesVisitedCounter=pagesVisited.length-1;
					initPage(params);
					break;
				
				case BaseGlobalCommands.THEME:
					CSS.scheme=params;
					UpdateCSS_appWide.DO();	
					stage.dispatchEvent(new Event(Event.CHANGE));

					break;
				
				case BaseGlobalCommands.RESET_APP:
					stored.kill();
					page.kill();
					setup();

					break;
				
				case BaseGlobalCommands.PAGEFLIP:
					
					if(params=="back"){
						if(pagesVisitedCounter>0){
							pagesVisitedCounter--
							initPage(pagesVisited[pagesVisitedCounter]);
						}
					}
					else if(params=="forward"){
						if(pagesVisitedCounter<pagesVisited.length-1){
							pagesVisitedCounter++;
							initPage(pagesVisited[pagesVisitedCounter]);
						}
					}

					break;
				
				default: throw new Error("devel err");
			}
		}

		
		private function initPage(pageName:String, givenPage:Boolean = false):void
		{
				
			if(page)page.kill();
			
			var homeStr:String;
			if(givenPage)	homeStr=pageName
			else 			homeStr = stored.getPage(pageName);
			
			page = PageComposer.compose(stage,homeStr);
			page.render();

			if(menu)menu.toTop();
			else if(givenPage==false)	initMenu();
		}
	}
}