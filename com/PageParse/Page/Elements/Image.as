package com.PageParse.Page.Elements
{
	import com.Stored.BaseStored;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Image extends Element implements IElement
	{
		
		private var width:int = 100;
		public var file:String;
		private var element:Sprite = new Sprite;
		private var loaded:Boolean = false;
		private var image:Bitmap;
		private var origWidth:int;
		private var origHeight:int;
		
		public static var scaleX:Number=1;
		public static var scaleY:Number=1;

		
		override public function compose(params:Object):void
		{
			super.compose(params);
			
			if(params.hasOwnProperty('width'))width=int(params['width'].split("%").join(""));			
			
			if(file){

				image = BaseStored.image(file);
				
				if(image){
					loaded=true;
					origWidth=image.width;
					origHeight=image.height;
				}
			}
		}
		

		public function giveElement():DisplayObject{
			return element;
		}
		
		public function render(width:int):void{
			
			width*=this.width*.01;
			
			if(loaded==false){
				element.graphics.clear();
				element.graphics.beginFill(0x616161);
				element.graphics.drawRect(0,0,width, width);		
			}
			else{
				
				var maxScale:Number = origWidth/width;
				if(maxScale<origHeight/origWidth)maxScale=origHeight/origWidth;
				image.scaleX=scaleX*1/maxScale;
				image.scaleY=scaleY*1/maxScale;
				
				element.addChild(image);
				image.x=element.width*.5-image.width*.5;
				image.y=element.height*.5-image.height*.5;
			}
		}
		
		public function kill():void{
			if(image && element.contains(image))	element.removeChild(image);
			image = null;
			
			
		}
	}
}