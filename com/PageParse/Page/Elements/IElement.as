package com.PageParse.Page.Elements
{
	import flash.display.DisplayObject;

	public interface IElement
	{
		function compose(arr:Array):void;
		function giveElement():DisplayObject;
		function render():void;
		function kill():void;
	
	}
}