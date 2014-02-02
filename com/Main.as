package com
{
	import com.PageParse.Page.Menu;
	import com.PageParse.Page.Page;
	import com.PageParse.Page.PageComposer;
	import com.Stored.Stored;
	
	import flash.display.Stage;
	import flash.events.Event;

	public class Main
	{
		private var stage:Stage;
		private var page:Page;
		private var menu:Menu;
		private var github:GitHubLink;
		private var stored:Stored;

		
		
		public function Main(stage:Stage)
		{
			this.stage=stage;
			var started:Boolean=false;
			
			stored = new Stored();
			stored.addEventListener(Event.COMPLETE,function(e:Event):void{
				//trace(e.target,123)
				
			});
			stored.init();
			
			
			//github = new GitHubLink();
			
			var mobileScreen:MobileScreen = new MobileScreen(stage);
			mobileScreen.addEventListener(Event.COMPLETE,function(e:Event):void{
				if(started==false){
					init();
					started=true;
				}
				else if(page)page.render();
			});
			
			mobileScreen.init();
		}
		

		
		private function init():void
		{
	
			var pageStr:String =( <![CDATA[bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
<INPUT rama name:i1><INPUT hello! abc name:i2 alignment:left>
<OUTPUT B(log(A)) >
<INPUT banana name:i3>
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla
<BUTTON a> <BUTTON b goto:page1>
<IMAGE width:70% height:20% file:a.png>]]> ).toString();
			
			//PageComposer.init();
			//page = PageComposer.compose(stage,pageStr);
			
			//page.render();
			
		
			pageStr =( <![CDATA[bla bla bla bla bla bla bla bla bla bla
			bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
			bla bla bla bla bla bla bla bla bla bla
			<PAGE width:20% alignment:right >
			<INPUT rama name:i1><INPUT hello! abc name:i2 alignment:left>
			<INPUT banana name:i3>
			<BUTTON a> <BUTTON b goto:page1>
			]]> ).toString();
			
			PageComposer.init();
			menu = new Menu(stage);
			PageComposer.compose(stage,pageStr,menu); //hacky way to get around a typecasting issue
			
			menu.render();
	
		}
	}
}