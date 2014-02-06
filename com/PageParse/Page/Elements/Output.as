package com.PageParse.Page.Elements
{
	import flash.utils.Dictionary;
	
	import bkde.as3.parsers.CompiledObject;
	import bkde.as3.parsers.MathParser;
	

	public class Output  extends Text implements IElement
	{
		
		private var formula:String;
		private var mpExp:MathParser;
		private var compobjExp :CompiledObject;
		private var goodFormula:Boolean = false;
		private var inputRequests:Dictionary;
		
		override public function compose(params:Object):void
		{
			formula=params.data;
			params.data='answer';
			
			super.compose(params);
			compute();
		}
		
		public function variables(inputRequests:Dictionary):void{
			this.inputRequests = inputRequests;
			
			for(var key:String in inputRequests){
				trace(key)
			}
		}
		
		public function compute():void{
	
			mpExp ||= new MathParser([   ]);
			if(!compobjExp){
				compobjExp  = new CompiledObject();
				compobjExp = mpExp.doCompile(formula);
				if(compobjExp.errorStatus == 1){
					formulaError();
					return;
				}
				else 							goodFormula=true;
			}
			
			
		}
		
		private function formulaError():void{
			setText("problem with formula!");
		}

		
		override public function kill():void{
			
		}
	}
}