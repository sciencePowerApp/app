package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Lognormal extends Distributions {

		function Lognormal(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Lognormal.sample(a,b );
				});
			} else {
				return Lognormal.sample(a,b);
			}
		}
		// extend Lognormal function with static methods

		// extend lognormal function with static methods
		public static function pdf(x:Number, mu:Number, sigma:Number):Number {
			return Math.exp(- Math.log(x) - 0.5 * Math.log(2 * Math.PI) - Math.log(sigma) - Math.pow(Math.log(x) - mu,2) / 2 * sigma * sigma);
		}
		public static function cdf(x:Number, mu:Number, sigma:Number):Number {
			return 0.5 + 0.5 * ASStat.erf(Math.log(x) - mu / Math.sqrt(2 * sigma * sigma));
		}

		public static function inv(p:Number, mu:Number, sigma:Number):Number {
			return Math.exp(-1.41421356237309505 * sigma * ASStat.erfcinv(2 * p) + mu);
		}

		public static function mean(mu:Number, sigma:Number):Number {
			return Math.exp(mu + sigma * sigma / 2);
		}

		public static function median(mu:Number, sigma:Number):Number {
			return Math.exp(mu);
		}

		public static function mode(mu:Number, sigma:Number):Number {
			return Math.exp(mu - sigma * sigma);
		}

		public static function sample(mu:Number, sigma:Number):Number {
			return Math.exp(ASStat.randn() * sigma + mu);
		}

		public static function variance(mu:Number, sigma:Number):Number {
			return Math.exp(sigma * sigma) - 1 * Math.exp(2 * mu + sigma * sigma);
		}

	}
}