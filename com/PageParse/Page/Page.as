package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.IElement;
	import com.PageParse.Page.Elements.IGiveValue;
	import com.PageParse.Page.Elements.Output;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.Dictionary;


	public class Page extends Element
	{
		public var row:Vector.<Row> = new Vector.<Row>;
		private var stage:Stage;
		private var pageSpr:Sprite;
		private var scale_width:Number=1;
		
		public var visible:Boolean=true;
		private var pageScroll:PageScroll;
			
		
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
		
		public function wireUp():void{
		
					
			var giveValues:Vector.<IElement>;
			var outputs:Vector.<IElement>;
			var buttons:Vector.<IElement>;
			
			for(var i:int=0;i<row.length;i++){
				giveValues=row[i].addSpecificType(IGiveValue,giveValues);
				outputs=row[i].addSpecificType(Output,outputs);
				buttons=row[i].addSpecificType(Button,buttons);
			}
			
	
			
			if(outputs){
				//wire up outputs with inputs
				if(giveValues){
					var inputRequests:Dictionary = new Dictionary;
					for(i=0;i<giveValues.length;i++){
						inputRequests[(giveValues[i] as IGiveValue).what()] = (giveValues[i] as IGiveValue).request;
					}
				
					for(i=0;i<outputs.length;i++){
						(outputs[i] as Output).variables(inputRequests);
					}
				}
				
				//wire up buttons with outputs
				if(buttons){
				
					var what:String;
					var actionsObj:Object = {};
					for(i=0;i<outputs.length;i++){
						what=(outputs[i] as Output).what();
						actionsObj[what] ||= new Vector.<Function>;
						actionsObj[what].push((outputs[i] as Output).compute);	
						
					}
					for(i=0;i<buttons.length;i++){
						what = (buttons[i] as Button).whichHappen();
						if(what!='' && actionsObj.hasOwnProperty(what)){
							(buttons[i] as Button).actions(actionsObj[what]);
						}
						else{
							if(''!=(what=(buttons[i] as Button).gotoPage())){
								
								//put in 'goto page' stuff (going to page what)
								
							}
						}
						
					}
				}
				
				
			}
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
			
			align(pageSpr,1,alignment);
			pageSpr.x=0;
			
			if(pageSpr.height<=MobileScreen.stageHeight){
				pageSpr.y=MobileScreen.stageHeight*.5-pageSpr.height*.5;
				scroll(true);
			}
			else{
				pageSpr.y=0;
				scroll(true);
			}
			
		}
		
		private function scroll(on:Boolean):void
		{
			if(!pageScroll) pageScroll = new PageScroll(pageSpr);
			else pageScroll.update();
			
		}
		
		private function align(element:DisplayObject,_scale:Number, alignment:String):void{
			
			switch(alignment){
				case Element.MIDDLE:
					element.x=_scale*MobileScreen.stageWidth*.5-element.width*.5;
					break;
				case Element.RIGHT:
					element.x=_scale*MobileScreen.stageWidth-element.width;
					break;
				default:
					element.x=0;
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