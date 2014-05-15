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
			

			//stage.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{
				pass_page(String(<PAGE>
<TEXT>Test page</TEXT>
<INPUT default="1" name="B">rama</INPUT>
<INPUT name="A" default="4" alignment="left">hello! abc</INPUT>
<OUTPUT dp="4" label="hello" name="output1">A*sqrt(pi/B)</OUTPUT>
<OUTPUT dp="4" label="hello" name="output2">A*sqrt(pi/output1)</OUTPUT>
<FORMULA><mathml>
<mrow>
<mrow>
	<mfrac linethickness="2" mathcolor="#006699">
		<mi fontweight="bold"> a + b +c </mi>
		<mi mathcolor="#ff0000"> b </mi>
	</mfrac>
</mrow>
<mo>+</mo>
<mfrac linethickness="2" fontstyle="italic" >
	<mrow><mi mathcolor="#00ff00">3456</mi><mo>+</mo><mfrac>
		<mi> a </mi>
		<mi mathsize="8"> b + c + d</mi>
	</mfrac>
	</mrow><mrow><mn>3</mn>
<mfrac mathcolor="#ffff00">
		<mi> c + d </mi>
		<mi mathcolor="#ff0000"> d </mi>
	</mfrac>
</mrow></mfrac>
</mrow>
</mathml>
</FORMULA>
<INPUT default="1" name="3"/>
<TEXT>bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla</TEXT>
<BUTTON action="output1">calc</BUTTON>
<BUTTON action="output2">b</BUTTON>
<IMAGE width="70%" height="20%" file="a.png"/>
</PAGE>))
			
			
			
			//});
			
			
			
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
			var menuStr:String = (<![CDATA[

				
				<PAGE background="0xFFFFFF" shadow="true" width="40%" alignment="right">
				
				<BUTTON background="0xffffff" action="lightScheme" colour="0x000000">A</BUTTON>
				<BUTTON action="darkScheme" up="true" background="0x000000" colour="0xffffff">A</BUTTON>
				
				<BUTTON action="fontBigger">A +</BUTTON> 
				<BUTTON action="fontSmaller" up="true">A -</BUTTON>
				
				<BUTTON action="imageBigger">Image +</BUTTON>
				<BUTTON action="imageSmaller" up="true">Image -</BUTTON>
				
				<BUTTON name="menu"/>
				</PAGE>
				
			]]> ).toString();
				
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
				
				//default: throw new Error("devel err");
		
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
			else initMenu();
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