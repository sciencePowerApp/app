package com.PageParse.Page
{
	import com.BaseMobileScreen;
	import com.PageParse.Page.Elements.Button;
	import com.PageParse.Page.Elements.Element;
	import com.PageParse.Page.Elements.IElement;
	import com.PageParse.Page.Elements.IGiveValue;
	import com.PageParse.Page.Elements.IWantValues;
	import com.PageParse.Page.Elements.Maths;
	import com.commands.BaseGlobalCommands;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class Page extends Element
	{
		public var row:Vector.<Row> = new Vector.<Row>;
		protected var stage:Stage;
		protected var pageSpr:Sprite = new Sprite;
		protected var scale_width:Number=1;
		public var visible:Boolean=true;
		protected var pageScroll:PageScroll;
		public var decorated:Boolean = false;
		
		public static var css:Object;
		private var margin:int;
		
		private static var valueMemory:Dictionary = new Dictionary;
		private var tempMemory:Dictionary = new Dictionary;
		private static var pageFlippers:PageFlippers;
		
		public function kill():void{
			
			preserveData();
			
			if(pageScroll)pageScroll.kill();
			var actualElement:DisplayObject;
			for(var i:int=0;i<row.length;i++){
				row[i].kill();
			}
			
			if(stage.contains(pageSpr))stage.removeChild(pageSpr);
		}
		
		private function preserveData():void
		{
			var f:Function;
			var result:String;
			for(var key:String in tempMemory){
				result=tempMemory[key](null); 
				f = function():String{
					return result;
				}
				valueMemory[key] = f;
			}
		}
		
		public function Page(stage:Stage){
			this.stage			=stage;

			//stage.addEventListener(Event.CHANGE,refreshL);
			stage.addChild(pageSpr);
			initPageFlip(stage);
		}
		
		private static function initPageFlip(stage:Stage):void
		{
			if(!pageFlippers) pageFlippers = new PageFlippers();
			stage.addChild(pageFlippers);
			pageFlippers.init();
		}
		
		protected function refreshL(event:Event):void
		{
			render();	
		}
		
		public function add(_row:Row):void{
			row.push(_row);
		}
		
		public function wireUp():void{
			if(decorated==false)	decorate(null);
			var giveValues:Vector.<IElement>;
			var buttons:Vector.<IElement>;
			var outputs:Vector.<IElement>;
			
			for(var i:int=0;i<row.length;i++){
				giveValues=row[i].addSpecificType(IGiveValue,giveValues);
			
				outputs=row[i].addSpecificType(IWantValues,outputs);
				buttons=row[i].addSpecificType(Button,buttons);
			}
			
			var what:String;
			
			if(outputs){
				//wire up outputs with inputs
				if(giveValues){
					var inputRequests:Dictionary = new Dictionary;
					
					for(i=0;i<giveValues.length;i++){
						
						what=(giveValues[i] as IGiveValue).what();
						inputRequests[what] = (giveValues[i] as IGiveValue).request;
						tempMemory[what] = inputRequests[what];
						
						if((giveValues[i] as IGiveValue).isGlobal())(giveValues[i] as IGiveValue).givenGlobalf(   
								function(value:int):void{																												
									BaseGlobalCommands.SET(what,value)  
								}
							);
					}
					
					addRemembered(inputRequests);

					for(i=0;i<outputs.length;i++){
						(outputs[i] as IWantValues).variables(inputRequests);
					}
				}
			}
				
			//wire up buttons with outputs
			if(buttons){
		
				var actionsObj:Object = BaseGlobalCommands.GET();
				var f:Function;
				
				if(outputs){
					for(i=0;i<outputs.length;i++){
						if(outputs[i] is Maths){
							what=(outputs[i] as Maths).what();
							actionsObj[what] ||= new Vector.<Function>;
							f=(outputs[i] as Maths).compute;
							actionsObj[what].push(f);	
						}
					}
				}
				var actions:Array;
				for(i=0;i<buttons.length;i++){
					actions = (buttons[i] as Button).whichHappen();
					for each(var action:String in actions){
						if(what!='' && actionsObj.hasOwnProperty(action)){
							(buttons[i] as Button).actions(actionsObj[action]);
						}	
					}
				}
			}
		}
		
		private function addRemembered(inputRequests:Dictionary):void
		{
			for(var key:String in valueMemory){
				if(inputRequests.hasOwnProperty(key)==false)inputRequests[key]=valueMemory[key];
			}
		}	
		
		public function render():void{
			sortBackground();
			var stageHeight:int=BaseMobileScreen.stageHeight;
			if(stageHeight==0)return;
			
			var actualElement:DisplayObject;
			var y:int=0;
			
			for(var i:int=0;i<row.length;i++){

				actualElement = row[i].giveElement();	
				
				if(actualElement!=null){ //for devel
					if(pageSpr.contains(actualElement)==false)	pageSpr.addChild(actualElement);
					row[i].render(scale_width);
					actualElement.y=y;
					y+=actualElement.height+margin;
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
					element.x=_scale*BaseMobileScreen.stageWidth*.5-element.width*.5;
					break;
				case Element.RIGHT:
					element.x=_scale*BaseMobileScreen.stageWidth-element.width;
					break;
				default:
					element.x=0;
			}
		}
		

		public function decorate(params:Object):void
		{
			decorated=true;
			
			compose(params);
		
			if(params && params.hasOwnProperty("width")){
				scale_width=Number(params.width.split("%").join(""))*.01;
			}
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
			if(css){
				if(css.hasOwnProperty('backgroundColor')){
					this.stage.color= css.backgroundColor;
				}
				if(css.margin)margin=css.margin;
			}
			
		}
		
	}
}