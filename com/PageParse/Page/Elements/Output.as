package com.PageParse.Page.Elements
{

	import com.PageParse.Page.Elements.Primitives.Calculate;
	import com.PageParse.Page.Elements.Primitives.OutputText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	

	public class Output  extends Element implements IElement, IGiveValue, IWantValues
	{
		
		private var formula:String;
		private var dp:int;
		private var label:OutputText;
		private var result:String= '';
		private var calc:Calculate;
		private var combined:Sprite = new Sprite;
		private var inputRequests:Dictionary;
		private var updateElseWhereWithAnswer:Function;
		private var output:OutputText  = new OutputText;
	
		private var giveGlobalF:Function;
		public var global:Boolean = false;
		
		private static var _css:Object;
		
		public function isGlobal():Boolean{
			return global;
		}
		
		public static function set css(value:Object):void
		{
			_css = value;
			OutputText.css=value;
		}
		
		public function givenGlobalf(f:Function):void{
			giveGlobalF=f;
		}
		
		override public function compose(params:Object):void
		{
			formula=params.data;
			this.name = params.name;
			params.data='answer';
			if(params.hasOwnProperty("dp"))dp=int(params.dp);
			if(params.hasOwnProperty("label")){
				label=new OutputText();
				label.compose({data:params.label});
				label.selectable=false;
				combined.addChild(label);
			}
			super.compose(params);
			output.compose(params);
			combined.addChild(output);
			
			
		}
		
		public function render(width:int):void{
			if(label){
				output.render(width *.5);
				label.render(width *.5);
				
				label.x=0;
				output.x=label.width;
			}
			else{
				
				output.render(width);
				output.x=0;
			}
			style();
		}
		
		public function giveElement():DisplayObject{	
			return combined;
		}
		
		public function style():void{
			output.style();
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
				if(giveGlobalF)giveGlobalF(num);
				if(dp)num=roundToPrecision(num,dp);
				result=num.toString()
				setText(result);
			}
		}
		
		public function setText(txt:String):void{
			
			style();
			output.htmlText=txt;
			
		}
		
		
		private function roundToPrecision(num:Number, decPla:int = 0):Number{
			decPla=Math.pow(10,decPla);
			return Math.round(num * decPla)/decPla;
		}
		
		private function formulaError():void{
			result='';
			setText("problem with formula!");
		}

		
		
		public function kill():void{
			combined.removeChild(output);
			if(label)combined.removeChild(label);
			if(calc)calc.kill();
			wipeDictionary(inputRequests);
			inputRequests=null;

		}
	}
}
