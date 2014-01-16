package com.PageParse.Page.Elements
{
	import flash.display.DisplayObject;

	public interface IElement
	{
		function compose(str:String):void;
		function giveElement():DisplayObject;
	
	}
}