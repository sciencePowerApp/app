package com.Stored
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class BaseStored extends Sprite
	{
		
		protected static var images:Dictionary;
		protected static var pages:Dictionary;
		
		public function BaseStored()
		{
		}
		
		public function init():void{
			throw new Error("override svp");
		}
		
		public function kill():void{
			throw new Error("override svp");
		}
		
		public function getPage(name:String):String{
			throw new Error("override svp");
			return '';
		}
		
		public static function image(name:String):Bitmap{
			if(images && images.hasOwnProperty(name))return images[name];
			return null;
		}
		
		public static function page(name:String):String{
			if(pages.hasOwnProperty(name))return pages[name];
			return null;
		}
	}
}