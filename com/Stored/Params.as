package com.Stored
{
	import flash.utils.Dictionary;

	public class Params
	{
		
		private static var newLineChar:String = String.fromCharCode(13);
		
		private static var params:Dictionary = new Dictionary;
		
		
		public static function init(str:String):void{
			
			var arr:Array;
			
			for each(var line:String in str.split(newLineChar)){
				arr = line.split("=");
			
				if(arr.length!=2)throw new Error;
				params[arr[0]]=arr[1];	
			}
		}
		
		public static function val(key:String):String{
			
			if(params.hasOwnProperty(key))	return params[key];
			return '';
		}
	}
}