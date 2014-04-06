package com.Stored
{

	import com.Stored.RawElements.RawImage;
	import com.Stored.RawElements.RawLog;
	import com.Stored.RawElements.RawText;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;

	public class Stored extends BaseStored
	{
		

		private static var _directory:String;
		
		public static var loaded:Boolean = false;
		
		override public function kill():void{
			images=null;
			pages=null;
		}
		
		public static function get directory():String
		{
			if(!_directory){
				_directory = File.applicationStorageDirectory.resolvePath(LOCAL_DIR).nativePath;
	
				if(_directory.indexOf("\\")!=-1)_directory+="\\";
				else _directory+="/";
			}
			return _directory;
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
		
		override public function init():void
		{

			var dir:File = File.applicationStorageDirectory.resolvePath(LOCAL_DIR);			
			trace(dir.nativePath)
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
		
		
		
		public static function saveFiles(files:Array,finishedF:Function):void{
			var folder:File = File.applicationStorageDirectory.resolvePath(LOCAL_DIR);	
			var file:File;
			var fileStream:FileStream;
			
	
			if (folder.exists) folder.deleteDirectory(true);
			
			folder.createDirectory();
			
			for each(var fileObj:Object in files){
				//byteArray:zipFile.content, fileName:zipFile.filename 
				try {
					file = folder.resolvePath(fileObj.fileName);
					fileStream = new FileStream();
					fileStream.open(file, FileMode.UPDATE);
					fileStream.writeBytes(fileObj.byteArray,0,fileObj.byteArray);
					fileStream.close();
					
				}
				catch (e:Error) {
					trace("prob saving file:",e);
				}
			}
			if(finishedF)finishedF();
		}
		
		
	
		
		private function pimpFiles(directory:File):void{
			//chance of a race condition here... as all our files are within same directory, should not be a prob.
			if (directory.isDirectory){
				var localFiles:Array = directory.getDirectoryListing();
				var extension:String;
				
				for each (var file:File in localFiles){
					
					
					if(!file.exists || file.name.indexOf(".")==-1){
						// do nothing
					}
					
					else if (!file.isDirectory){
	
						switch(file.name.split(".")[1].toLowerCase()){
							
							case "png":
							case "jpg":
								
								sprListen.addChild(new RawImage(file));	
								break;
							case "css":
							case "xml":
								sprListen.addChild(new RawText(file));
								break;
							case "log":
								sprListen.addChild(new RawLog(file));
								break;
							default: 
								trace(file.name,22)
								throw new Error();
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
				loaded=true;
				
			}
			
			
			sprListen.removeChild(raw);
			raw.kill();
			if(sprListen.numChildren==0){
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function getCSS(name:String):String{
			if(pages && pages.hasOwnProperty(name+".css"))	return pages[name+".css"];
			else return null;
		}
		
		override public function getPage(name:String):String{
			if(pages && pages.hasOwnProperty(name+".xml"))	return pages[name+".xml"];
			else return null;
		}
	}
}