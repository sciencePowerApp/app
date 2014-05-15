package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Binomial extends Distributions {

		function Binomial(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		/*
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Binomial.sample(a , b);
				});
			} else {
				return Binomial.sample(a, b);
			}
		}
		
*/


// extend Binomial function with static methods

	public static function pdf(k:Number, n:Number, p:Number):Number {
		return (p === 0 || p === 1) ?
			((n * p) === k ? 1 : 0) :
		ASStat.combination(n, k) * Math.pow(p, k) * Math.pow(1 - p, n - k);
	}

	public static function cdf(x:Number, n:Number, p:Number):Number {
		var binomarr = [],
			k = 0;
		if (x < 0) {
			return 0;
		}
		if (x < n) {
			for (; k <= x; k++) {
				binomarr[ k ] = ASStat.binomial.pdf(k, n, p);
			}
			return ASStat.sum(binomarr);
		}
		return 1;
	}





	}
}