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
		private static var newLineChar:String = String.fromCharCode(13);
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
			
			pageStr = removeFormula(pageStr);
			
			var lines:Array = pageStr.split(newLineChar);
			
			//need access to page hence function in a function
			function gatherText(txt:String):void{

				if(txt.length>0){
					var text:Text = new Text();
					var arr:Array = [];
					arr.data=txt;
					text.compose(arr);
					var row:Row = new Row;
					row.add(text);
					page.add(row);
				}
			}
			
			
			var splitLine:Array;
			var accumulatingText:String = '';
			var line:String;

			var j:int;
			var regExp:RegExp;
			var paramsStr:String;
			var params:Array;
			
			var search:Array;
			var result:Array;
			var arr:Array=[];
						
			

			for(var i:int=0;i<lines.length;i++){
				line=lines[i];
				
				for each(var token:String in tokens){	
					
					search=tokenise(new RegExp("\<"+token+".*?\>","ig"),line);
				
					if(search){
						gatherText(accumulatingText)
						accumulatingText='';
						addElements(token,search,page);
						line='';
						break;		
					}
				}
				
				if(line.length>0){
					accumulatingText+=line;
				}	
			}
			
			gatherText(accumulatingText);
		
		page.wireUp();
		
		return page;
			
		}
		
		private static function removeFormula(txt:String):String
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
		}
		
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
		
		
		private static function addElements(token:String, lines:Array, page:Page):void
		{

			var element:IElement;
			var myClass:Class;
			var params:Object;
			
			var row:Row;
			
			for(var i:int=0;i<lines.length;i++){	
				params = parseParams(lines[i],token);
				
				if(token==PAGE)page.decorate(params)
				else{
					element = new elementDict[token];
					(element as Element).compose(params);
					row ||= new Row;
					row.add(element);
				}
			}
			
			if(row)page.add(row);
		}		
		
		
		private static function parseParams(paramsStr:String,token:String):Object
		{
			paramsStr = paramsStr.substr(0,paramsStr.length-tokenEnd.length);
			paramsStr = paramsStr.substr(token.length+tokenStart.length+1);
	
			
			
			var ps:Array = tokenise(/[a-zA-Z0-9%]+\:[a-zA-Z0-9%.]+/g,paramsStr)
			
			var myParams:Object = {};
			var item:String;
			var items:Array;
			
			if(ps){
				for each(item in ps){
					items=item.split(":");
					myParams[items[0]]=items[1];
					paramsStr=paramsStr.split(item).join("");	
				}
				
			}
			myParams.data=paramsStr;	
			
			return myParams;
		}
		
	}
}