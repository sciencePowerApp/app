package com.PageParse.Page.Elements
{
	import com.Stored.Stored;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class Image extends Element implements IElement
	{
		
		private var width:int = 100;
		public var file:String;
		private var element:Sprite = new Sprite;
		private var loaded:Boolean = false;
		private var imageLoader:Loader

		
		override public function compose(params:Object):void
		{
			super.compose(params);
			
			
			if(params.hasOwnProperty('width'))width=int(params['width'].split("%").join(""));			
			
			if(file){
				
				file=Stored.directory+file;		
				
				imageLoader = new Loader();
				imageLoader.load(new URLRequest(file));
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			}
			
		}
		
		protected function imageLoaded(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type,arguments.callee);
			loaded=true;
			addImage();
		}
		
		private function addImage():void
		{
			var myWidth:int=imageLoader.width;
			var myHeight:int=imageLoader.height;
			
			var maxScale:Number = element.width/myWidth;
			if(element.height/myHeight<maxScale) maxScale = element.height/myHeight;
			
			imageLoader.scaleX=maxScale;
			imageLoader.scaleY=maxScale;
			element.addChild(imageLoader);
			imageLoader.x=element.width*.5-imageLoader.width*.5;
			imageLoader.y=element.height*.5-imageLoader.height*.5;
			
			
		}
		
		public function giveElement():DisplayObject{

			return element;
		}
		
		public function render(width:int):void{
			
			if(loaded==false){
				//trace(123,width,this.width,100)
				element.graphics.clear();
				element.graphics.beginFill(0x616161);
				element.graphics.drawRect(0,0,width*this.width/100, width*this.width/100);
					
			}
			//trace(element.width,element.height)
			
			
			
		}
		
		public function kill():void{
			
		}
	}
}