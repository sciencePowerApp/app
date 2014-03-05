package com
{
	import com.PageParse.Page.Menu;
	import com.PageParse.Page.Page;
	import com.PageParse.Page.PageComposer;
	import com.Stored.BaseStored;
	import com.commands.BaseGlobalCommands;
	
	import flash.display.Stage;
	import comms.WebInterface;
	
	public class Main_Web
	{
		
		private var stage:Stage;
		private var page:Page;
		private var menu:Menu;
		private var stored:BaseStored;
		private var globalCommands:BaseGlobalCommands;
		private var webInterface:WebInterface;
		
		
		public function Main_Web(stage:Stage=null)
		{
			if(stage)this.stage=stage;
			
			PageComposer.init();
			
			globalCommands ||= new BaseGlobalCommands(stage,commandsF);
			
			/*var mobileScreen:BaseMobileScreen = new BaseMobileScreen(stage);
			mobileScreen.addEventListener(Event.COMPLETE,function(e:Event):void{
				if(page){
					if(menu)menu.render()
					if(page)page.render();
					globalCommands.render();
				}
			});
			
			mobileScreen.init();
			*/
			webInterface = new WebInterface(stage,this);
		}
		
		private function setup():void
		{
			
			
			//get input
			/*stored = new Stored_web();
			
			stored.addEventListener(Event.COMPLETE,function(e:Event):void{
				
				if(Stored_web.loaded){
					initMenu();
					initPage("home");
				}
				else firstBoot();
			});
			
			stored.init();*/
			
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
					initPage(params);
					break;
				
				case BaseGlobalCommands.RESET_APP:
					stored.kill();
					page.kill();
					setup();
					
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
		
		public function render():void
		{
			if(menu)menu.render()
			if(page)page.render();
			globalCommands.render();
			
		}
		
		public function pass_page(data:String):void
		{
			initPage(data,true);
		}
	}
}