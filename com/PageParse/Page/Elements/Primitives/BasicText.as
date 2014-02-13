package com.PageParse.Page.Elements.Primitives
{	;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class BasicText extends TextField
	{

		private var autoS:Boolean=false;
		protected var tf:TextFormat;
		static public var fontSize:int=12;
		
		public function compose(params:Object):void
		{
			if(params.hasOwnProperty('background')){
				this.background=true;
				this.backgroundColor=params.background;
			}
			
			if(params.hasOwnProperty('colour'))this.textColor=params.colour;
			this.htmlText=params.data;
			setSize()
			
		}
	
		
		public function render(myWidth:int):void
		{
			setSize();
			this.multiline = true;
			this.wordWrap = true;
			this.width = myWidth;
			
			this.autoSize = TextFieldAutoSize.LEFT;
		}
		
		protected function setSize(size:int=-1):void{
			if(!tf){
				tf=new TextFormat;
			}
			if(size!=-1)tf.size=size;
			else 		tf.size=fontSize;
			this.setTextFormat(tf)
			this.defaultTextFormat=tf;
		
		}
		

		public function kill():void
		{
			tf=null;
		}
		
		
			
		
	}
}