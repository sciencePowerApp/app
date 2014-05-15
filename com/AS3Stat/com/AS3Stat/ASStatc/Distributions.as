package  com.AS3Stat.ASStatc {
	import com.AS3Stat.ASStat;
	import flash.utils.*;
	
	public  class Distributions  extends ASStat  {
		protected var _a:*;
		protected var _b:*;
		protected var _c:*;
		protected var _data:*;
		public function Distributions(a:*, b:*=null,c:*=null):void
		{
			
 			init(a, b, c);
		}
		public function init(a:*, b:*=null,c:*=null):*
		{
			_a = a;
			_b = b;
			_c = c;
		}
		
		public function set data(d:*):void
		{
			_data = d;
		}
		
		
		
		 
	}
	
	
		
}