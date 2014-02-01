package com.PageParse.Page.Elements
{
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
	
	}
}