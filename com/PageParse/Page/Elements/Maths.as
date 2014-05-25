package com.PageParse.Page.Elements
{

	import com.PageParse.Page.Elements.Primitives.Calculate;
	import com.PageParse.Page.Elements.Primitives.OutputText;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import com.PageParse.Page.Elements.Primitives.AbstractPermute;
	

	public class Maths extends Label_and_Text_Element implements IGiveValue, IElement, IWantValues
	{
		public static var height:int = 100;
		
		protected var formula:String;
		private var dp:int;
		private var result:String= '';
		protected var calc:AbstractPermute;
		private var combined:Sprite = new Sprite;
		protected var inputRequests:Dictionary;
		private var updateElseWhereWithAnswer:Function;
		private var border:int;
		private var background:int;

		public function Maths(){
			specialText = new OutputText;
		}
		
		
		public static function set css(value:Object):void
		{
			_css = value;
			OutputText.css=value;
		}
		
		override public function what():String{
			return super.name;
		}

		
		override public function compose(params:Object):void
		{
			formula=params.data;
			params.data='answer';
			if(params.hasOwnProperty("dp"))dp=int(params.dp);
			else dp=4;
			super.compose(params);
		}
		
		override public function request(callBackF:Function):String{
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
		
		public function compute():void{
			calc = new Calculate(formula,inputRequests,resultF);
		}
		
		protected function calcCommand():AbstractPermute{
			return new Calculate(formula,inputRequests,resultF);
		}
		
		public function resultF(num:Number):void{

			if(!num)formulaError();
			else{
				if(updateElseWhereWithAnswer){
					updateElseWhereWithAnswer(name,num);
				}
				if(giveGlobalF)giveGlobalF(num);
				if(dp)num=roundToPrecision(num,dp);
				result=num.toString()
				setText(result);
			}
		}
		
		public function setText(txt:String):void{
			specialText.htmlText=txt;
			style();
		}
		
		override public function special():*{
			return specialText as OutputText
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
			super.kill()

		}
	}
}
