package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Normal extends Distributions {

		function Normal(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Normal.sample(a,b );
				});
			} else {
				return Normal.sample(a,b);
			}
		}
		// extend Lognormal function with static methods

		// extend lognormal function with static methods
		

// extend normal function with static methods

	public static function pdf(x:Number, mean:Number, std:Number):Number {
		return Math.exp(-0.5 * Math.log(2 * Math.PI) - Math.log(std) - Math.pow(x - mean, 2) / (2 * std * std));
	}

	public static function cdf(x:Number, mean:Number, std:Number) :Number{
		return 0.5 * (1 + ASStat.erf((x - mean) / Math.sqrt(2 * std * std)));
	}

	public static function inv (p:Number, mean:Number, std:Number):Number {
		return -1.41421356237309505 * std * ASStat.erfcinv(2 * p) + mean;
	}

	public static function mean (mean:Number, std:Number):Number {
		return mean;
	}

	public static function median(mean:Number, std:Number):Number {
		return mean;
	}

	public static function mode(mean:Number, std:Number):Number {
		return mean;
	}

	public static function sample(mean:Number, std:Number):Number {
		return ASStat.randn() * std + mean;
	}

	public static function variance(mean:Number, std:Number):Number {
		return std * std;
	}


	}
}