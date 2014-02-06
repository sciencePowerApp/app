package com.PageParse.Page.Elements
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import learnmath.mathml.formula.MathML;
	import learnmath.mathml.formula.Style;


	public class Formula extends Element implements IElement
	{
		private var m:MathML;
		private var formula:Sprite;
		public static var formulae:Array = [];
		
		
		public static function formulaeLen():int{
			return formulae.length;
		}
		
		public function giveInputs(inputs:Vector.<Input>):void{
			
		}
		
		override public function compose(params:Object):void
		{
		
			m = new MathML(XML(formulae[params.id-1]));
			formula = new Sprite;
		
			var s:Style = new Style;
			s.color="#000000";
			s.size=12;
			s.font="_serif";
			m.drawFormula(formula,s);
			
			
			super.compose(params);
			
		}
		
		public function giveElement():DisplayObject{
			return formula;
		}
		
		public function render(width:int):void{
			
		}
		
		public function kill():void{
			m = null;
		}
	}
}