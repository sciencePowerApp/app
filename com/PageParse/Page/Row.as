package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.IElement;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Row
	{
		private var row:Vector.<IElement> = new Vector.<IElement>;
		private var spr:Sprite;
		
		public var alignment:String;
		
		public function add(element:IElement):void
		{
			alignment=(element as Element).alignment;
			row.push(element);
		}
		
		public function giveElement():DisplayObject{
			spr = new Sprite;
			var element:DisplayObject;
			for(var i:int=0;i<row.length;i++){
				element=row[i].giveElement();
				if(element){
					spr.addChild(element);
				}
			}
			
			return spr;
		}
		
		public function render():void{
			var maxWidth:int=0;
			var ielement:IElement;
			var element:DisplayObject;

			for(var i:int=0;i<row.length;i++){
				ielement=row[i];
				element=ielement.giveElement();
				
				if(ielement.giveElement()){
					ielement.render(MobileScreen.stageWidth/row.length);
					
					element.x=maxWidth;
					maxWidth=element.width;
				}
			}
	
		}
	}
}