package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Uniform extends Distributions {

		function Uniform(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Uniform.sample(a , b);
				});
			} else {
				return Uniform.sample(a, b);
			}
		}
		


// extend uniform function with static methods

	public static function pdf(x:Number, a:Number, b:Number):Number {
		return (x < a || x > b) ? 0 : 1 / (b - a);
	} 

	public static function cdf(x:Number, a:Number, b:Number):Number {
		if (x < a) {
			return 0;
		} else if (x < b) {
			return (x - a) / (b - a);
		}
		return 1;
	} 

	public static function mean(a:Number, b:Number):Number {
		return 0.5 * (a + b);
	} 

	public static function median(a:Number, b:Number):Number {
		return ASStat.mean([a, b]);
	} 

	public static function mode (a:Number, b:Number) {
		// TODO: complete this
	} 

	public static function sample(a:Number, b:Number):Number {
		return (a / 2 + b / 2) + (b / 2 - a / 2) * (2 * Math.random() - 1);
	} 

	public static function variance(a:Number, b:Number):Number {
		return Math.pow(b - a, 2) / 12;
	}



	}
}