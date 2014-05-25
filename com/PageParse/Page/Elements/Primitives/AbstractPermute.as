package com.PageParse.Page.Elements.Primitives
{
	import flash.utils.Dictionary;

	public class AbstractPermute
	{
		
		protected var callbackF:Function;
		protected var inputRequests:Dictionary;
		protected var formula:String;
		protected var updatedFormula:String;
		
		public function AbstractPermute(formula:String,inputRequests:Dictionary,callbackF:Function)
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
				
				requiredUpdates.splice(requiredUpdates.indexOf(variable),1);
				updatedFormula=updatedFormula.split(variable).join(value);
				if(requiredUpdates.length==0 && goneThroughAll)	doCalc();	
				
				
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
		
		protected function doCalc():void
		{
			throw new Error();
		}		
		
		public function kill():void{
			callbackF=null;
			inputRequests=null;
		}
	}
}