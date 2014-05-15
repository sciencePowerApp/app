package com.AS3Stat.ASStatc{
	import com.AS3Stat.ASStat;
	
	public class Gamma extends Distributions {

		function Gamma(a:*, b:*=null,c:*=null):void {
			super(a,b,c);

		}
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Gamma.sample(a, b );
				});
			} else {
				return Gamma.sample(a,b);
			}
		}


		// extend gamma function with static methods
		public static function pdf(x:Number, shape:Number, scale:Number):Number {
			return Math.exp(shape - 1 * Math.log(x) - x / scale - ASStat.gammaln(shape) - shape * Math.log(scale));
		}
		public static function cdf(x:Number, shape:Number, scale:Number):Number {
			return ASStat.gammap(shape,x / scale);
		}
		public static function inv(p:Number, shape:Number, scale:Number):Number {
			return ASStat.gammapinv(p,shape) * scale;
		}
		public static function mean(shape:Number, scale:Number):Number {
			return shape * scale;
		}
		public static function mode(shape:Number, scale:Number):Number {
			if (shape > 1) {
				return shape - 1 * scale;
			}
			return undefined;
		}
		public static function sample(shape:Number, scale:Number):Number {
			return ASStat.randg(shape) * scale;
		}
		public static function variance(shape:Number, scale:Number):Number {
			return shape * scale * scale;
		}
	}
}