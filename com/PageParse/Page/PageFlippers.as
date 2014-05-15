package com.PageParse.Page
{	
	import com.CSS;
	import com.commands.BaseGlobalCommands;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	public class PageFlippers extends Sprite
	{
		private static var scheme:String;
		private static var pageFlippers:PageFlippers;
		
		private var back:Sprite = new Sprite;
		private var forward:Sprite = new Sprite;
		private var glowF:GlowFilter= new GlowFilter();
		private var listen:Boolean=false;
		
		public function PageFlippers(){
			addChild(back);
			addChild(forward);
		}
		
		public  function init():void
		{
			back.name='back';
			forward.name='forward';
			
			if(scheme==CSS.DARK){
				glowF.color = 0x000000;
				back.graphics.beginFill(0x000000);
				forward.graphics.beginFill(0x000000);
			}
			else{
				glowF.color = 0xFFFFFF;
				back.graphics.beginFill(0xFFFFFF);
				forward.graphics.beginFill(0xFFFFFF);
			}
		

			back.graphics.drawCircle(0,0,this.stage.stageWidth*.1);
			forward.graphics.drawCircle(0,0,this.stage.stageWidth*.1);

			glowF.blurX = 20;
			glowF.blurY = 20;
			glowF.alpha = 1;
			glowF.strength = 2;
			glowF.color = 0x000000;
			forward.filters = back.filters = [glowF];
			
			if(listen==false){
				back.addEventListener(MouseEvent.MOUSE_DOWN,mouseL);
				forward.addEventListener(MouseEvent.MOUSE_DOWN,mouseL);
				back.addEventListener(MouseEvent.ROLL_OVER,mouseL);
				forward.addEventListener(MouseEvent.ROLL_OVER,mouseL);
				back.addEventListener(MouseEvent.MOUSE_OUT,mouseL);
				forward.addEventListener(MouseEvent.MOUSE_OUT,mouseL);
				back.addEventListener(MouseEvent.CLICK,mouseL);
				forward.addEventListener(MouseEvent.CLICK,mouseL);
				listen=true;
			}
		
			setActive(back,false);
			setActive(forward,false);
			back.y=forward.y=stage.stageHeight-back.height*.5;
			
			pageFlippers=this;

		}
		
		private function setActive(what:Sprite, ON:Boolean):void{
			if(forward==what){
				if(ON)	forward.x=this.stage.stageWidth-forward.width*.25;
				else	forward.x=this.stage.stageWidth;
			}
			if(back==what){
				if(ON)	back.x=back.width*.25;
				else	back.x=0;
			}
		}
		
		protected function mouseL(e:MouseEvent):void
		{
			if([MouseEvent.MOUSE_DOWN,MouseEvent.ROLL_OVER].indexOf(e.type)!=-1){
				setActive(e.currentTarget as Sprite,true);
			}
			else if(e.type==MouseEvent.MOUSE_OUT){
				setActive(e.currentTarget as Sprite,false);
			}
			else if(e.type==MouseEvent.CLICK){
				BaseGlobalCommands.commands.pageFlip(e.currentTarget.name);
			}
		}
		
		public static function setCSS(schem:String):void
		{
			if(pageFlippers)pageFlippers.init();
			scheme = schem;
			
		}
	}
}