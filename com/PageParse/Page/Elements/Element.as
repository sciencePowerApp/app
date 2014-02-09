package com.PageParse.Page.Elements
{
	import flash.utils.Dictionary;

	public class Element
	{
		public static var LEFT:String = "left";
		public static var RIGHT:String= "right";
		public static var MIDDLE:String="middle";
		public static var TOP:String="top";
		public static var BOTTOM:String="bottom";
		public static var FONT_SIZE:int = 12;
		
		public var alignment:String = MIDDLE;
		public var vertical:String = BOTTOM;
		public var name:String;
		public var background:int;
		public var fontSize:int = 12;
		
		public function compose(params:Object):void{
			
			for(var param:String in params){
				if(this.hasOwnProperty(param)){
					this[param]=params[param];
					
				}
			}
			
		}
		
		public function wipeDictionary(d:Dictionary):void{
			for(var variable:String in d){
				delete d[variable];
			}
			d=null;
		}
	
		

	}
}