package com.PageParse.Page.Elements
{
	import flash.display.DisplayObject;

	public interface IElement
	{
		
		function giveElement():DisplayObject;
		function render(width:int):void;
		function kill():void;
	
	}
}