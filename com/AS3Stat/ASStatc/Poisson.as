package com.AS3Stat.ASStatc{
	import com.AS3Stat.ASStat;
	
	public class Poisson extends Distributions {

		function Poisson(a:*, b:*=null,c:*=null):void {
			super(a,b,c);

		}
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {return  Poisson.sample(a);});
			} else {
				return Poisson.sample(a);
			}
		}


		// extend poission function with static methods
		
 
	public static function pdf(k:Number, l:Number):Number {
		return Math.pow(l, k) * Math.exp(-l) / ASStat.factorial(k);
	}

	public static function cdf(x:Number, l:Number):Number {
		var sumarr = [],
			k = 0;
		if (x < 0) return 0;
		for (; k <= x; k++) {
			sumarr.push(Poisson.pdf(k, l));
		}
		return ASStat.sum(sumarr);
	}

	public static function mean(l:Number):Number {
		return l;
	}

	public static function variance(l:Number):Number {
		return l;
	}

	public static function  sample(l:Number):Number {
		var p = 1, k = 0, L = Math.exp(-l);
		do {
			k++;
			p *= Math.random();
		} while (p > L);
		return k - 1;
	}
 

	}
}