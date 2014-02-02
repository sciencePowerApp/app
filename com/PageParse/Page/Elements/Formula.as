package com.PageParse.Page.Elements
{
	import com.Main;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import learnmath.mathml.formula.MathML;
	import learnmath.mathml.formula.Style;

	public class Formula extends Element implements IElement
	{
		private var m:MathML;
		private var formula:MovieClip;
		
		override public function compose(params:Object):void
		{
			
			var xml:XML = <mathml>
<mrow>
<mrow>
	<mfrac linethickness="2" mathcolor="#006699">
		<mi fontweight="bold"> a + b +c </mi>
		<mi mathcolor="#ff0000"> b </mi>
	</mfrac>
</mrow>
<mo>+</mo>
<mfrac linethickness="2" fontstyle="italic" >
	<mrow><mi mathcolor="#00ff00">3456</mi><mo>+</mo><mfrac>
		<mi> a </mi>
		<mi mathsize="8"> b + c + d</mi>
	</mfrac>
	</mrow><mrow><mn>3</mn>
<mfrac mathcolor="#ffff00">
		<mi> c + d </mi>
		<mi mathcolor="#ff0000"> d </mi>
	</mfrac>
</mrow></mfrac>
</mrow>
</mathml>

			
			m = new MathML(xml);
			formula = new MovieClip;
		
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
			
		}
	}
}