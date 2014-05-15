package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;
	// extend F function with static methods
	public class Exponential extends Distributions
	{
		
		function Exponential(a:*, b:*=null, c:*=null):void {
			super(a,b);

		}
		
       public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Exponential.sample(a );
				});
			} else {
				return Exponential.sample(a);
			}
		}
				
		// extend exponential function with static methods
		
		public static function pdf(x:Number, rate:Number):Number {
				return x < 0 ? 0 : rate * Math.exp(-rate * x);
			}
		
		public static function cdf(x:Number, rate:Number):Number {
				return x < 0 ? 0 : 1 - Math.exp(-rate * x);
			}
		
		public static function inv(p:Number, rate:Number):Number {
				return -Math.log(1 - p) / rate;
			}
		
		public static function mean(rate:Number):Number {
				return 1 / rate;
			}
		
		public static function median(rate:Number):Number {
				return (1 / rate) * Math.log(2);
			}
		
		public static function mode(rate:Number):Number {
				return 0;
			}
		
		public static function sample(rate:Number):Number {
				return -1 / rate * Math.log(Math.random());
			}
		
		public static function variance (rate:Number):Number {
				return Math.pow(rate, -2);
			}
		

	}
}