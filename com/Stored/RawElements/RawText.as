package com.Stored.RawElements
{
	import com.Stored.RawElement;
	
	import flash.events.Event;
	import flash.filesystem.File;


	public class RawText extends RawElement
	{
		
		private var myText:String;
		
		override public function kill():void{
			super.kill();
		}
		
		public function RawText(file:File)
		{
			super(file);
		}
		
		public function text():String{
			return myText;
		}
		
		
		override public function finishedL(e:Event):void
		{
	
			if(e.type == Event.COMPLETE){
				myText=filestream.readUTFBytes(filestream.bytesAvailable);
				this.success=true;
			}
			finished();
		}
		

	}
}