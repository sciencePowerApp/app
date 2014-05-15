package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;
	// extend F function with static methods
	public class Chisquare extends Distributions
	{
		
		function Chisquare(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		
		
       public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Chisquare.sample(a );
				});
			} else {
				return Chisquare.sample(a);
			}
		}
		
		
// extend chisquare function with static methods

	public static function pdf(x:Number, dof:Number):Number {
		return Math.exp((dof / 2 - 1) * Math.log(x) - x / 2 - (dof / 2) * Math.log(2) - ASStat.gammaln(dof / 2));
	} 

	public static function cdf(x:Number, dof:Number):Number {
		return ASStat.gammap(dof / 2, x / 2);
	} 

	public static function inv(p:Number, dof:Number):Number {
		return 2 * ASStat.gammapinv(p, 0.5 * dof);
	} 

	public static function mean(dof:Number):Number {
		return dof;
	} 

	//TODO: this is an approximation (is there a better way?)
	public static function median(dof:Number):Number {
		return dof * Math.pow(1 - (2 / (9 * dof)), 3);
	} 

	public static function mode(dof:Number):Number {
		return (dof - 2 > 0) ? dof - 2 : 0;
	} 

	public static function sample(dof:Number):Number {
		return ASStat.randg(dof / 2) * 2;
	}

	public static function variance(dof:Number):Number {
		return 2 * dof;
	}

		
	}
}