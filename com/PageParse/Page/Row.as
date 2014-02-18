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
		
		public function kill():void{
			for each(var element:IElement in row){
				element.kill();
			}
		}
		
		public function addSpecificType(_class:Class,v:Vector.<IElement>):Vector.<IElement>{
			for(var i:int=0;i<row.length;i++){
				if(row[i] is _class){
					v ||= new Vector.<IElement>;
					v[v.length]=row[i];	
				}
			}
			return v;
		}
		
		public function getElement(name:String):IElement{
			for(var i:int=0;i<row.length;i++){
				if((row[i] as Element).name == name)return row[i];
			}
			return null;
		}
		
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
		
		public function render(scale_width:Number):void{
			var maxWidth:int=0;
			var ielement:IElement;
			var element:DisplayObject;

			for(var i:int=0;i<row.length;i++){
				ielement=row[i];
				element=ielement.giveElement();
				
				if(ielement.giveElement()){
					ielement.render(scale_width*MobileScreen.stageWidth/row.length);
					
					element.x=maxWidth;
					maxWidth=element.width;
				}
			}
	
		}
	}
}