package com.PageParse.Page.Elements.Primitives
{
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFieldType;
	import flash.utils.Timer;

	public class BasicInput extends BasicText
	{
		private var t:Timer;
		
		public function composeInput(params:Object):void
		{
			var chars:int=20;
			if(params.hasOwnProperty("chars")==true)chars=int(chars);
			
			
			this.restrict="0-9";
			
			var inputTxt:String = '';
			if(params.hasOwnProperty("default")){
				inputTxt=params['default']
			}
			else{
				for(var i:int=0;i<chars;i++)inputTxt+=' ';
			}
			this.text=inputTxt;
			this.type = TextFieldType.INPUT;
			this.addEventListener(TextEvent.TEXT_INPUT,listener);
			this.background=true;
			this.backgroundColor=0x335566;
			this.border=true;
		}
		
		override public function kill():void
		{
			t.stop();
			removeListener();
			super.kill();
		}
		
		private function removeListener():void{
			if(this.hasEventListener(TextEvent.TEXT_INPUT))this.removeEventListener(TextEvent.TEXT_INPUT,listener);
		}
		
		protected function listener(e:TextEvent):void
		{
			if(['0','1','2','3','4','5','6','7','8','9'].indexOf(e.text)!=-1){
				removeListener();
				this.text='';
			}
			else{
				t = new Timer(1000,0);
				var txt:String=this.text;
				this.text="numbers only!";
				t.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{
					t.removeEventListener(TimerEvent.TIMER,arguments.callee);
					text=txt;
				});
				t.start();
			}
			
			
		}
	}
}