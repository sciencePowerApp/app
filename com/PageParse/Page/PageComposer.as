package com.PageParse.Page
{
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.IElement;
	import com.PageParse.Page.Elements.Image;
	import com.PageParse.Page.Elements.Input;
	import com.PageParse.Page.Elements.Output;
	import com.PageParse.Page.Elements.Slidebutton;
	import com.PageParse.Page.Elements.Text;
	
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

		
		static public function compose(pageStr:String):Page
		{
			var page:Page = new Page;
			var lines:Array = pageStr.split(newLineChar);
			
			
			
			
			//need access to page hence function in a function
			function gatherText(txt:String):void{
				if(txt.length>0){
					var text:Text = new Text();
					text.compose(txt);
					page.add(text);
				}
			}
			
			
			var splitLine:Array;
			var accumulatingText:String = '';
			var line:String;
			
			for(var i:int=0;i<lines.length;i++){
				line=lines[i];
				for each(var token:String in tokens){
					splitLine=line.split(token);
		
					if(splitLine.length>1){
						
						gatherText(accumulatingText)
						accumulatingText='';
						page.add(addElements(token,line,page));	
						line='';
						break;	
					}
				}
				
				if(line.length>0)accumulatingText+=line;
			}
			gatherText(accumulatingText);
			
		return page;
			
		}
		
		
		private static function addElements(token:String, line:String, page:Page):IElement
		{
			var splitLine:Array = line.split(tokenEnd);
			var stim:String;
			var element:IElement;
			var myClass:Class;
			
			
			for(var i:int=0;i<splitLine.length;i++){
				stim=splitLine[i];
				stim.split(tokenStart+token).join("");
				element = new elementDict[token];
				element.compose(stim);

			}
			
			return element;
		}		
		
	}
}