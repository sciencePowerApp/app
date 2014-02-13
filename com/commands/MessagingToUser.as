package com.commands
{
	import flash.display.Stage;

	public class MessagingToUser
	{
		private var stage:Stage;
		private var doingStuffObj:DoingStuff;
		
		public function MessagingToUser(stage:Stage)
		{
			this.stage=stage;
		}
		
		public function doingStuff(ON:Boolean):void
		{
			// TODO Auto Generated method stub
			if(ON)	doingStuffObj = new DoingStuff(stage);
			else	doingStuffObj.kill();

		}
	}
}

import com.PageParse.Page.Elements.Primitives.CenterText;

import flash.display.Stage;
import flash.events.TimerEvent;
import flash.utils.Timer;

internal class DoingStuff extends CenterText
{
	var symbol:String = "**";
	var t:Timer;
	var left:Boolean=false;
	var count:int=10;

	public function DoingStuff(stage:Stage){
		stage.addChild(this);
	
		t = new Timer(500);
		t.addEventListener(TimerEvent.TIMER,timerL);
		compose({data:"",background:0x000000,colour:0x000000});
		render(200);
		setSize(40);
		
		t.start();
	}
	
	protected function timerL(event:TimerEvent):void
	{
		if(this.text.length>count){
			left=true;
		}
		else if(this.text.length==0){
			left=false;
		}
		if(left){
			this.text=this.text.substr(0,this.text.length-2);
		}
		else{
			this.text+=symbol;
		}
		
	}
	
	override public function kill():void{
		t.stop();
		t.removeEventListener(TimerEvent.TIMER,timerL);
		super.kill();
	}
	
}
