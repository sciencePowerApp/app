package com
{
	import com.PageParse.Page.Page;
	import com.PageParse.Page.PageComposer;
	
	import flash.display.Stage;
	import flash.events.Event;

	public class Main
	{
		private var stage:Stage;
		private var page:Page;

		
		
		public function Main(stage:Stage)
		{
			this.stage=stage;
			var started:Boolean=false;
			
			var mobileScreen:MobileScreen = new MobileScreen(stage);
			mobileScreen.addEventListener(Event.COMPLETE,function(e:Event):void{
				if(started==false){
					init();
					started=true;
				}
				else if(page)page.reRender();
			});
			
			mobileScreen.init();
		}
		

		
		private function init():void
		{
	
			var pageStr:String =( <![CDATA[bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
<INPUT A><INPUT B>
<OUTPUT B(log(A)) >
<INPUT B>
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla
<BUTTON a> <BUTTON b goto:page1>
<IMAGE image.png>]]> ).toString();
			
			PageComposer.init();
			page = PageComposer.compose(stage,pageStr);
			
			page.render();
	
		}
	}
}