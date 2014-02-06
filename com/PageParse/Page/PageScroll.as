package com.PageParse.Page
{
	import com.MobileScreen;
	import com.greensock.BlitMask;
	import com.greensock.TweenLite;
	import com.greensock.plugins.ThrowPropsPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.display.Stage;


	public class PageScroll 
	{
		private var blitMask:BlitMask;
		private var pageSpr:Sprite;
		private var stage:Stage;
		
		private var t1:uint, t2:uint, y1:Number, y2:Number, yOverlap:Number, yOffset:Number;
		private var bounds:Rectangle;
		
		
		public function PageScroll(pageSpr:Sprite) 
		{
			this.pageSpr = pageSpr;
			this.stage = pageSpr.stage;
		
			
			TweenPlugin.activate([ThrowPropsPlugin]);
			update();
			stage.addEventListener(MouseEvent.MOUSE_DOWN,_mouseDownHandler);	
		}
		
		public function update():void{
			bounds = new Rectangle(pageSpr.x,pageSpr.y,pageSpr.width,pageSpr.height);
			if(blitMask)blitMask.dispose();
			blitMask = new BlitMask(pageSpr,0,0,MobileScreen.stageWidth,MobileScreen.stageHeight,true);	
			blitMask.disableBitmapMode();
		}
		
		private function _mouseDownHandler(e:MouseEvent):void {
			
			TweenLite.killTweensOf(pageSpr);
			y1 = y2 = pageSpr.y;
			yOffset = stage.mouseY - pageSpr.y;
			yOverlap = Math.max(0, pageSpr.height - bounds.height);
			t1 = t2 = getTimer();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void {
			var y:Number =stage.mouseY - yOffset;
			//if pageSpr's position exceeds the bounds, make it drag only half as far with each mouse movement (like iPhone/iPad behavior)
			if (y > bounds.top) {
				pageSpr.y = (y + bounds.top) * 0.5;
			} else if (y < bounds.top - yOverlap) {
				pageSpr.y = (y + bounds.top - yOverlap) * 0.5;
			} else {
				pageSpr.y = y;
			}
			blitMask.update();
			var t:uint = getTimer();
			//if the frame rate is too high, we won't be able to track the velocity as well, so only update the values 20 times per second
			if (t - t2 > 50) {
				y2 = y1;
				t2 = t1;
				y1 = pageSpr.y;
				t1 = t;
			}
			
			e.updateAfterEvent();
		}

		
		private function mouseUpHandler(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			var time:Number = (getTimer() - t2) / 1000;
			var yVelocity:Number = (pageSpr.y - y2) / time;
			ThrowPropsPlugin.to(pageSpr, {throwProps:{
				y:{velocity:yVelocity, max:bounds.top, min:bounds.top - yOverlap, resistance:300}
			}, onUpdate:blitMask.update, onComplete:blitMask.disableBitmapMode
			}, 10, 0.3, 1);
		}

		
	}
}