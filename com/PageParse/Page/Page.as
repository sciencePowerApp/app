package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Element;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;


	public class Page extends Element
	{
		public var row:Vector.<Row> = new Vector.<Row>;
		private var stage:Stage;
		private var pageSpr:Sprite;
		private var scale_width:Number=1;
		
		public var visible:Boolean=true;
			
		
		public function kill():void{
			var actualElement:DisplayObject;
			for(var i:int=0;i<row.length;i++){
				actualElement = row[i].giveElement();	
				if(actualElement!=null) stage.removeChild(actualElement);
				row[i].kill();
			}
			
			stage.removeChild(pageSpr);
		}
		
		public function Page(stage:Stage){
			this.stage			=stage;
			pageSpr = new Sprite;
			stage.addChild(pageSpr);
		}
		
		public function add(_row:Row):void{
			row.push(_row);
		}
		
		
		public function render():void{
			
			var actualElement:DisplayObject;
			var y:int=0;
			
			for(var i:int=0;i<row.length;i++){

				actualElement = row[i].giveElement();	
				
				if(actualElement!=null){ //for devel
					pageSpr.addChild(actualElement);
					row[i].render(scale_width);
					actualElement.y=y;
					y+=actualElement.height;
					
					align(actualElement,scale_width,alignment);
					
				}	
			}
			pageSpr.y=MobileScreen.stageHeight*.5-pageSpr.height*.5;

			align(pageSpr,1,alignment);
			
		}
		
		private function align(element:DisplayObject,_scale:Number, alignment:String):void{
			
			switch(alignment){
				case Element.MIDDLE:
					element.x=_scale*MobileScreen.stageWidth*.5-element.width*.5;
					break;
				case Element.RIGHT:
					element.x=_scale*MobileScreen.stageWidth-element.width;
					break;
			}
		}
		

		public function decorate(params:Object):void
		{
			compose(params);
			
			if(params.hasOwnProperty("width")){
				scale_width=Number(params.width.split("%").join(""))*.01;
			}
		}
	}
}