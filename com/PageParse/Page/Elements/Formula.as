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
		private var formulaXML:XML;

		
		public function giveInputs(inputs:Vector.<Input>):void{
			
		}
		
		override public function compose(params:Object):void
		{
			formulaXML = XML(params.data).children()[0];
			m = new MathML(<mathml>{formulaXML}</mathml>);
			formula = new Sprite;
		
			var s:Style = new Style;
			s.color="#000000";
			s.size=12;
			s.font="_serif";
			m.drawFormula(formula,s);
			
			
			super.compose(params);
			
		}
		
		public function giveElement():DisplayObject{
			trace(formula.width,formula.height)
			return formula;
		}
		
		public function render(width:int):void{
			
		}
		
		public function kill():void{
			m = null;
		}
	}
}