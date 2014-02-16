package com.Stored
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;


	public class RawElement extends Sprite
	{
		public var success:Boolean = false;
		protected var filestream:FileStream;
		
		public function kill():void{
			filestream.removeEventListener(Event.COMPLETE,finishedL);
			filestream.removeEventListener(IOErrorEvent.IO_ERROR,finishedL);
		}
		
		public function RawElement(file:File)
		{
			this.name = file.name;	
			filestream = new FileStream();
			filestream.addEventListener(Event.COMPLETE,finishedL);
			filestream.addEventListener(IOErrorEvent.IO_ERROR,finishedL);
			filestream.openAsync(file, FileMode.READ);
		}
		
		public function finishedL(e:Event):void{
			throw new Error("override svp");
		}
		
		protected function finished():void{
			filestream.close();
			this.dispatchEvent(new Event(Event.COMPLETE,true));
		}
		

	}
}