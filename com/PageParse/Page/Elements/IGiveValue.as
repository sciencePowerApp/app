package com.PageParse.Page.Elements
{
	public interface IGiveValue
	{
		function request(callBackF:Function):String;
		function what():String;
		function isGlobal():Boolean;
		function givenGlobalf(f:Function):void;
		
	}
}