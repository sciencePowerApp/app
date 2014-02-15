package com.commands
{
	import flash.display.Stage;

	public class MessagingToUser
	{
		private var stage:Stage;
		private var doingStuffObj:DoingStuff;
		private var _yesNo:YesNo;
		
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
		
		public function yesNo(ON:Boolean, message:String='', saveDataF:Function=null):void
		{
			if(ON){
				_yesNo = new YesNo(message,saveDataF);
				stage.addChild(_yesNo);
			}
			else _yesNo.kill();
			
		}
	}
}

import com.MobileScreen;
import com.PageParse.Page.Elements.Button;
import com.PageParse.Page.Elements.Text;

import flash.display.DisplayObject;
import flash.display.Sprite;

internal class YesNo extends Sprite
{
	var question:Text = new Text;
	var yes:Button = new Button;
	var no:Button = new Button
	
	public function YesNo(message:String, saveDataF:Function):void{
		
		question.compose({data:message});
		yes.compose({data:"yes"});
		no.compose({data:"no"});
		

		
		yes.actions(new <Function>[function():void{
			saveDataF(true);
		}])
		no.actions(new <Function>[function():void{
			saveDataF(false);
		}]);
			
		
		question.render(MobileScreen.stageWidth);
		yes.render(MobileScreen.stageWidth*.5);
		no.render(MobileScreen.stageWidth*.5);
		
		var yMod:int=0;
		var element:DisplayObject=question.giveElement();
		yMod+=element.height;
		this.addChild(element);
		element = yes.giveElement();
		yMod+=element.height;
		var h:int=element.y=this.height;
		var w:int=element.width;
		this.addChild(element);
		element = no.giveElement();
		yMod+=element.height;
		element.y=h;
		element.x=w;
		this.addChild(element);
		
		yMod=MobileScreen.stageHeight*.5-yMod*.5;
		for(var i:int=0;i<3;i++){
			element = this.getChildAt(i);
			element.y+=yMod;
		}
		
		
		
		this.graphics.beginFill(0xffffff,.8);
		this.graphics.drawRect(0,0,MobileScreen.stageWidth,MobileScreen.stageHeight);
		
	}
	
	public function kill():void{
		this.removeChildren();
		stage.removeChild(this);
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
		this.parent.removeChild(this);
		t.removeEventListener(TimerEvent.TIMER,timerL);
		super.kill();
	}
	
}
