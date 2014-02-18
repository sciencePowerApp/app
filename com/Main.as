package com
{
	import com.PageParse.Page.Menu;
	import com.PageParse.Page.Page;
	import com.PageParse.Page.PageComposer;
	import com.Stored.Stored;
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

		public static var myStage:Stage;
		
		
		public function Main(stage:Stage)
		{
			
			
	
			var mobileScreen:MobileScreen = new MobileScreen(stage);
			mobileScreen.addEventListener(Event.COMPLETE,function(e:Event):void{
				if(page){
					if(menu)menu.render()
					if(page)page.render();
					globalCommands.render();
				}
			});
			
			mobileScreen.init();
			PageComposer.init();
			
			this.stage=stage;
			myStage=stage;
			var started:Boolean=false;
			
			stored = new Stored();
			stored.addEventListener(Event.COMPLETE,function(e:Event):void{
				initMenu();
				initPage("home");
			});
			
			stored.init();
			globalCommands = new GlobalCommands(stage,initPage);
		}
		
		private function initMenu():void
		{
			var menuStr:String = stored.getPage("menu")
			menu = new Menu(stage);
			PageComposer.compose(stage,menuStr,menu); //hacky way to get around a typecasting issue.
			menu.render();
			
		}		

		
		private function initPage(pageName:String):void
		{
			if(page)page.kill();
			var homeStr:String = stored.getPage(pageName)
			page = PageComposer.compose(stage,homeStr);
			page.render();
			menu.toTop();
		}
	}
}