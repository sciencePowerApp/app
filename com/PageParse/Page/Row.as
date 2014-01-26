package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.IElement;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Row
	{
		private var row:Vector.<IElement> = new Vector.<IElement>;
		private var spr:Sprite;
		
		public function add(element:IElement):void
		{
			row.push(element);
		}
		
		public function giveElement():DisplayObject{
			spr = new Sprite;
			var element:DisplayObject;
			for(var i:int=0;i<row.length;i++){
				element=row[i].giveElement();
				if(element)spr.addChild(element);
			}
			
			return spr;
		}
		
		public function render():void{
			var maxWidth:int=0;
			var element:IElement;
			for(var i:int=0;i<row.length;i++){
				element=row[i];
				if(element.giveElement()){
					row[i].render(MobileScreen.stageWidth/row.length);
					
					row[i].giveElement().x=maxWidth;
					maxWidth=row[i].giveElement().width;
				}
			}
	
		}
	}
}