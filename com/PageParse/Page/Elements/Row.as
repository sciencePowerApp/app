package com.PageParse.Page.Elements
{
	public class Row
	{
		public var tokens:Vector.<IElement> = new Vector.<IElement>;
		
		
		public function add(element:IElement):void{
			tokens.push(element);
		}
	}
}