package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;
	// extend F function with static methods
	public class Invgamma extends Distributions
	{
		
		function Invgamma(a:*, b:*=null,c:*=null):void {
			super(a,b,c);

		}
		
       public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Invgamma.sample(a, b );
				});
			} else {
				return Invgamma.sample(a,b);
			}
		}
		
	// extend inverse gamma function with static methods
	
		public static function pdf(x:Number, shape:Number, scale:Number):Number {
			return Math.exp(-(shape + 1) * Math.log(x) - scale/x - ASStat.gammaln(shape) + shape * Math.log(scale));
		} 
	
		public static function cdf(x:Number, shape:Number, scale:Number):Number {
			return 1 - ASStat.gammap(shape, scale / x);
		} 
	
		public static function inv(p:Number, shape:Number, scale:Number):Number {
			return scale / ASStat.gammapinv(1 - p, shape);
		} 
	
		public static function mean(shape:Number, scale:Number):Number {
			return (shape > 1) ? scale / (shape - 1) : undefined;
		} 
	
		public static function mode(shape:Number, scale:Number):Number {
			return scale / (shape + 1);
		} 
	
		public static function sample(shape:Number, scale:Number):Number {
			return scale / ASStat.randg(shape);
		} 
	
		public static function variance(shape:Number, scale:Number):Number {
			return (shape > 2) ? scale * scale / ((shape - 1) * (shape - 1) * (shape - 2)): undefined;
		}
	


	}
}