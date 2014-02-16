package com.commands
{
	import com.MobileScreen;
	
	import flash.display.Stage;

	public class MessagingToUser
	{
		private var stage:Stage;
		private var _doingStuff:DoingStuff;
		private var _yesNo:YesNo;
		
		public function MessagingToUser(stage:Stage)
		{
			this.stage=stage;
		}
		
		public function doingStuff(ON:Boolean):void
		{
			// TODO Auto Generated method stub
			if(ON)	_doingStuff = new DoingStuff(stage);
			else	_doingStuff.kill();

		}
		
		public function yesNo(ON:Boolean, message:String='', saveDataF:Function=null):void
		{
			if(ON){
				_yesNo = new YesNo(message,saveDataF);
				stage.addChild(_yesNo);
			}
			else _yesNo.kill();
			
		}
		
		public function render(width:int):void
		{
			if(_yesNo)_yesNo.render(width);
			if(_doingStuff)_doingStuff.render(width);
			
		}
	}
}

import com.MobileScreen;
import com.PageParse.Page.Elements.Button;

import flash.display.DisplayObject;
import flash.display.Sprite;

internal class YesNo extends Sprite
{

	var yes:Button = new Button;
	var no:Button = new Button
	
	public function YesNo(message:String, saveDataF:Function):void{
		

		yes.compose({data:message});
		no.compose({data:"no"});
		

		
		yes.actions(new <Function>[function():void{
			saveDataF(true);
		}])
		no.actions(new <Function>[function():void{
			saveDataF(false);
		}]);
		
			
		render(MobileScreen.stageWidth);
		
		
		
	}
	
	public function kill():void{
		this.removeChildren();
		stage.removeChild(this);
	}
	
	
	public function render(width:int):void
	{	
		yes.render(width*.5);
		no.render(width*.5);	
	
		var element:DisplayObject = yes.giveElement();
		this.addChild(element);

		var _y:int=element.width;
		
		element = no.giveElement();
		element.x=_y;
		this.addChild(element);
		
		for (var i:int=0;i<this.numChildren;i++){
			element = this.getChildAt(i);
			element.y=MobileScreen.stageHeight*.5-element.height*.5;
		}
		
		this.graphics.clear();
		this.graphics.beginFill(0xffffff,.8);
		this.graphics.drawRect(0,0,MobileScreen.stageWidth,MobileScreen.stageHeight);
	}
}


import com.PageParse.Page.Elements.Primitives.CenterText;

import flash.display.Stage;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.display.Shape;


internal class DoingStuff extends CenterText
{
	private var symbol:String = "**";
	private var t:Timer;
	private var left:Boolean=false;
	private var count:int=10;
	public var renderSize:int = 200;
	public var bg:Shape = new Shape;

	public function DoingStuff(stage:Stage){
		stage.addChild(bg);
		stage.addChild(this);
	
		t = new Timer(500);
		t.addEventListener(TimerEvent.TIMER,timerL);
		compose({data:"",background:0x000000,colour:0x000000});
		render(renderSize);
		setSize(40);
		t.start();
	}
	
	override public function render(myWidth:int):void{
		bg.graphics.clear();
		bg.graphics.beginFill(0xffffff,.8);
		bg.graphics.drawRect(0,0,MobileScreen.stageWidth,MobileScreen.stageHeight);
		super.render(width);
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
		stage.removeChild(bg);
		stage.removeChild(this);
		t.removeEventListener(TimerEvent.TIMER,timerL);
		super.kill();
	}
	
}
