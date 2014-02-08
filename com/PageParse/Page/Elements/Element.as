package com.PageParse.Page.Elements
{
	import flash.utils.Dictionary;

	public class Element
	{
		public static var LEFT:String = "left";
		public static var RIGHT:String= "right";
		public static var MIDDLE:String="middle";
		
		public var alignment:String = MIDDLE;
		
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