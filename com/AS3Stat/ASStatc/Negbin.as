package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Negbin extends Distributions {

		function Negbin(a:*, b:*,c:*=null):void {
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



// extend uniform function with static methods

	public static function pdf(k:*, r:*, p:*):* {
	
	// Not sure
	
	/*return k !== k | 0
			? false
		: k < 0
			? 0
		: ASStat.combination(k + r - 1, k) * Math.pow(1 - p, r) * Math.pow(p, k);
	*/
	} 

	public static function cdf(x:Number, r:Number, p:Number):Number {
		var sum = 0,
			k = 0;
		if (x < 0) return 0;
		for (; k <= x; k++) {
			sum += Negbin.pdf(k, r, p);
		}
		return sum;
	}






	}
}