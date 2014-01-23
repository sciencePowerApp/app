package com.PageParse.Page
{
	import com.PageParse.Page.Elements.Button;
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
		
		elementDict.IMAGE = Image;
		elementDict.OUTPUT = Output;
		elementDict.INPUT = Input;
		elementDict.BUTTON = Button;
		elementDict.SLIDEBUTTON = Slidebutton
			
		static public function init():void{
			for(var token:String in elementDict){
				tokens.push(token);
			}
		}

		
		static public function compose(stage:Stage,pageStr:String):Page
		{
			var page:Page = new Page(stage);
			var lines:Array = pageStr.split(newLineChar);
			
			//need access to page hence function in a function
			function gatherText(txt:String):void{

				if(txt.length>0){
					var text:Text = new Text();
					var arr:Array = [];
					arr.data=txt;
					text.compose(arr);
					page.add(text);
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
			
		return page;
			
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
			var params:Array;
			
			for(var i:int=0;i<lines.length;i++){
			
				element = new elementDict[token];
				params = parseParams(lines[i],token);
				element.compose(params);
				page.add(element);
			
			}
		}		
		
		
		private static function parseParams(paramsStr:String,token:String):Array
		{
			paramsStr = paramsStr.substr(0,paramsStr.length-tokenEnd.length);
			paramsStr = paramsStr.substr(token.length+tokenStart.length+1);
	
			
			
			var ps:Array = tokenise(/\w+\:\w+/g,paramsStr)
			
				
		
				
			var myParams:Array = [];
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