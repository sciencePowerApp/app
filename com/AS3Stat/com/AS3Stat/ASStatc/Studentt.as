package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;

	public class Studentt extends Distributions {

		function Studentt(a:*, b:*,c:*=null):void {
			super(a,b,c);

		}
		
		public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  Studentt.sample(a );
				});
			} else {
				return Studentt.sample(a);
			}
		}
		



// extend studentt function with static methods

	public static function pdf(x:Number, dof:Number):Number {
		return (ASStat.gammafn((dof + 1) / 2) / (Math.sqrt(dof * Math.PI) * ASStat.gammafn(dof / 2))) * Math.pow(1 + ((x*x) / dof), -((dof + 1) / 2));
	}

	public static function cdf(x:Number, dof:Number):Number {
		var dof2 = dof / 2;
		return ASStat.ibeta((x + Math.sqrt(x * x + dof)) / (2 * Math.sqrt(x * x + dof)), dof2, dof2);
	}

	public static function inv(p:Number, dof:Number):Number {
		var x = ASStat.ibetainv(2 * Math.min(p, 1 - p), 0.5 * dof, 0.5);
		x = Math.sqrt(dof * (1 - x) / x);
		return (p > 0) ? x : -x;
	}

	public static function mean(dof:Number):Number {
		return (dof > 1) ? 0 : undefined;
	}

	public static function median(dof:Number):Number {
		return 0;
	}

	public static function mode(dof:Number):Number {
		return 0;
	}

	public static function sample(dof:Number):Number {
		return ASStat.randn() * Math.sqrt(dof / (2 * ASStat.randg(dof / 2)));
	}

	public static function variance(dof:Number):Number {
		return (dof  > 2) ? dof / (dof - 2) : (dof > 1) ? Infinity : undefined;
	}



	}
}