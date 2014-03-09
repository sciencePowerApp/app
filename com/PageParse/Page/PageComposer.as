package com.PageParse.Page
{
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.Formula;
	import com.PageParse.Page.Elements.IElement;
	import com.PageParse.Page.Elements.Image;
	import com.PageParse.Page.Elements.Input;
	import com.PageParse.Page.Elements.Output;
	import com.PageParse.Page.Elements.Slidebutton;
	import com.PageParse.Page.Elements.Text;
	
	import flash.display.Stage;
	import flash.utils.Dictionary;



	public class PageComposer
	{
		private static var elementDict:Dictionary = new Dictionary; 
		private static var newLineChar:String = String.fromCharCode(10);
		private static var tokens:Array = [];
		private static var tokenStart:String = "<";
		private static var tokenEnd:String = ">";
		private static var PAGE:String="page";
		private static var FORMULA:String = "FORMULA";
		
		
		elementDict.IMAGE = Image;
		elementDict.OUTPUT = Output;
		elementDict.INPUT = Input;
		elementDict.BUTTON = Button;
		elementDict.SLIDEBUTTON = Slidebutton;
		elementDict.FORMULA = Formula;
		elementDict.TEXT = Text;
			
		static public function init():void{
			for(var token:String in elementDict){
				tokens.push(token);
			}
			tokens.push(PAGE);
		}

		
		static public function compose(stage:Stage,pageStr:String,_page:Page=null):Page
		{
			var page:Page
			
			if(_page)	page=_page;
			else 		page = new Page(stage);	
	
			var pageXML:XML=XML(pageStr);
			var childXML:XML;
			
			
			page.decorate(parseParams(pageXML))
			
			var element:IElement;
			var myClass:Class;
			var params:Object;
			var stimName:String;
			var row:Row = new Row();

			for(var i:int=0;i<pageXML.children().length();i++){

				childXML = pageXML.children()[i];
				stimName = childXML.name();
				params = parseParams(childXML);
				params.data=childXML.toString();
				
				if(elementDict[stimName]==undefined)throw new Error("unrecognised stimulus type in page: "+stimName);
				
				element = new elementDict[stimName];
				(element as Element).compose(params);
				
				if(!params.hasOwnProperty('up')){
					row = new Row;
					page.add(row);
				}
				row.add(element);
			}

		page.wireUp();
		
		return page;
			
		}
		
	

		private static function parseParams(childXML:XML):Object
		{
			var myParams:Object = {};
			
			for each (var att : XML in childXML.@*)
			myParams["" + att.name ()] = "" + att.valueOf ();
			
			return myParams;
		}
		
	}
}