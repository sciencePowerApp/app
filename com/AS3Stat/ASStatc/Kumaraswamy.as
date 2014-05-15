package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;
	// extend F function with static methods
	public class Kumaraswamy extends Distributions {

		function Kumaraswamy(a:*, b:*=null,c:*=null):void {
			super(a,b,c);

		}
		/**
		NO method [sample()] for Kumarswamy distribution
		
		
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Kumaraswamy.sample(a, b );
				});
			} else {
				return Kumaraswamy.sample(a,b);
			}
		}
		*/
		// extend kumarswamy function with static methods

		public static function pdf(x:Number, alpha:Number, beta:Number):Number {
			return Math.exp(Math.log(alpha) + Math.log(beta) + alpha - 1 * Math.log(x) + beta - 1 * Math.log(1 - Math.pow(x,alpha)));
		}

		public static function cdf(x:Number, alpha:Number, beta:Number):Number {
			return 1 - Math.pow(1 - Math.pow(x,alpha),beta);
		}

		public static function mean(alpha:Number, beta:Number):Number {
			return beta * ASStat.gammafn(1 + 1 / alpha) * ASStat.gammafn(beta) / ASStat.gammafn(1 + 1 / alpha + beta);
		}

		public static function median(alpha:Number, beta:Number):Number {
			return Math.pow(1 - Math.pow(2,-1 / beta),1 / alpha);
		}

		public static function mode(alpha:Number, beta:Number):Number {
			return alpha >= 1 && beta >= 1 && alpha !== 1 && beta !== 1?Math.pow(alpha - 1 / alpha * beta - 1,1 / alpha):undefined;
		}

		public static function variance(alpha:Number, beta:Number) {
			// TODO: complete this
		}


	}
}