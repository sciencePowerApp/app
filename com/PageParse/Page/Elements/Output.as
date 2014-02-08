package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.Calculate;
	
	import flash.utils.Dictionary;
	
	import bkde.as3.parsers.CompiledObject;
	import bkde.as3.parsers.MathParser;
	

	public class Output  extends Text implements IElement, IGiveValue
	{
		
		private var formula:String;
		private var dp:int;
		
		private var result:String= '';
		private var calc:Calculate;

		private var inputRequests:Dictionary;
		public var name:String;
		private var updateElseWhereWithAnswer:Function;
		
		override public function compose(params:Object):void
		{
			formula=params.data;
			this.name = params.name;
			params.data='answer';
			if(params.hasOwnProperty("dp"))dp=int(params.dp);
			
			super.compose(params);
		}
		
		public function request(callBackF:Function):String{
			if(result==''){
				this.updateElseWhereWithAnswer=callBackF;
				return 'async';
			}
			updateElseWhereWithAnswer=null;
			return result;
		}
		
		public function variables(inputRequests:Dictionary):void{
			this.inputRequests = inputRequests;
		}
		
		public function what():String{
			return name;
		}
		
		public function compute():void{
			calc = new Calculate(formula,inputRequests,resultF);
		}
		
		public function resultF(num:Number):void{
			if(!num)formulaError();
			else{
				if(updateElseWhereWithAnswer)updateElseWhereWithAnswer(name,num);
				if(dp)num=roundToPrecision(num,dp);
				result=num.toString()
				setText(result);
			}
		}
		
		private function roundToPrecision(num:Number, decPla:int = 0):Number{
			decPla=Math.pow(10,decPla);
			return Math.round(num * decPla)/decPla;
		}
		
		private function formulaError():void{
			result='';
			setText("problem with formula!");
		}

		
		
		override public function kill():void{
			if(calc)calc.kill();
			wipeDictionary(inputRequests);
			inputRequests=null;

		}
	}
}
