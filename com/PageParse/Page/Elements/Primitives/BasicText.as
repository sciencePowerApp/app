package com.PageParse.Page.Elements.Primitives
{	
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class BasicText extends TextField
	{

		private var autoS:Boolean=false;
		protected var tf:TextFormat;
		static public var fontSize:int=12;
	//	public var css:Object;
		
		public function compose(params:Object):void
		{

			this.htmlText=(params.data as String).split("\r\n").join("\n");
			setSize()
			
		}
		
		public function setFont(font:String):void{
			tf.font=font;
		}
		
		public function render(myWidth:int):void
		{
			setSize();
			this.multiline = true;
			this.wordWrap = true;
			this.width = myWidth;
			
			this.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function setSize(size:int=-1):void{
			if(!tf){
				tf=new TextFormat;
			}
			if(size!=-1)tf.size=size;
			else 		tf.size=fontSize;
			this.setTextFormat(tf)
			//this.defaultTextFormat=tf;
		
		}
		

		public function kill():void
		{
			tf=null;
		}
		
		
			
		
	}
}