package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.BasicText;
	import com.PageParse.Page.Elements.Primitives.OutputText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Label_and_Text_Element extends Element implements IElement, IGiveValue
	{
		
		protected var combined:Sprite = new Sprite;
		protected var giveGlobalF:Function;
		public var global:Boolean = false;
		protected var name:String;
		protected static var _css:Object;
		protected var myWidth:int;
		
		protected var label:OutputText = new OutputText;
		protected var specialText:BasicText
		public static var height:int = 100;
		
		
		public function Label_and_Text_Element()
		{
		}
		
		public function special():*{
			throw new Error();
		}
		
		
		public function isGlobal():Boolean{
			return global;
		}
		
		
		public function givenGlobalf(f:Function):void{
			giveGlobalF=f;
		}
		
		public function what():String{
			return name;
		}
		
		override public function compose(params:Object):void{
			name = params.name;
			
			if(special is Input)special().composeInput(params);
			else  				special().compose(params);
			
			
			if(params.hasOwnProperty("label"))	addLabel(params.label);
			
			combined.addChild(specialText);		
			super.compose(params);
			
			
			super.compose(params);
			
		}
		
		public function addLabel(str:String):void{
			label=new OutputText();
			label.compose({data:str});
			label.selectable=false;
			combined.addChild(label);
		}
		
		
		
		public function giveElement():DisplayObject{
			return combined;
		}
		
		public function render(width:int):void{
			this.myWidth = width;
			style();
			
			if(label){
				specialText.render(width);
				label.render(width *.4);
				label.x=1;
				label.height=combined.height/2;
				label.y=2;
				special().x=1;
				
			}
			else{
				
				special().render(width);
				special().x=0;
			}
			style();
		}
		
		public function style():void{
			if(_css){
				label.textColor=special().textColor=_css.color;
				special().setFont(_css.fontStyle);
				label.setFont(_css.fontStyle);
				label.tf.bold=true;
				
				//myTextFormat.font=Style.fontName;
			}
			combined.graphics.clear();
			if(_css.hasOwnProperty('backgroundColor')){
				combined.graphics.beginFill(_css.backgroundColor);
			}
			if(_css.hasOwnProperty('border')){
				combined.graphics.lineStyle(_css.border);
			}
			var myHeight:int = height;
			if(combined.height>myHeight)myHeight=height;
			
			combined.graphics.drawRect(0,0,myWidth,myHeight);
			//label.y=combined.height*.5-label.height*.5;
			special().y=combined.height*.5-special().height*.5;
		}
		
		public function request(callBackF:Function):String{
			throw new Error("");
		}
		
		public function kill():void{
			if(label)combined.removeChild(label);
			if(special()){
				combined.removeChild(special());
				special().kill();
			}
			label=null;
			specialText=null;
			super.kill();
			
		}
	}
}