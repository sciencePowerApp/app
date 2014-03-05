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
			var up:Boolean;
			for(var i:int=0;i<pageXML.length();i++){	
				childXML = pageXML.children()[i];
				stimName = childXML.name();
				params = parseParams(childXML);
				params.data=childXML.toString();
				
				if(elementDict[stimName]==undefined)throw new Error("unrecognised stimulus type in page: "+stimName);
				
				element = new elementDict[stimName];
		
				(element as Element).compose(params);
				if(params.up!='true')row = new Row;
				row.add(element);
				
			}
			
			if (page.decorated==false)page.decorate(null);
			if(params.up!='true')page.add(row);
		
		page.wireUp();
		
		return page;
			
		}
		
	
		
/*		private static function removeFormula(txt:String):String
		{
			
			var pos:int = txt.indexOf("<"+FORMULA);

	
			while(pos!=-1){
				var endPos:int;
				var temp:String;
				
				pos+=FORMULA.length+1;
				temp=txt.substr(pos);
				
				endPos=temp.indexOf(">>");
				if(endPos==-1)break;
				endPos++;
			
				temp=txt.substr(pos,endPos);
				if(temp.indexOf("<"+FORMULA)!=-1)break;
				
				Formula.formulae.push(temp);
				txt=txt.split(temp).join(" id:"+Formula.formulaeLen());
				
				pos = txt.indexOf("<"+FORMULA);
			}
			
			return txt;
		}*/
		
		private static function tokenise(regExp:RegExp,txt:String):Array{
			var search:Array=[];
			var result:Array = regExp.exec(txt);
			if(result){
				while(result!=null){
					search.push(result[0]);
					result = regExp.exec(txt);
				}
				return search;
			}
			return null;
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