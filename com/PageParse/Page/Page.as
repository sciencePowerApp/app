package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.IElement;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;


	public class Page
	{
		public var elements:Vector.<IElement> = new Vector.<IElement>;
		private var stage:Stage;
		private var page:Sprite;
			
		
		public function kill():void{
			var actualElement:DisplayObject;
			for(var i:int=0;i<elements.length;i++){
				actualElement = elements[i].giveElement();	
				if(actualElement!=null) stage.removeChild(actualElement);
				elements[i].kill();
			}
			
			stage.removeChild(page);
		}
		
		public function Page(stage:Stage){
			this.stage=stage;
			page = new Sprite;
			stage.addChild(page);
		}
		
		public function add(element:IElement):void{
			elements.push(element);
		}
		
		
		public function render(initial=true):void{
			

			var actualElement:DisplayObject;
			var y:int=0;
			
			for(var i:int=0;i<elements.length;i++){

				actualElement = elements[i].giveElement();	
				
				if(actualElement!=null){ //for devel
					if(initial)page.addChild(actualElement);
					elements[i].render();
					actualElement.y=y;
					y+=actualElement.height;
				}	
			}
			page.y=MobileScreen.stageHeight*.5-page.height*.5;
			
		}
		
		public function reRender():void{
			render(false);
		}
	}
}