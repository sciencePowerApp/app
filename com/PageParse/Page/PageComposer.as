package com.PageParse.Page
{
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.IElement;
	import com.PageParse.Page.Elements.Image;
	import com.PageParse.Page.Elements.Output;
	import com.PageParse.Page.Elements.Row;
	import com.PageParse.Page.Elements.Slidebutton;
	import com.PageParse.Page.Elements.Text;
	
	import flash.net.getClassByAlias;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;


	public class PageComposer
	{
		private static var elementDict:Dictionary = new Dictionary; 
		private static var newLineChar:String = String.fromCharCode(13);
		private static var tokens:Array = [];
		private static var tokenStart:String = "<";
		private static var tokenEnd:String = ">";
		
		
		elementDict.text = Text;
		elementDict.image = Image;
		elementDict.outout = Output;
		elementDict.button = Button;
		elementDict.slidebutton = Slidebutton
			
		static public function init():void{
			for(var token:String in elementDict){
				tokens.push(token);
			}
		}

		
		static public function compose(pageStr:String):Page
		{
			var page:Page = new Page;
			var lines:Array = pageStr.split(newLineChar);
			
			var splitLine:Array;
			
			for(var i:int=0;i<lines.length;i++){
			
				for(var token:String in tokens){
					splitLine=lines[i].split(token);
		
					if(splitLine.length>0){
						addElements(token,lines[i],page);	
				
						
						break;	
					}
				}
			}
			
		return page;
			
		}
		
		private static function addElements(token:String, line:String, page:Page):void
		{
			var splitLine:Array = line.split(tokenEnd);
			
			var stim:String;
			var row:Row;
			var element:*;
			var myClass:Class;
			
			for(var i:int=0;i<splitLine.length;i++){
				stim=splitLine[i];
				stim.split(tokenStart+token).join("");
				
				row = new Row;
				element = new (elementDict[token] as Class);
			
				//element.compose(stim);
				//row.add(element);
		
			}
			
		}		
		
	}
}