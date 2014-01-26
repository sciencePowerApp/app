package com.Stored
{

	import com.Stored.RawElements.RawImage;
	import com.Stored.RawElements.RawLog;
	import com.Stored.RawElements.RawText;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	public class Stored extends Sprite
	{
		
		private static var images:Dictionary;
		private static var pages:Dictionary;

		
		public static function image(name:String):Bitmap{
			if(images.hasOwnProperty(name))return images[name];
			return null;
		}
		
		public static function page(name:String):String{
			if(pages.hasOwnProperty(name))return pages[name];
			return null;
		}
		
		//a little odd, but I think this way is neater than having loads of call back functions
		//eg just one listener for ALL the Elements we are trying to load.
		private var sprListen:Sprite;
		
		private static var LOCAL_DIR:String = 'pages';
		
		public function inerterise():void{
			if(sprListen){
				sprListen.removeEventListener(Event.COMPLETE,fileLoadedL);
				sprListen=null;
			}
		}
		
		public function init():void
		{

			var dir:File = File.applicationStorageDirectory.resolvePath(LOCAL_DIR);			
			if(dir.exists){
				images = new Dictionary;
				pages  = new Dictionary;
				sprListen = new Sprite;
				sprListen.addEventListener(Event.COMPLETE,fileLoadedL);
				pimpFiles(dir);					
			}
			else {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
	
		
		private function pimpFiles(directory:File):void{
			//chance of a race condition here... as all our files are within same directory, should not be a prob.
			trace(directory.nativePath)
			if (directory.isDirectory){
				var localFiles:Array = directory.getDirectoryListing();
				var extension:String;
				
				for each (var file:File in localFiles){
					if (!file.isDirectory){
		
						switch(file.name.split(".")[1].toLowerCase()){
							
							case "png":
							case "jpg":
								sprListen.addChild(new RawImage(file));	
								break;
							case "txt":
								sprListen.addChild(new RawText(file));
								break;
							case "log":

								sprListen.addChild(new RawLog(file));
								break;
							default: throw new Error();
						}
					}
					else{
						pimpFiles( file )
					}
					
				}
			}
		}
		
		private function fileLoadedL(e:Event):void{
			e.stopPropagation();
			var raw:RawElement = e.target as RawElement;
			if(raw.success){
				
				if(raw is RawImage)		images[raw.name]=(raw as RawImage).image();
				else if(raw is RawLog)  Params.init((raw as RawText).text());
				else if(raw is RawText)	pages[raw.name]=(raw as RawText).text();
				
			}
			
			
			sprListen.removeChild(raw);
			raw.kill();
			if(sprListen.numChildren==0)this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
	
		
	}
}