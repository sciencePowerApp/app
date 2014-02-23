package com
{

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.system.Capabilities;
	
	public class MobileScreen extends Sprite
	{
		
		public static var stageWidth:int;
		public static var stageHeight:int;
		
		public static const HORIZONTAL:String = 'horizontal';
		public static const VERTICAL:String = 'vertical';
		public static var started:Boolean = true;

		
		private var _frameCnt:int=0;
		private var theStage:Stage;
		private var orientation:String;
		private var mobile:Boolean = false;
		

		public function kill():void{
			theStage.removeEventListener(StageOrientationEvent.ORIENTATION_CHANGE,orientChanL);
		}
		
		public function MobileScreen(theStage:Stage)
		{
			this.theStage 	= 	theStage;
			started	=	true;
			switch(theStage.orientation){
				case StageOrientation.ROTATED_LEFT:
				case StageOrientation.ROTATED_RIGHT:
					orientation=HORIZONTAL;
					break;
				default:
					orientation=VERTICAL;	
			}
		}
		
		public function init():void{	

			if(flash.system.Capabilities.os.indexOf('Windows')==-1)mobile=true; //for devel

			theStage.scaleMode=StageScaleMode.NO_SCALE;
			theStage.addEventListener(Event.ENTER_FRAME, screenListener);	
			theStage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE,orientChanL);		
		}
		
		protected function orientChanL(event:StageOrientationEvent):void
		{
			determineDimensions();
		}

		public function screenListener(e:Event):void {
			_frameCnt++;
			
			if (_frameCnt > 3) {
	
				theStage.removeEventListener(Event.ENTER_FRAME,screenListener);
				
				determineDimensions();
			}
		}
		
		private function determineDimensions():void
		{
			if(mobile){
				if (orientation == HORIZONTAL){
					stageWidth = Capabilities.screenResolutionY;
					stageHeight = Capabilities.screenResolutionX;
				}
				else{
					stageWidth = Capabilities.screenResolutionX;
					stageHeight = Capabilities.screenResolutionY;
				}
				
			}
			else{
				
				stageWidth = theStage.fullScreenWidth;
				stageHeight = theStage.fullScreenHeight;
			}
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}