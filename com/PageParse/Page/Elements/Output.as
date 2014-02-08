package com.PageParse.Page.Elements
{
	import flash.utils.Dictionary;
	
	import bkde.as3.parsers.CompiledObject;
	import bkde.as3.parsers.MathParser;
	

	public class Output  extends Text implements IElement
	{
		
		private var formula:String;
		private var dp:int;
		private var mpExp:MathParser;
		private var compobjExp :CompiledObject;

		private var inputRequests:Dictionary;
		public var name:String;
		
		override public function compose(params:Object):void
		{
			formula=params.data;
			this.name = params.name;
			params.data='answer';
			if(params.hasOwnProperty("dp"))dp=int(params.dp);
			
			super.compose(params);
		}
		
		public function variables(inputRequests:Dictionary):void{
			this.inputRequests = inputRequests;
		}
		
		public function what():String{
			return name;
		}
		
		public function compute():void{
	
			mpExp ||= new MathParser([   ]);
			compobjExp ||= new CompiledObject();
			
			var updatedFormula:String = formula;
			var value:Number;

			for(var variable:String in inputRequests){
				value = (inputRequests[variable] as Function)();
			
				updatedFormula=updatedFormula.split(variable).join(value);
			}
		
			
			compobjExp = mpExp.doCompile(updatedFormula);
			if(compobjExp.errorStatus == 1){
				formulaError();
				return;
			}
			else{
				var xVal:Number = mpExp.doEval(compobjExp.PolishArray, []);
				
				if(dp)xVal=roundToPrecision(xVal,dp);
				
				setText(xVal.toString());
			}
		}
		
		private function roundToPrecision(num:Number, decPla:int = 0):Number{
			decPla=Math.pow(10,decPla);
			return Math.round(num * decPla)/decPla;

		}
		
		private function formulaError():void{
			setText("problem with formula!");
		}

		
		
		override public function kill():void{
			wipeDictionary(inputRequests);
			inputRequests=null;
			mpExp=null;
			compobjExp=null;
		}
	}
}