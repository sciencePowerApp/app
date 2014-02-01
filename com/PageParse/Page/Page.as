package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Element;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;


	public class Page
	{
		public var row:Vector.<Row> = new Vector.<Row>;
		private var stage:Stage;
		private var page:Sprite;
			
		
		public function kill():void{
			var actualElement:DisplayObject;
			for(var i:int=0;i<row.length;i++){
				actualElement = row[i].giveElement();	
				if(actualElement!=null) stage.removeChild(actualElement);
				row[i].kill();
			}
			
			stage.removeChild(page);
		}
		
		public function Page(stage:Stage){
			this.stage=stage;
			page = new Sprite;
			stage.addChild(page);
		}
		
		public function add(_row:Row):void{
			row.push(_row);
		}
		
		
		public function render(initial=true):void{
			

			var actualElement:DisplayObject;
			var y:int=0;
			
			for(var i:int=0;i<row.length;i++){

				actualElement = row[i].giveElement();	
				
				if(actualElement!=null){ //for devel
					if(initial)page.addChild(actualElement);
					row[i].render();
					actualElement.y=y;
					y+=actualElement.height;
					
					switch(row[i].alignment){
						case Element.MIDDLE:
							actualElement.x=MobileScreen.stageWidth*.5-actualElement.width*.5;
							break;
						case Element.RIGHT:
							actualElement.x=MobileScreen.stageWidth-actualElement.width;
							break;
					}
				}	
			}
			page.y=MobileScreen.stageHeight*.5-page.height*.5;
			
		}
		
		public function reRender():void{
			render(false);
		}
	}
}