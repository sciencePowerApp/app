package com.PageParse.Page
{
	import com.BaseMobileScreen;
	import com.greensock.BlitMask;
	
	import flash.display.Sprite;
	
	public class MenuScroll extends PageScroll
	{
		public function MenuScroll(pageSpr:Sprite)
		{
			super(pageSpr);
		}
		
		override public function getBlitMask():BlitMask{
			return new BlitMask(pageSpr,0,pageSpr.y,BaseMobileScreen.stageWidth,BaseMobileScreen.stageHeight*2,true);	
		}
	}
}