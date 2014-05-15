package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Pareto extends Distributions {

		function Pareto(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		/* 
		No sample  method for this distribution 
		
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Pareto.sample(a,b );
				});
			} else {
				return Pareto.sample(a,b);
			}
		}
		*/


// extend pareto function with static methods
 
	public static function pdf(x:Number, scale:Number, shape:Number):Number {
		return (x > scale) ? (shape * Math.pow(scale, shape)) / Math.pow(x, shape + 1) : undefined;
	}

	public static function cdf (x:Number, scale:Number, shape:Number):Number {
		return 1 - Math.pow(scale / x, shape);
	}

	public static function mean(scale:Number, shape:Number):Number {
		return (shape > 1) ? (shape * Math.pow(scale, shape)) / (shape - 1) : undefined;
	}

	public static function median(scale:Number, shape:Number):Number {
		return scale * (shape * Math.SQRT2);
	}

	public static function mode(scale:Number, shape:Number):Number {
		return scale;
	}

	public static function  variance(scale:Number, shape:Number):Number {
		return (shape > 2) ? (scale*scale * shape) / (Math.pow(shape - 1, 2) * (shape - 2)) : undefined;
	}



	}
}