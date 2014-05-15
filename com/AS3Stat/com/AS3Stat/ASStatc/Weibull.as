package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Weibull extends Distributions {

		function Weibull(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Weibull.sample(a , b);
				});
			} else {
				return Weibull.sample(a, b);
			}
		}
		



// extend weibull function with static methods

	public static function pdf (x:Number, scale:Number, shape:Number):Number {
		return x < 0 ? 0 : (shape / scale) * Math.pow((x / scale),(shape - 1)) * Math.exp(-(Math.pow((x / scale), shape)));
	}

	public static function cdf (x:Number, scale:Number, shape:Number):Number {
		return x < 0 ? 0 : 1 - Math.exp(-Math.pow((x / scale), shape));
	}

	public static function inv(p:Number, scale:Number, shape:Number):Number {
		return scale * Math.pow(-Math.log(1 - p), 1 / shape);
	}

	public static function mean (scale:Number, shape:Number):Number {
		return scale * ASStat.gammafn(1 + 1 / shape);
	}

	public static function median(scale:Number, shape:Number):Number {
		return scale * Math.pow(Math.log(2), 1 / shape);
	}

	public static function mode (scale:Number, shape:Number):Number {
		return (shape > 1) ? scale * Math.pow((shape - 1) / shape, 1 / shape) : undefined;
	}

	public static function sample(scale:Number, shape:Number):Number {
		return scale * Math.pow(-Math.log(Math.random()), 1 / shape);
	}

	public static function variance (scale:Number, shape:Number):Number {
		return scale * scale * ASStat.gammafn(1 + 2 / shape) - Math.pow(mean(scale, shape), 2);
	}


	}
}