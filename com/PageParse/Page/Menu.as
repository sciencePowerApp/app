package com.PageParse.Page
{
	import com.MobileScreen;
	import com.PageParse.Page.Elements.IElement;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	
	public class Menu extends Page
	{
		public var shown:Boolean = true;
		private var menuSpr:Sprite;
		
		
		override public function kill():void{
			menuListener(false);
			super.kill();
		}
		
		public function Menu(stage:Stage):void{
			super(stage);
		}
		
		override public function render():void{
			super.render()
			setPosition(shown);	
		}
		
		override public function scroll(on:Boolean):void
		{	
		}
		
		private function setPosition(UP:Boolean):void{
			if(UP)	{
				pageSpr.y=-pageSpr.height+menuSpr.height*.75;
				pageSpr.x=MobileScreen.stageWidth-pageSpr.width*.5;
			}
			else	{
				pageSpr.y=0;
				pageSpr.x=MobileScreen.stageWidth-pageSpr.width;
			}
		}
		
	
		
		private function menuListener(ON:Boolean):void{

			if(ON) menuSpr.addEventListener(MouseEvent.MOUSE_UP,menuL);
			else   menuSpr.addEventListener(MouseEvent.MOUSE_UP,menuL);
		}

		
		protected function menuL(e:MouseEvent):void
		{
			setPosition(!shown);	
			shown=!shown;
		}
		
		override public function wireUp():void{
			super.wireUp();
			
			var menu:IElement = getElement("menu");
			if(menu){
				menuSpr=menu.giveElement() as Sprite;
				menuListener(true);
			}
			
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.distance = 0;
			dropShadow.angle = 45;
			pageSpr.filters=[dropShadow];
		}
		
		
		
		override public function sortBackground():void
		{
		}
	}
}