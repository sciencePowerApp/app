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

		public static var myStage:Stage;
		
		
		public function Main(stage:Stage)
		{
			this.stage=stage;
			myStage=stage;
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
<INPUT rama default:1 name:B><INPUT hello! abc name:A default:4 alignment:left>
<OUTPUT A*sqrt(pi/B) dp:4 name:output1><OUTPUT A*sqrt(pi/output1) dp:4 name:output2>
<FORMULA<mathml>
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
</mathml>>
<INPUT banana default:1 name:i3>
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla
<BUTTON calc action:output1> <BUTTON b action:output2>
<IMAGE width:70% height:20% file:a.png>]]> ).toString();
			
			PageComposer.init();
			page = PageComposer.compose(stage,pageStr);
			
			page.render();
			
		/*
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
			PageComposer.compose(stage,pageStr,menu); //hacky way to get around a typecasting issue.
			
			menu.render();*/
	
		}
	}
}