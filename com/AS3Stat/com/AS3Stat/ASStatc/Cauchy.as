package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;
	// extend F function with static methods
	public class Cauchy extends Distributions
	{
		
		function Cauchy(a:*, b:*,c:*):void {
			super(a,b,c);

		}
		
		
       public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Cauchy.sample(a, b );
				});
			} else {
				return Cauchy.sample(a,b);
			}
		}
		
		public static function pdf(x:Number, local:Number, scale:Number):Number {
			return (scale / (Math.pow(x - local, 2) + Math.pow(scale, 2))) / Math.PI;
		}
	
		public static function cdf (x:Number, local:Number, scale:Number):Number {
			return Math.atan((x - local) / scale) / Math.PI + 0.5;
		}
	
		public static function inv(p:Number, local:Number, scale:Number):Number {
			return local + scale * Math.tan(Math.PI * (p - 0.5));
		}
	
		public static function median(local:Number, scale:Number):Number {
			return local;
		}
	
		public static function mode(local:Number, scale:Number):Number {
			return local;
		}
	
		public static function sample(local:Number, scale:Number):Number {
			return ASStat.randn() * Math.sqrt(1 / (2 * ASStat.randg(0.5))) * scale + local;
		}
		
	}
}