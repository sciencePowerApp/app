package com.PageParse.Page.Elements.Primitives
{
	import flash.utils.Dictionary;
	
	import bkde.as3.parsers.CompiledObject;
	import bkde.as3.parsers.MathParser;

	public class Calculate
	{
		private var mpExp:MathParser = new MathParser([   ]);
		private var compobjExp :CompiledObject = new CompiledObject();;
		private var callbackF:Function;
		private var inputRequests:Dictionary;
		private var formula:String;
		private var updatedFormula:String;
		
		public function Calculate(formula:String,inputRequests:Dictionary,callbackF:Function)
		{
			this.callbackF=callbackF;
			this.formula=formula;
			this.inputRequests=inputRequests;
			
			collectVars();
		}
		
		private function collectVars():void{
			
			updatedFormula = formula;
			var requiredUpdates:Vector.<String> = new Vector.<String>;
			var value:String;
			var goneThroughAll:Boolean=false;
			
			function updateFormula(variable:String, value:String):void{
				//note if below.  Anticipating if the user tries many times very quickly to get a result. 
				//As mpExp is destroyed on each new Calculate but this anon function is not, best to check myExp exists.
				if(mpExp){
					delete requiredUpdates[variable];
					updatedFormula=updatedFormula.split(variable).join(value);
					if(requiredUpdates.length==0 && goneThroughAll)	doCalc();	
				}
			}
			
			for(var variable:String in inputRequests){
				if(updatedFormula.indexOf(variable)!=-1){
					value = (inputRequests[variable] as Function)(updateFormula);
					
					
					if(value!='async')	updateFormula(variable,value);
					
					else{
						requiredUpdates.push(variable);
					}
					
				}
			}
			goneThroughAll=true;
			if(requiredUpdates.length==0)	doCalc();
		}
		
		private function doCalc():void
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
		
		public function kill():void{
			mpExp=null;
			compobjExp=null;
		}
	}
}