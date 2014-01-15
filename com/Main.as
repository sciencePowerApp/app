package com
{
	import com.PageParse.Page.Page;
	import com.PageParse.Page.PageComposer;
	
	import flash.display.Stage;

	public class Main
	{
		private var stage:Stage;
		private var page:Page;
		
		
		public function Main(stage:Stage)
		{
			this.stage=stage;
			init();
		}
		
		private function init():void
		{

			
			var pageStr:String =( <![CDATA[bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
<INPUTBOX A>
<INPUTBOX B>
<OUTPUT B(log(A)) >
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla bla bla
bla bla bla bla bla
<button a> <button b goto:page1>
<image.png>]]> ).toString();
			
			PageComposer.init();
			page = PageComposer.compose(pageStr);
	
		}
	}
}