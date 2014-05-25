package com.PageParse.Page.Elements.Primitives
{
	import flash.utils.Dictionary;

	public class Statistic extends AbstractPermute
	{
	
		public function Statistic(formula:String,inputRequests:Dictionary,callbackF:Function)
			{
				super(formula,inputRequests,callbackF);	
			}
		
		override protected function doCalc():void
		{
			
			//did not work, return 
			//worked:
			
			//var xVal:Number = bla
			//callbackF(xVal);
			
			var xVal:Number=123;
			callbackF(xVal);
		
		}		
		
		override public function kill():void{
			
			super.kill();
		}
	}
}