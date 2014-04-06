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
		private var s:Style
		
		public static var css:Object;
		
		public function giveInputs(inputs:Vector.<Input>):void{
			
		}
		
		override public function compose(params:Object):void
		{
			formulaXML = XML(params.data).children()[0];
			m = new MathML(<mathml>{formulaXML}</mathml>);
			formula = new Sprite;
		
			s = new Style;
			s.color="#000000";
			s.size=12;
			s.fontweight="bold"
			s.font="_serif";
			m.drawFormula(formula,s);
			
			super.compose(params);
			
		}
		
		
		public function giveElement():DisplayObject{
			
			return formula;
		}
		
		public function render(width:int):void{
			if(css){
				if(css.color)s.color=css.color;
				s.size=12;
				if(css.fontweight)s.fontweight=css.fontWeight;
				s.font=css.fontStyle;
			}
			m.drawFormula(formula,s);
			if(css){
				if(css.backgroundColor)formula.graphics.beginFill(css.backgroundColor);
				formula.graphics.drawRect(0,0,formula.width,formula.height);
			}
			
		}
		
		public function kill():void{
			m = null;
		}
	}
}