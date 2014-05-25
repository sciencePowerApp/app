package com.PageParse.Page.Elements.Primitives
{
	import flash.utils.Dictionary;
	
	import bkde.as3.parsers.CompiledObject;
	import bkde.as3.parsers.MathParser;

	public class Calculate extends AbstractPermute
	{
		private var mpExp:MathParser = new MathParser([   ]);
		private var compobjExp :CompiledObject = new CompiledObject();;
		
		
		public function Calculate(formula:String,inputRequests:Dictionary,callbackF:Function)
		{
			super(formula,inputRequests,callbackF);	
		}
	
		
		override protected function doCalc():void
		{
			compobjExp = mpExp.doCompile(updatedFormula);
			if(compobjExp.errorStatus == 1){
				callbackF(null);
				return;
			}
			else{
				var xVal:Number = mpExp.doEval(compobjExp.PolishArray, []);
				
				callbackF(xVal);
			}
		}		
		
		override public function kill():void{
			mpExp=null;
			compobjExp=null;
			super.kill();
		}
	}
}