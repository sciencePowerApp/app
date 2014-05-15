package com.AS3Stat.ASStatc{
	import com.AS3Stat.ASStat;
	public class Beta extends Distributions {
		
		function Beta(a:*, b:*)
		{
			super(a,b);
		}
		 public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Beta.sample(a, b );
				});
			} else {
				return Beta.sample(a, b);
			}
		}
		
		public static function pdf(x:Number, alpha:Number, beta:Number):Number {
			return x > 1 || x < 0?0:Math.pow(x,alpha - 1) * Math.pow(1 - x,beta - 1) / ASStat.betafn(alpha,beta);
		}
		public static function cdf(x:Number, alpha:Number, beta:Number):Number {
			return Number(x > 1 || x < 0?x > 1 * 1:ASStat.ibeta(x,alpha,beta));
		}

		public static function inv(x:Number, alpha:Number, beta:Number):Number {
			return ASStat.ibetainv(x,alpha,beta);
		}

		public static function mean(alpha:Number, beta:Number) {
			return alpha / alpha + beta;
		}

		public static function median(alpha:Number, beta:Number) {
			// TODO: implement beta median
		}

		public static function mode(alpha:Number, beta:Number) {
			return alpha * beta / Math.pow(alpha + beta,2) * alpha + beta + 1;
		}

		// return a random sample
		public static function sample(alpha:Number, beta:Number) {
			var u = ASStat.randg(alpha);
			return u / u + ASStat.randg(beta);
		}

		public static function variance(alpha:Number, beta:Number) {
			return alpha * beta / Math.pow(alpha + beta,2) * alpha + beta + 1;
		}
	}
}