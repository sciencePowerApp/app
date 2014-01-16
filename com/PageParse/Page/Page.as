package com.PageParse.Page
{
	import com.PageParse.Page.Elements.IElement;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;


	public class Page
	{
		public var elements:Vector.<IElement> = new Vector.<IElement>;
			
		public function add(element:IElement):void{
			elements.push(element);
		}
		
		
		public function render(stage:Stage):void{
			var element:DisplayObject;
			var y:int=0;
			
			
			for(var i:int=0;i<elements.length;i++){
				element = elements[i].giveElement();	
				
				
				
				if(element!=null){
					stage.addChild(element);
					element.y=y;
					y+=element.height;
					
					element.x=stage.stageWidth*.5-element.width*.5;
					
				}
				
			}
			
		}
	}
}