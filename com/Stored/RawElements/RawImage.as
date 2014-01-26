package com.Stored.RawElements
{
	import com.Stored.RawElement;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;

	public class RawImage extends RawElement
	{
	
		private var loader:Loader;
		private var bmp:Bitmap;
			
		override public function kill():void{
			if(loader){
				loader.contentLoaderInfo.removeEventListener(Event.INIT,loaderL);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loaderL);
				loader=null;
			}
			bmp=null;
			super.kill();
		}
		
		public function RawImage(file:File){
			super(file);
		}
		
		public function image():Bitmap{
			return bmp;
		}
		
				
		override public function finishedL(e:Event):void
		{
			if(e.type == Event.COMPLETE){
				
				filestream
				var ba:ByteArray = new ByteArray();
				filestream.readBytes( ba, 0, filestream.bytesAvailable );
				ba.position = 0;
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.INIT,loaderL);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderL);
				loader.loadBytes( ba );
			}
		}
		
		protected function loaderL(e:Event):void
		{
			if(e.type == Event.INIT){
				var bd:BitmapData = new BitmapData( loader.width, loader.height );
				bd.draw( loader );
				bmp = new Bitmap( bd );
				this.success=true;
			}
				finished();
		}
		
		
		

	}
}