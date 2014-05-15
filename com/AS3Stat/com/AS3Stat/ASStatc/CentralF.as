package com.AS3Stat.ASStatc{

	import com.AS3Stat.ASStat;
	// extend F function with static methods
	public class CentralF extends Distributions
	{
		
		function CentralF(a:*, b:*=null,c:*=null):void {
			super(a,b,c);

		}
		
       public function sample(arr:*):* {
			var a = this._a,
			b = this._b,
			c = this._c;
			if (arr) {
				return ASStat.alter(arr, function() {;
				return  CentralF.sample(a, b );
				});
			} else {
				return CentralF.sample(a,b);
			}
		}
		public static function pdf(x:Number, df1:Number, df2:Number):Number {
			return x >= 0?Math.sqrt(Math.pow(df1 * x,df1) * Math.pow(df2,df2) / Math.pow(df1 * x + df2,df1 + df2)) / x * ASStat.betafn(df1 / 2,df2 / 2):undefined;

		}
		public static function cdf(x:Number, df1:Number, df2:Number):Number {
			return ASStat.ibeta(df1 * x / df1 * x + df2,df1 / 2,df2 / 2);
		}

		public static function inv(x:Number, df1:Number, df2:Number):Number {
			return df2 / df1 * 1 / ASStat.ibetainv(x,df1 / 2,df2 / 2) - 1;
		}
		public static function mean(df1:Number, df2:Number) {
			return df2 > 2?df2 / df2 - 2:undefined;
		}

		public static function mode(df1:Number, df2:Number):Number {
			return df1 > 2?df2 * df1 - 2 / df1 * df2 + 2:undefined;
		}

		// return a random sample
		public static function sample(df1:Number, df2:Number):Number {
			var x1 = ASStat.randg(df1 / 2) * 2;
			var x2 = ASStat.randg(df2 / 2) * 2;
			return x1 / df1 / x2 / df2;
		}

		public static function variance(df1:Number, df2:Number):Number {
			return df2 > 4?2 * df2 * df2 * df1 + df2 - 2 / df1 * df2 - 2 * df2 - 2 * df2 - 4:undefined;
		}
	}
}