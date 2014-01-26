package com.PageParse.Page.Elements
{
	import flash.display.DisplayObject;

	public interface IElement
	{
		function compose(arr:Array):void;
		function giveElement():DisplayObject;
		function render(width:int):void;
		function kill():void;
	
	}
}