package com
{
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	public class CSS
	{
		public static var sheet:StyleSheet;
		public static var scheme:String = LIGHT;;
		
		public static var DARK:String = "#dark";
		public static var LIGHT:String = "#light";
		
		public function CSS(css:String)
		{
			sheet = new StyleSheet;
			sheet.parseCSS(css);
		}
		
		public static function GET(nam:String):Object{
			
			return sheet.getStyle(scheme+"_"+nam);
		}
		
		public static function GET_goodColours(nam:String):Object{
			var obj:Object=sheet.getStyle(scheme+"_"+nam);
			for(var key:String in obj){
				if(key.toLowerCase().indexOf("color")!=-1)obj[key]=getColour(obj[key]);
				else if(key == "fontStyle"){
					obj[key] = getFont(obj[key]);
				}
			}
			
			return obj;
		}
		
		private static function getFont(font:String):String
		{
			if(['sans','serif','_typewriter'].indexOf(font))return "_"+font;
			return null;
		}
		
		public static function TF(obj:Object):TextFormat{
			if(sheet) return sheet.transform(obj);
			else return new TextFormat; 
		}
		
		private static function getColour(colour:String):int{
			
			if(colour.charAt(0)=="#")	return uint("0x"+colour.substr(1));
			
			switch((colour as String).toLowerCase()){
				case "red":
					return 0xFF0000;
				case "green":
					return 0x00FF00;
				case "blue":
					return 0x0000FF;
				case "yellow":
					return 0xFFFF00;
				case "pink":
					return 0xFFC0CB;
				case "orange":
					return 0xFFA500;
				case "white":
					return 0xFFFFFF;
				case "brown":
					return 0xA52A2A;
				case "black":
					return 0x000000;
				case "gray":
				case "grey":
					return 0x808080;
				case "purple":
					return 0x800080;
					//colours defined here http://www.htmlgoodies.com/tutorials/colors/article.php/3478961/So-You-Want-A-Basic-Color-Code-Huh.htm
			}
						
			if(!isNaN(int(colour))){
				return int(colour);
			}
			
			throw new Error("you have specified a colour incorrectly or have used text I don't understand:"+colour);
			return null;
		}
		
	}
}