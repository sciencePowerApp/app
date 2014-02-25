package com
{

	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	public class MobileScreen extends Sprite
	{
		
		public static var stageWidth:int;
		public static var stageHeight:int;
		
		public static const HORIZONTAL:String = 'horizontal';
		public static const VERTICAL:String = 'vertical';
		public static var started:Boolean = true;

		
		private var _frameCnt:int=0;
		private var theStage:Stage;
		private var mobile:Boolean = false;
		private var t:Timer = new Timer(100,1);
		private var overlay:Sprite;
		

		public function kill():void{
			theStage.removeEventListener(StageOrientationEvent.ORIENTATION_CHANGE,orientChanL);
			t.stop();
		}
		
		public function MobileScreen(theStage:Stage)
		{
			this.theStage 	= 	theStage;
			started	=	true;
			
		}
		
		public function init():void{	

			if(flash.system.Capabilities.os.indexOf('Windows')==-1)mobile=true; //for devel

			theStage.scaleMode=StageScaleMode.NO_SCALE;
			theStage.addEventListener(Event.ENTER_FRAME, screenListener);	
			theStage.addEventListener(Event.RESIZE,resizeL);
					
		}
		
		protected function resizeL(event:Event):void
		{
			if(overlay && theStage.contains(overlay))theStage.removeChild(overlay);
		}
		
		protected function orientChanL(e:StageOrientationEvent):void
		{
			determineDimensions(e.afterOrientation);
		}

		public function screenListener(e:Event):void {
			_frameCnt++;
			
			if (_frameCnt > 3) {
				theStage.removeEventListener(Event.ENTER_FRAME,screenListener);
				determineDimensions(theStage.orientation);
				theStage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE,orientChanL);
			}
		}
		
		private function determineDimensions(orientation:String):void
		{
							
			if(overlay){
				theStage.addChild(overlay);
			}
			else{
				overlay=new Sprite;
				var max:int=Capabilities.screenResolutionY;
				if(max<Capabilities.screenResolutionX)max=Capabilities.screenResolutionX;
				overlay.graphics.beginFill(0x112233);
				overlay.graphics.drawRect(0,0,max,max);
			}
				
				
			if(orientation=="default"){
				stageWidth = Capabilities.screenResolutionX;
				stageHeight = Capabilities.screenResolutionY;
			}
			else{
				stageWidth = Capabilities.screenResolutionY;
				stageHeight = Capabilities.screenResolutionX;
			}
			
			
			if(!mobile){
				stageWidth = theStage.fullScreenWidth;
				stageHeight = theStage.fullScreenHeight;
			}
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		
		
		}
	}
}