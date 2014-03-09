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

		
		override public function compose(params:Object):void
		{
			super.compose(params);
			
			if(params.hasOwnProperty('width'))width=int(params['width'].split("%").join(""));			
			
			if(file){

				image = BaseStored.image(file);
				if(image)	loaded=true;
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
				var maxScale:Number = image.width/width;
				if(maxScale<image.height/width)maxScale=image.height/width;
				image.scaleX=1/maxScale;
				image.scaleY=1/maxScale;
				
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