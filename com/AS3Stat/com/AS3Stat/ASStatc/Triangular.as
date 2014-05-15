package com.AS3Stat.ASStatc{
	import com.AS3Stat.ASStat;
	
	public class Triangular extends Distributions {

		function Triangular(a:*, b:*=null,c:*=null):void {
			super(a,b,c);

		}
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {return  Triangular.sample(a, b, c);});
			} else {
				return Triangular.sample(a, b, c);
			}
		}


		
// extend triangular function with static methods
 
	public static function pdf(x:Number, a:Number, b:Number, c:Number):Number {
		return (b <= a || c < a || c > b)
			? undefined
		: (x < a || x > b)
			? 0
		: (x <= c)
			? (2 * (x - a)) / ((b - a) * (c - a))
		: (2 * (b - x)) / ((b - a) * (b - c));
	}

	public static function cdf(x:Number, a:Number, b:Number, c:Number):Number {
		if (b <= a || c < a || c > b)
			return undefined;
		if (x < a) {
			return 0;
		} else {
			if (x <= c)
				return Math.pow(x - a, 2) / ((b - a) * (c - a));
			return 1 - Math.pow(b - x, 2) / ((b - a) * (b - c));
		}
		// never reach this
		return 1;
	}

	public static function mean(a:Number, b:Number, c:Number):Number {
		return (a + b + c) / 3;
	}

	public static function median(a:Number, b:Number, c:Number):Number {
		if (c <= (a + b) / 2) {
			return b - Math.sqrt((b - a) * (b - c)) / Math.sqrt(2);
		} else if (c > (a + b) / 2) {
			return a + Math.sqrt((b - a) * (c - a)) / Math.sqrt(2);
		}
		return NaN
	}

	public static function mode(a:Number, b:Number, c:Number):Number {
		return c;
	}

	public static function sample(a:Number, b:Number, c:Number):Number {
		var u = Math.random();
		return u < ((c - a) / (b - a)) ?
			a + Math.sqrt(u * (b - a) * (c - a)) : b - Math.sqrt((1 - u) * (b - a) * (b - c));
	}

	public static function variance(a:Number, b:Number, c:Number):Number {
		return (a * a + b * b + c * c - a * b - a * c - b * c) / 18;
	}


	}
}