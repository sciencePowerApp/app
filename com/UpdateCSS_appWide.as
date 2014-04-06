package com
{
	import com.PageParse.Page.Page;
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.Formula;
	import com.PageParse.Page.Elements.Input;
	import com.PageParse.Page.Elements.Output;
	import com.PageParse.Page.Elements.Text;

	public class UpdateCSS_appWide
	{
		private static var css:CSS;
		
	
		public static function DO():void
		{
			
			Page.css=CSS.GET_goodColours("page");
			Input.css=CSS.GET_goodColours("input");
			Text.css=CSS.GET_goodColours("body");	
			Formula.css=CSS.GET_goodColours("formula");
			Output.css=CSS.GET_goodColours("output");
			Button.setCSS(CSS.GET_goodColours("button"));
			
		}
	}
}