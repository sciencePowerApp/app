package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.IElement;
	import com.PageParse.Page.Elements.IGiveValue;
	import com.PageParse.Page.Elements.IWantValues;
	import com.PageParse.Page.Elements.Output;
	import com.commands.GlobalCommands;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;


	public class Page extends Element
	{
		public var row:Vector.<Row> = new Vector.<Row>;
		protected var stage:Stage;
		protected var pageSpr:Sprite;
		protected var scale_width:Number=1;
		public var visible:Boolean=true;
		protected var pageScroll:PageScroll;
		public var decorated:Boolean = false;
		

		public function kill():void{
			stage.removeEventListener(Event.CHANGE,refreshL);
			if(pageScroll)pageScroll.kill();
			var actualElement:DisplayObject;
			for(var i:int=0;i<row.length;i++){
				row[i].kill();
			}
			
			stage.removeChild(pageSpr);
		}
		
		public function Page(stage:Stage){
			this.stage			=stage;
			stage.addEventListener(Event.CHANGE,refreshL);
			pageSpr = new Sprite;
			
			stage.addChild(pageSpr);
		}
		
		protected function refreshL(event:Event):void
		{
			render();	
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
				outputs=row[i].addSpecificType(IWantValues,outputs);
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
						(outputs[i] as IWantValues).variables(inputRequests);
					}
				}
			}
				
			//wire up buttons with outputs
			if(buttons){
			
				var what:String;
				var actionsObj:Object = GlobalCommands.GET();
				
				if(outputs){
					for(i=0;i<outputs.length;i++){
						if(outputs[i] is Output){
							what=(outputs[i] as Output).what();
							actionsObj[what] ||= new Vector.<Function>;
							actionsObj[what].push((outputs[i] as Output).compute);	
						}
					}
				}
				
				for(i=0;i<buttons.length;i++){
					what = (buttons[i] as Button).whichHappen();
					
					if(what!='' && actionsObj.hasOwnProperty(what)){
						(buttons[i] as Button).actions(actionsObj[what]);
					}					
				}
				
			}
		}
	
		
		public function render():void{
			var stageHeight:int=MobileScreen.stageHeight;
			if(stageHeight==0)return;
			
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

			if(pageSpr.height<=stageHeight){
				pageSpr.y=stageHeight*.5-pageSpr.height*.5;
				scroll(false);
				
			}
			else{
				pageSpr.y=0;
				scroll(true);
			}

		}

		public function scroll(on:Boolean):void
		{
			if(!pageScroll){
				if(on) pageScroll = new PageScroll(pageSpr);
			}
			else{
				if(on)pageScroll.update();
				else{
					pageScroll.kill();
					pageScroll=null;
				}
			}
		}
		
		protected function align(element:DisplayObject,_scale:Number, alignment:String):void{
			
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
			decorated=true;
			background= 0xffffff;
			compose(params);
			
			
			if(params && params.hasOwnProperty("width")){
				scale_width=Number(params.width.split("%").join(""))*.01;
			}
			
			sortBackground();
		}
		
		public function getElement(name:String):IElement{
			var element:IElement;
			for(var i:int=0;i<row.length;i++){
				element=row[i].getElement(name);
				if(element)return element;
			}
			return element;
		}
		
		public function sortBackground():void
		{
			pageSpr.graphics.beginFill(background,.9);
			pageSpr.graphics.drawRect(0,0,MobileScreen.stageWidth*scale_width,MobileScreen.stageHeight);
		}
		
	}
}