package com
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	
	import flash.events.Event;
	
	import org.as3commons.zip.Zip;
	import org.as3commons.zip.ZipFile;
	import org.as3commons.zip.ZipLibrary;

	public class GitHubLink
	{
		private var loader:DataLoader;
		private var zip:Zip;
		private var lib:ZipLibrary;
		
		
		public function GitHubLink(url:String)
		{
			if(url.substr(0,7)!="https://")url="https://"+url;
			
			loader = new DataLoader(url);
			
			loader.addEventListener(LoaderEvent.COMPLETE,completeL);
			loader.addEventListener(LoaderEvent.ERROR,errorL);
			loader.addEventListener(LoaderEvent.PROGRESS,progressL);
			
			loader.load();
			
		}
		
		protected function progressL(e:LoaderEvent):void
		{
			trace(loader.progress);
			
		}
		
		protected function errorL(e:LoaderEvent):void
		{
			trace(e);
			
			
		}
		
		protected function completeL(e:LoaderEvent):void
		{
			trace("complete");
			zip = new Zip("master.zip");
			zip.addEventListener(Event.COMPLETE,zipCompleteL);
			zip.addEventListener(Event.COMPLETE,zipProgressL);
			zip.load(loader.request);	
		}
		

		
		protected function zipProgressL(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function zipCompleteL(e:Event):void
		{
			var zipFile:ZipFile;
			for(var i:int=0;i<zip.getFileCount();i++){
				zipFile=zip.getFileAt(i);
				trace(123,zipFile.filename,zipFile.content)
			}
			
		
		}
	}
}