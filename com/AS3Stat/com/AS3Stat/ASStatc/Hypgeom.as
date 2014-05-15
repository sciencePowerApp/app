package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Hypgeom extends Distributions {

		function Hypgeom(a:*, b:*,c:*=null):void {
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

		public static function pdf(k:*, N:*, m:*, n:*):* {
			
			// Not clear
			//return k !== k | 0 ? false :k < 0 ? 0 : ASStat.combination(m, k) * ASStat.combination(N - m, n - k) / ASStat.combination(N, n);
		}

		public static function cdf(x:*, N:*, m:*, n:*):* {
			var sum = 0,
			k = 0;
			if (x < 0) {
				return 0;
			}
			for (; k <= x; k++) {
				sum += Hypgeom.pdf(k, N, m, n);
			}
			return sum;
		}





	}
}