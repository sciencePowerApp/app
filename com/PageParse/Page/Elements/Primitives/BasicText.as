package com.PageParse.Page.Elements.Primitives
{	;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class BasicText extends TextField
	{

		private var autoS:Boolean=false;
		private var tf:TextFormat;
		static public var fontSize:int=12;
		private var centrePos:Boolean=false;
		
		public function compose(params:Object):void
		{
			//this.background=true;
			//this.backgroundColor=0x335566;
			//this.border=true;
			if(params.hasOwnProperty('colour'))this.textColor=params.colour;
			this.htmlText=params.data;
			setSize()
			
		}
	
		
		public function render(myWidth:int):void
		{
			setSize();
			this.multiline = true;
			this.wordWrap = true;
			if(centrePos==false)this.width = myWidth;
			
			this.autoSize = TextFieldAutoSize.CENTER;
		}
		
		private function setSize():void{
			if(!tf){
				tf=new TextFormat;
			}
				tf.size=fontSize;
				this.setTextFormat(tf)
				this.defaultTextFormat=tf;
			
		}
		

		public function kill():void
		{
			tf=null;
		}
		
		
			
		
	}
}