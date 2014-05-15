package com.AS3Stat
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
    import com.AS3Stat.ASStatc.*;
	
	use namespace flash_proxy;
	
	dynamic public  class ASStat extends Proxy  
	{
		private var _array:Array;
		public static var ascNum:Function = function (a:*, b:*){ return a -b;};
		// Constructor
		function ASStat(arg1:*=null, arg2:*=null, arg3:*=null, arg4:*=null, arg5:*=null, arg6:*=null, arg7:*=null):void
		{
			var i:uint=0;
			
			var args:Array=[];
			
			for(;i<arguments.length;i++)
			{
				//trace( i+ " is array :"+ (arguments[i] is Array));
				//if((arguments[i] is Array))  trace (" ***********  array length :"+arguments[i].length);
				args[i]=arguments[i];
			}
			//trace(" *** args.length:"+arguments[0].length);
			_array=new Array();
			if(args.length>0) init(args);
			
			
			
		}
		private  static var distribution:Array=new Array();
		
		
		public static function gamma(a:*,b:*=null,c:*=null):Gamma
		{
			return  Gamma(dInstance(Gamma, a,b,c));
		}
				
		public static function centralF(a:*,b:*=null,c:*=null):CentralF
		{
			return  CentralF(dInstance(CentralF, a,b,c));
		}
		public static function cauchy(a:*,b:*=null,c:*=null):Cauchy
		{
			return  Cauchy(dInstance(Cauchy, a,b,c));
		}
		
		public static function chisquare(a:*,b:*=null,c:*=null):Chisquare
		{
			return  Chisquare(dInstance(Chisquare, a,b,c));
			
		}
		public static function exponential(a:*,b:*=null,c:*=null):Exponential
		{
			return  Exponential(dInstance(Exponential, a,b,c));
			
		}
		
		public static function invgamma(a:*,b:*=null,c:*=null):Invgamma
		{
			return  Invgamma(dInstance(Invgamma, a,b,c));
			
		}
		public static function kumaraswamy(a:*,b:*=null,c:*=null):Kumaraswamy
		{
			return  Kumaraswamy(dInstance(Kumaraswamy, a,b,c));
			
		}
		
		public static function lognormal(a:*,b:*=null,c:*=null):Lognormal
		{
			return  Lognormal(dInstance(Lognormal, a,b,c));
			
		}
		
		public static function normal(a:*,b:*=null,c:*=null):Normal
		{
			return  Normal(dInstance(Normal, a,b,c));
			
		}
		public static function pareto(a:*,b:*=null,c:*=null):Pareto
		{
			return  Pareto(dInstance(Pareto, a,b,c));
			
		}
		public static function studentt(a:*,b:*=null,c:*=null):Studentt
		{
			return  Studentt(dInstance(Studentt, a,b,c));
			
		}
		public static function weibull(a:*,b:*=null,c:*=null):Weibull
		{
			return  Weibull(dInstance(Weibull, a,b,c));
			
		}
		public static function uniform(a:*,b:*=null,c:*=null):Uniform
		{
			return  Uniform(dInstance(Uniform, a,b,c));
			
		}
		public static function negbin(a:*,b:*=null,c:*=null):Negbin
		{
			return  Negbin(dInstance(Negbin, a,b,c));
			
		}
		public static function hypgeom(a:*,b:*=null,c:*=null):Hypgeom
		{
			return  Hypgeom(dInstance(Hypgeom, a,b,c));
			
		}
		
		public static function poisson(a:*,b:*=null,c:*=null):Poisson
		{
			return  Poisson(dInstance(Poisson, a,b,c));
			
		}
		
		public static function triangular(a:*,b:*=null,c:*=null):Triangular
		{
			return  Triangular(dInstance(Triangular, a,b,c));
			
		}
		private static function dInstance(cc:Class, a:*,b:*=null, c:*=null):Distributions
		{
			
			 if(!(distribution[cc] )) {
				
				distribution[cc] = new  cc(a,b,c);
				return distribution[cc];
			
			}else {
				
				distribution[cc].init(a,b,c);
			
			}
			
			return distribution[cc];
			
			
		}
		
		override flash_proxy function callProperty(name:*, ...rest):*
		{
			
			// extend function with methos ich don't require arguments and work on columns
			
			var validFnames:Array = ['sum','sumsqrd','sumsqerr','product','min','max','mean','meansqerr', 'geomean', 'median','dif','mode','range', 'variance', 'stdev','meandev', 'meddev', 'coeffver','quartiles'];
			var flag:Boolean =validFnames.indexOf(String(name))>=0?true:false;
			
			if(flag) {
				return workOnColumn(name,rest[0]);
				 
			}
			
			 validFnames = ['transpose','clear','symmetric','rows','cols','dimensions','diag','antidiag'];
			 flag =validFnames.indexOf(String(name))>=0?true:false;
			
			if(flag) {
				return workOn2(name,rest[0]);
				 
			}
			  validFnames = ['row','col'];
			 flag =validFnames.indexOf(String(name))>=0?true:false;
			
			if(flag) {
				return workOn3(name,rest[0]);
				 
			}
			  validFnames = ['create','zeros', 'ones','rand','identity'];
			 flag =validFnames.indexOf(String(name))>=0?true:false;
			
			if(flag) {
				return workOn4(name,rest);
				 
			}
			
			validFnames=['cumsum'];
			flag=validFnames.indexOf(String(name))>=0?true:false;
			if(flag)
			{
				return  this.cumsum(name, rest[0]);
			}
			
			
			validFnames=['gammaln','gammafn','factorial','factorialln'];
			flag=validFnames.indexOf(String(name))>=0?true:false;
			if(flag)
			{
				return  this.gamaInstanceMethods(name, rest[0]);
			}
			validFnames=['randn'];
			flag=validFnames.indexOf(String(name))>=0?true:false;
			if(flag)
			{
				return  this.randn(name, rest[0]);
			}
			
			validFnames=['beta', 'centralF', 'cauchy', 'chisquare', 'exponential', 'gamma', 'invgamma', 'kumaraswamy', 'lognormal', 'normal', 'pareto', 'studentt', 'weibull', 'uniform', 'binomial', 'negbin', 'hypgeom', 'poisson', 'triangular']
			flag=validFnames.indexOf(String(name))>=0?true:false;
			if(flag)
			{
				return  this.generalDistribution(name, rest );
			}
			
			trace("   .... call method "+name);
			return _array[name].apply(_array,rest);
		}
		// extend ASStat.fn with method for calculating cumulative sums, as it does not run again in case of true
		// if a matrix is passed, automatically assume operation should be done on the columns
		protected function cumsum(name:*, fullbool:*):*
		{
			var arr:Array = [];
			var i:uint=0;
			var tmpArray:Array = _array;
			var f:Function;
			// assignment ressignation depending onhow parameters were passed in
			if(isFunction(fullbool)) {
				 f = fullbool;
				 fullbool= false;
			}
			// check if a callback was passed with the function
			
			if(_array.length>1){
				tmpArray = fullbool == true? _array: ASStat.transpose(_array);
				for(;i<tmpArray.length;i++){
					arr[i] = ASStat.cumsum(tmpArray[i]);
				}
				return arr;
			}
			return ASStat.cumsum(_array[0]);
		}
		
		// extend ASStat.fn with simple shortcut methods
		private function workOn4(name:*, ...res:*):*
		{
			 
			var v:* = new ASStat(ASStat[String(name)].apply(null,res[0]));
			 
			 return v; 
			 
		}
		// extend ASStat.fn with methods that have one argument
		private function workOn3(name:*, index:uint):*
		{
			
			
			  var tmpArray:Array=_array;
			  return ASStat[String(name)](_array,index);
				 
		}
		// extend ASStat.fn with methods which have no argument
		private function workOn2(name:*, fullbool:Boolean):*
		{
			    var arr:Array = [];
				var i:uint=0;
				
				 
				
					var tmpArray:Array=_array;
					var results:* = ASStat[String(name)](_array);;
									
				// pass fullbool if only vector, not a matrix for variance and stdev
				return ASStat.isArray(results)? new ASStat(results):results; 
				
		}
		// extend ASStat.fn with methods which don't require arguments and work on columns
		private function workOnColumn(name:*, fullbool:Boolean):*
		{
		    
			
				var arr:Array = [];
				var i:uint=0;
				var f:Function = ASStat[String(name)] as Function;
				
				// check if matrix and run calculations
				if(_array.length>1)
				{
					var tmpArray:Array=_array;
					// rest[0] == true indicates to run on whole matrix for min/max
					if(!fullbool){
					
						 tmpArray = ASStat.transpose(_array);
					}
					 
					for(i=0;i<tmpArray.length;i++)
					{
						 arr[i] = f(tmpArray[i]);
					} 
					
					return fullbool===true? f(arr):arr;
					
				}
				
				// pass fullbool if only vector, not a matrix for variance and stdev
				return f(_array[0]); 
				
				
				
				
			
		}
		override flash_proxy function getProperty(name:*):*
		{
			  return _array[name];
		}
		override flash_proxy function setProperty(name:*, value:*):void
		{
			_array[name] = value;
		}
		private function init(... args1):void
		{
			var i:uint=0;
			var args:*=args1[0];
			
			//for(i=0; i<args.length;i++){
				//trace( i+">>"+args[i]);
			//}
			//trace(" is array :"+ASStat.isArray(args[0]));
			// if first argument is an array, must be vector or matrix
			if(ASStat.isArray(args[0]))
			{
				
				
				 //check if matrix
				 if(isArray(args[0][0]))
				 {
					 
					 
					 // see if mapping function was also passed
					 if(isFunction(args[1]))
					 {
						 args[0] = args[0].map(args[1]);
					 }
					 //itterating over each is faster than this.push.apply(this, args[0]);
					 i=0;
					 for(;i<args[0].length;i++)
					 {
						
						 _array[i] = args[0][i]; 
						// trace(args[0].length+" >>>>>>>>>>>>>>>>>>matrix>>>>>>>>>>>"+_array[i]);
					 }
					 _array.length = args[0].length;
										 
				 // so must be vector		 
				 } else
				 {  
				 //  _array.push(234);_array.push(65);
				  // trace(" this..."+this.length+"  ///");
				      _array[0] = isFunction(args[1])?args[0].map(args[1]):args[0];
					  _array.length = 1;
					 
				} 
					
			// if first argument is number, assume creation of sequece
			} else if (isNumber(args[0]))
			{
				trace(" is number "+args);
				  _array[0] = ASStat.seq.apply(null, args);
				  _array.length = 1;
			// handle case when ASStat object is passed to ASStat
			}else if (args[0] is ASStat)
			{
				// duplicate the object and pass it back
				 _array[0] =args[0];
				 _array.length = 1;
				 
			// unexpected argument value, return empty ASStat object
			} else {
				_array[0] = [];
				_array.length = 1;
			}
			
		}
		// generate sequence
	   public static function seq(min:Number, max:Number, length:uint, func:*=null):Array
		{
			if(!isFunction(func)) func = false;
			
			var arr:Array=[];
	        var hival:Number = ASStat.calcRdx(min, max);
			var step:Number = (max * hival - min * hival) / ((length - 1) * hival);	
			var current:Number = min;
			var cnt:int = 0;
			// current is assigned using a tecnique to compensate for IEEE error
			for(; current<=max; cnt++, current = (min * hival + step * hival * cnt) /hival)
			      arr.push((func ? func ( current, cnt) : current));
		    return arr;
		}
		
		// calculate correction for IEEE error
		public static function calcRdx(n:Number, m:Number):Number
		{
			var val:Number = n > m ? n : m;
			return Math.pow(10,17 - ~~(Math.log((( val > 0) ? val : - val)) * Math.LOG10E));
		}
		
		// test if array
		public static function isArray(arg:*):Boolean
		{
			
			return arg is Array;
		}
		
		// test if array
		public static function isFunction(arg:*):Boolean
		{
			
			return arg is Function;
		}
		
		// test if array
		public static function isNumber(arg:*):Boolean
		{
			
			return (arg is Number) && !isNaN(arg);
		}
		
		// Returns the number of rows in the matrix;
		public static function rows(arr:*):uint
		{
			return arr.length || 1;
		}
		
		// Returns the number of columns in the matrix
		public static function cols(arr:Array):uint
		{
			return arr[0].length || 1;
		}
		// Returns the dimensions of the object {rows:i, cols:j}
		public static function dimensions(arr:Array):Object
		{
			return {rows : ASStat.rows(arr), cols:ASStat.cols(arr)};
		}
		
		// Returns a specified row as a vector
		public static function row(arr, index){
			 return arr[ index];
		}
		// Returns a specified column as a vector
		public static function col(arr, index):Array
		{
			var column:Array = new Array(arr.length);
			var i:uint=0;
			for (;i<arr.length; i++){
				column[i] = [ arr[i][index] ];
			}
			return column;
		}
		
		// Returns the diagonal of the matrix
		public static function diag(arr:Array):Array
		{
			
			  var row:uint=0;
			  var nrow:uint = ASStat.rows(arr);
			  var res:Array = new Array(nrow);
			  for (;row < nrow; row++)
			  {
				   res[row] = [ arr[row][row] ];  
			  }
			  return res;
		}
		
		
		// Returns the anti-diagonal of the matrix
		
		public static function antidiag ( arr:Array):Array
		{
			var nrow:uint=ASStat.rows(arr) - 1;
			var res:Array = new Array(nrow)
			var i:uint=0;
			for(;nrow >=0; nrow --, i++)
			{
				  res[i] = [ arr[i][nrow]];
			}
			return res;
		}
		
		// taspose a matrix or array
		
		public static function transpose(arr){
			var obj:Array = [];
			var i:uint=0;
			var rows:uint;
			var cols:uint;
			var j:uint=0;
			// make sure arr is in matrix format
			if(!isArray(arr[0])) arr = [arr];
			rows = arr.length;
			cols = arr[0].length;
			for(;i<cols;i++)
			{
				obj.push(new Array(rows));
				for (j=0; j<rows;j++)
				{
					obj[i][j] = arr[j][i];
				}
			
			}
			
			// if obj is vector, return only sinle array
			return (obj.length === 1) ? obj[0]: obj;
			
			
			
		}
		
		// map a function to an array or arry of arrays
		// toAlter is an internal variable
	    public static  function map(arr:*, func:*, toAlter:Boolean=false):*
		{
			var row:uint=0;
			var nrow:uint=0;
			var ncol:uint=0;
			var res:*;
			var col:uint=0;
			if( !isArray(arr[0])) arr = [arr];
			nrow = arr.length;
			ncol = arr[0].length;
			res = toAlter? arr: new Array(nrow);
			for(;row<nrow;row++)
			{
				// if the row dosen't exist, create it
				if(!res[row]) res[row] = new Array(ncol);
				for(col=0;col<ncol;col++)
				{
					 res[row][col]=func(arr[row][col], row, col);
				}
				
				
				
			}
			return (res.length === 1)? res[0]:res;
			
			
			
		}
		
		
		// destructively alter an array
		public static function alter(arr:*, func:*):*
		{
			return ASStat.map(arr, func, true);
		}
		
		// generate a row x cols matrix according to the supplied function
		public static function create(rows:*, cols:*, func:*):*
		{
			var res:* = new Array(rows);
			var i:uint=0;
			var j:uint=0;
			if(isFunction(cols)){
				func = cols;
				cols = rows;
			}
			for ( i=0;i<rows;i++){
				res[i] = new Array(cols);
				for(j=0; j<cols; j++){
					res[i][j] = func(i,j);
				}
			}
			return new ASStat(res);
			
			
		}
		
		// generate a rows x cols matrix of zros
		public static function zeros(rows:*, cols:*):*
		{
			if(!isNumber(cols)) cols=rows;
			return  ASStat.create(rows, cols, function(){ return 0;});
		}
		
		// generate a rows x cols matrix of ones
		public static function ones(rows:*, cols:*):*
		{
			if(!isNumber(cols)) cols=rows;
			return ASStat.create(rows,cols, function(){ return 1;});
		}
		// generate a rows x cols mtrix of uniformly random numbers
		public static function rand(...argg:*):*
		{ 
		    var rows:* ;
			var cols:* ;
			rows = argg[0];
			
			if(argg.length==1) cols = rows;
			
			return ASStat.create(rows, cols, function(){ return Math.random();});
		}
		
		// generate an identy matrix of size row x cols
		public static function identiy(rows:*, cols:*):*
		{
			if(!isNumber(cols)) cols = rows;
			return ASStat.create(rows, cols, function(i,j){ return (i===j)?1:0;});
		}
		// Test whether a matrix is symmetric
		public static function symmetric ( arr:*):Boolean
		{
			
			 var issymmetric = true;
			 var row:uint=0;
			 var size:uint = arr.length;
			 var col:uint;
			 if(arr.length !=arr[0].length) return false;
			 for(;row<size;row++)
			 {
				for(col=0;col<size;col++)
				{
					if(arr[col][row] !==arr[row][col]) return false;
				}
			 }
			 return true;
			 
			
		}
		
		// set all values to zero
		
		public static function clear(arr:*):*
		{
			
			return ASStat.alter(arr, function(){ return 0;});
			
		}
		
		//==========================  non static area =======================
		
		// sum of an array
		public static function sum(arr:Array):Number
		{
			var sum:Number =0;
			var i:uint=arr.length;
			var tmp:Number;
			while( --i>=0){
				sum += arr[i];
			}
			return sum;
		}
		
		// sum squared
		public static function sumsqrd(arr:Array):Number
		{
			var sum :Number =0;
			var i:uint = arr.length;
			while( --i>=0) sum += arr[i] *arr[i];
			return sum;
			
		}
		// sum of squared errors of prediction (SSE)
		
		public static function sumsqerr(arr:Array):Number
		{
			var mean:Number = ASStat.mean(arr);
			var sum:Number =0;
			var i:uint = arr.length;
			var tmp:Number;
			while(--i>=0){
				tmp = arr[i] - mean;
				sum +=tmp * tmp;
				
			}
			return sum ;
		}
		
		// product of an array
		public static function product(arr:Array):Number
		{
			var prod:Number = 1;
			var i:uint = arr.length;
			while(--i>=0) prod *=arr[i];
			return prod;
		}
		
		// minimum value of an array
		public static function min(arr:Array):Number
		{
			var low:Number = arr[0];
			var i:uint=0;
			while(++i<arr.length)
			    if(arr[i]<low) low=arr[i];
		    return low;
		}
		// maximum value of an array
		public  static function max(arr:Array):Number
		{
			var high:Number = arr[0];
			var i:uint=0;
			while(++i <arr.length)
			    if(arr[i] > high) high = arr[i];
			return high;												
															
		}
		
		// mean value of an array
		public  static function mean(arr:Array):Number
		{
			return ASStat.sum(arr) / arr.length;
		}
		
		// mean squared error (MSE)
		public  function meansqerr(arr:Array):Number
		{
			return ASStat.sumsqerr(arr)/arr.length;
		}
		
		// geometric mean of an array
		public  static function geomean(arr:Array):Number
		{
			return Math.pow(ASStat.product(arr), 1/arr.length);
		}
		
		// median of an array
		public static  function median(arr:Array):Number
		{
			var arrlen:uint = arr.length;
			var _arr:Array = arr.slice().sort(ascNum);
			// check if array is even or odd, then return the appropriate
			return !(arrlen & 1)?(_arr[(arrlen /2)-1]+_arr[(arrlen/2)])/2 : _arr[(arrlen /2) |0];
		}
		
		// cumulative sum of an array
		public static  function cumsum(arr){
			var lan:uint = arr.length;
			var sums:Array = new Array(lan);
			var i:uint= 1;
			sums[0]=arr[0];
			for(;i<lan;i++){
				sums[i] = sums[i - 1] + arr[i];
			}
			return sums;
		}
		
		// successive dfferences of a sequence
		protected  function dff(arr:Array):Array
		{
			var diffs:Array  = [];
			var arrLen:uint = arr.length;
			var i:uint = 1;
			for(i=1;i<arrLen;i++){
				diffs.push(arr[i] - arr[i-1]);
				
			}
			return diffs;
		}
		
		// mode of an array
		// if there are mltiple modes of an array, return all of them
		// is this the appropriate way o handling it?
		protected  function mode(arr:Array):*
		{
			var arrLen:uint = arr.length;
			var _arr:Array = arr.slice().sort(ascNum);
			var count :uint = 1;
			var maxCount:uint=0;
			var numMaxCount:uint = 0;
			var i:uint = 0;
			var mode_arr:Array = [];
			for(;i<arrLen; i++)
			{
				if( _arr[i] === _arr[i+1]){
					count++;
				}else{
					if( count > maxCount){
						mode_arr = [_arr[i]];
						maxCount = count;
						numMaxCount = 0;
					}
					// are there multiple max counts
					else if(count === maxCount){
						mode_arr.push(_arr[i]);
						numMaxCount++;
					}
					// reetting count for new value in array
					count = 1;
				}
			}
			return (numMaxCount ===0) ? mode_arr[0] : mode_arr;
		}
		
		// range of an array
		protected  function range(arr:Array):Number
		{
			 return this.max(arr) - this.min(arr);
		}
		
		// variance of an array
		// flag indicates population vs sample
		protected  function variance(arr:Array, flag:Boolean = false ):Number
		{
			return this.sumsqerr(arr) / (arr.length - (flag?1:0));
		}
		
		// standard deviation of an array
		// flag indicates population vs sample
		
		protected  function stdev(arr:Array, flag:Boolean =false):Number
		{
			return Math.sqrt(this.variance(arr, flag));
		}
		
		// mean deviation ( mean absolute deviation ) of an array
		protected  function meandev(arr:Array):Number
		{
			var devSum:Number =0;
			var mean = this.mean(arr);
			var i:uint = arr.length - 1;
			for(;i>=0;i--)
			{
				devSum += Math.abs(arr[i]-mean);
			}
			return devSum /arr.length;
		}
		// median  deviation (median  absolute deviation ) of arration 
		protected  function meddev(arr:Array):Number
		{
			var devSum:Number=0;
			var median:Number = this.median(arr);
			var i:uint = arr.length  -1;
			for(;i>=0;i--){
				devSum +=Math.abs(arr[i] - median);
				
			}
			return devSum / arr.length;
		}
		// coefficient of variation
		protected  function coeffvar(arr:Array):Number
		{
			  return this.stdev(arr)/ this.mean(arr);
		}
		
		// quartiles of an array
		protected  function quartiles(arr:Array):Array
		{
			var arrlen:uint = arr.length;
			var _arr:Array = arr.slice().sort(ascNum);
			return [
					_arr[Math.round((arrlen) / 4) - 1],
					_arr[Math.round((arrlen) / 2) - 1],
					_arr[Math.round((arrlen) * 3 / 4) - 1]
					];
		}
		
		// covariance of two arrays
		protected  function covariance(arr1:Array, arr2:Array):Number
		{
			var u:Number = this.mean(arr1);
			var v:Number = this.mean(arr2);
			var arr1Len:uint = arr1.length;
			var seq_dev:Array = new Array(arr1Len);
			var i:uint=0;
			for(;i<arr1.length; i++){
				seq_dev[i] = ( arr1[i] - u) * ( arr2[i]-v);
														 
			}
			return this.sum(seq_dev)/(arr1Len -1);
		}
		// population  correlation coefficietnt
		protected  function corrcoeff(arr1:Array, arr2:Array):Number
		{
			return this.covariance(arr1, arr2) /this.stdev(arr1, true)/ this.stdev(arr2, true);
		}
		
		
		
		//================  EXTENDING  STATIC ASStat methods =============================
		public static function gammaln(x:*):*
		{
			var j:uint=0;
			var cof:Array = [
				76.18009172947146, -86.50532032941677, 24.01409824083091,
				-1.231739572450155, 0.1208650973866179e-2, -0.5395239384953e-5
			];
			var ser:Number = 1.000000000190015;
			var xx:Number;
			var y:Number;
			var tmp:Number;
			
			tmp = (y = xx = x) + 5.5;
			tmp -= (xx + 0.5) * Math.log(tmp);
			for (; j < 6; j++) ser += cof[j] / ++y;
			return Math.log(2.5066282746310005 * ser / xx) - tmp;
		}
		
		
		// gamma of x
		public static function gammafn(x:Number) {
			var p:Array = [
					-1.716185138865495, 24.76565080557592, -379.80425647094563,
					629.3311553128184, 866.9662027904133, -31451.272968848367,
					-36144.413418691176, 66456.14382024054
				];
				var q:Array = [
					-30.8402300119739, 315.35062697960416, -1015.1563674902192,
					-3107.771671572311, 22538.118420980151, 4755.8462775278811,
					-134659.9598649693, -115132.2596755535
				];
				var fact:Number = Number(false);
				var n:Number = 0;
				var xden:Number = 0;
				var xnum:Number = 0;
				var y:Number = x;
				var i:Number;
				var z:Number;
				var yi:Number;
				var res:Number;
				var sum:Number;
				var ysq:Number;
				if(y <= 0) {
					res = y % 1 + 3.6e-16;
					if (res) {
						fact = (!(y & 1) ? 1 : -1) * Math.PI / Math.sin(Math.PI * res);
						y = 1 - y;
					} else {
						return Infinity;
					}
				}
				yi = y;
				if (y < 1) {
					z = y++;
				} else {
					z = (y -= n = (y | 0) - 1) - 1;
				}
				for (i = 0; i < 8; ++i) {
					xnum = (xnum + p[i]) * z;
					xden = xden * z + q[i];
				}
				res = xnum / xden + 1;
				if (yi < y) {
					res /= yi;
				} else if (yi > y) {
					for (i = 0; i < n; ++i) {
						res *= y;
						y++;
					}
				}
				if (fact) {
					res = fact / res;
				}
				return res;
			}
			
					
					
			// lower incomplete gamma function P(a,x)
			public static function gammap(a:Number, x:Number) {
				var aln:Number = ASStat.gammaln(a);
				var ap:Number = a;
				var sum:Number = 1 / a;
				var del:Number = sum;
				var b:Number = x + 1 - a;
				var c:Number = 1 / 1.0e-30;
				var d:Number = 1 / b;
				var h:Number = d;
				var i:uint = 1;
				
					// calculate maximum number of itterations required for a
					var ITMAX:uint = -~(Math.log((a >= 1) ? a : 1 / a) * 8.5 + a * 0.4 + 17);
					var an:Number;
					var endval:Number;
				if (x < 0 || a <= 0) {
					return NaN;
				} else if (x < a + 1) {
					for (; i <= ITMAX; i++) {
						sum += del *= x / ++ap;
					}
					return sum * Math.exp(-x + a * Math.log(x) - (aln));
				}
				for (; i <= ITMAX; i++) {
					an = -i * (i - a);
					b += 2;
					d = an * d + b;
					c = b + an / c;
					d = 1 / d;
					h *= d * c;
				}
				return 1 - h * Math.exp(-x + a * Math.log(x) - (aln));
			}
			// natural log factorial of n
			public static function factorialln(n:Number):Number {
				return n < 0 ? NaN : ASStat.gammaln(n + 1);
			}
		
			// factorial of n
			public static function factorial(n:Number):Number {
				return n < 0 ? NaN : ASStat.gammafn(n + 1);
			}
			
			
			// combinations of n, m
			public static function combination(n:Number, m:Number):Number {
				// make sure n or m don't exceed the upper limit of usable values
				return (n > 170 || m > 170) ?
					Math.exp(ASStat.combinationln(n, m)) :
				(ASStat.factorial(n) / ASStat.factorial(m)) / ASStat.factorial(n - m);
			}
			
			public static function combinationln(n:Number, m:Number):Number{
				return  ASStat.factorialln(n) - ASStat.factorialln(m) - ASStat.factorialln(n - m);
			}
			
			
			// permutations of n, m
			public static function permutation(n:Number, m:Number):Number {
				return ASStat.factorial(n) / ASStat.factorial(n - m);
			}
			// beta function
			public static function betafn(x:Number, y:Number):Number {
				// ensure arguments are positive
				if (x <= 0 || y <= 0) return undefined;
				// make sure x + y doesn't exceed the upper limit of usable values
				return (x + y > 170) ?
					Math.exp(ASStat.betaln(x, y)) :
				ASStat.gammafn(x) * ASStat.gammafn(y) / ASStat.gammafn(x + y);
			}
			
			// natural logarithm of beta function
			public static function betaln(x:Number, y:Number) {
				return ASStat.gammaln(x) + ASStat.gammaln(y) - ASStat.gammaln(x + y);
			}
			
			
					
			// evaluates the continued fraction for incomplete beta function by modified Lentz's method.
			public static function betacf(x:Number, a:Number, b:Number):Number {
				var fpmin:Number = 1e-30;
				var	m:Number = 1;
				var m2:Number;
				var aa:Number;
				var c:Number;
				var  d:Number;
				var del:Number;
				var h:Number;
				var qab:Number;
				var qam:Number;
				var qap:Number;
				// These q's will be used in factors that occur in the coefficients
				qab = a + b;
				qap = a + 1;
				qam = a - 1;
				c = 1;
				d = 1 - qab * x / qap;
				if(Math.abs(d) < fpmin) d = fpmin;
				d = 1 / d;
				h = d;
				for (; m <= 100; m++) {
					m2 = 2 * m;
					aa = m * (b - m) * x / ((qam + m2) * (a + m2));
					// One step (the even one) of the recurrence
					d = 1 + aa * d;
					if(Math.abs(d) < fpmin) d = fpmin;
					c = 1 + aa / c;
					if(Math.abs(c) < fpmin) c = fpmin;
					d = 1 / d;
					h *= d * c;
					aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2));
					// Next step of the recurrence (the odd one)
					d = 1 + aa * d;
					if(Math.abs(d) < fpmin) d = fpmin;
					c = 1 + aa / c;
					if(Math.abs(c) < fpmin) c = fpmin;
					d = 1 / d;
					del = d * c;
					h *= del;
					if(Math.abs(del - 1.0) < 3e-7) break;
				}
				return h;
			}
			// Returns the inverse incomplte gamma function
			public static function gammapinv (p:Number, a:Number):Number {
				var j:uint = 0;
				var a1:Number = a - 1;
				var	EPS:Number = 1e-8;
				var gln:Number = ASStat.gammaln(a);
				var	x:Number;
				var err:Number;
				var t:Number;
				var  u:Number;
				var pp:Number;
				var lna1:Number;
				var afac:Number;
				if(p >= 1) return Math.max(100, a + 100 * Math.sqrt(a));
				if(p <= 0) return 0;
				if(a > 1) {
					lna1 = Math.log(a1);
					afac = Math.exp(a1 * (lna1 - 1) - gln);
					pp = (p < 0.5) ? p : 1 - p;
					t = Math.sqrt(-2 * Math.log(pp));
					x = (2.30753 + t * 0.27061) / (1 + t * (0.99229 + t * 0.04481)) - t;
					if(p < 0.5) x = -x;
					x = Math.max(1e-3, a * Math.pow(1 - 1 / (9 * a) - x / (3 * Math.sqrt(a)), 3));
				} else {
					t = 1 - a * (0.253 + a * 0.12);
					if(p < t) x = Math.pow(p / t, 1 / a);
					else x = 1 - Math.log(1 - (p - t) / (1 - t));
				}
				for(; j < 12; j++) {
					if(x <= 0) return 0;
					err = ASStat.gammap(a, x) - p;
					if(a > 1) t = afac * Math.exp(-(x - a1) + a1 * (Math.log(x) - lna1));
					else t = Math.exp(-x + a1 * Math.log(x) - gln);
					u = err / t;
					x -= (t = u / (1 - 0.5 * Math.min(1, u * ((a - 1) / x - 1))));
					if(x <= 0) x = 0.5 * (x + t);
					if(Math.abs(t) < EPS * x) break;
				}
				return x;
			}

			// Returns the error function erf(x)
			public static function erf(x:Number):Number {
				var cof:Array = [
						-1.3026537197817094, 6.4196979235649026e-1, 1.9476473204185836e-2,
						-9.561514786808631e-3, -9.46595344482036e-4, 3.66839497852761e-4,
						4.2523324806907e-5, -2.0278578112534e-5, -1.624290004647e-6,
						1.303655835580e-6, 1.5626441722e-8, -8.5238095915e-8,
						6.529054439e-9, 5.059343495e-9, -9.91364156e-10,
						-2.27365122e-10, 9.6467911e-11, 2.394038e-12,
						-6.886027e-12, 8.94487e-13, 3.13092e-13,
						-1.12708e-13, 3.81e-16, 7.106e-15,
						-1.523e-15, -9.4e-17, 1.21e-16,
						-2.8e-17
					];
					var j:uint = cof.length - 1;
					var isneg:Boolean  = false;
					var d:Number = 0;
					var dd:Number = 0;
					var t:Number;
					var ty:Number;
					var tmp:Number;
					var res:Number;
				if(x < 0) {
					x = -x;
					isneg = true;
				}
				t = 2 / (2 + x);
				ty = 4 * t - 2;
				for(; j > 0; j--) {
					tmp = d;
					d = ty * d - dd + cof[j];
					dd = tmp;
				}
				res = t * Math.exp(-x*x + 0.5 * (cof[0] + ty * d) - dd);
				return (isneg) ? res - 1 : 1 - res;
			}
			
			// Returns the complmentary error function erfc(x)
			public static function erfc(x:Number):Number {
				return 1 - ASStat.erf(x);
			}
			
			
			// Returns the inverse of the complementary error function
			public static function erfcinv(p:Number):Number {
				var j:uint = 0;
				var x:Number;
				var err:Number;
				var t:Number;
				var pp:Number;
				if(p >= 2) return -100;
				if(p <= 0) return 100;
				pp = (p < 1) ? p : 2 - p;
				t = Math.sqrt(-2 * Math.log(pp / 2));
				x = -0.70711 * ((2.30753 + t * 0.27061) / (1 + t * (0.99229 + t * 0.04481)) - t);
				for(; j < 2; j++) {
					err = ASStat.erfc(x) - pp;
					x += err / (1.12837916709551257 * Math.exp(-x * x) - x * err);
				}
				return (p < 1) ? x : -x;
			}
			
			
			
			// Returns the inverse of the incomplete beta function
			public static function ibetainv(p:Number, a:Number, b:Number):Number {
				var EPS:Number = 1e-8;
				var a1:Number = a - 1;
				var b1:Number = b - 1;
				var j:uint = 0;
				var lna:Number;
				var lnb:Number;
				var pp:Number;
				var t:Number;
				var u:Number;
				var err:Number;
				var x:Number;
				var al:Number;
				var h:Number;
				var w:Number;
				var afac:Number;
				if(p <= 0) return 0;
				if(p >= 1) return 1;
				if(a >= 1 && b >= 1) {
					pp = (p < 0.5) ? p : 1 - p;
					t = Math.sqrt(-2 * Math.log(pp));
					x = (2.30753 + t * 0.27061) / (1 + t* (0.99229 + t * 0.04481)) - t;
					if(p < 0.5) x = -x;
					al = (x * x - 3) / 6;
					h = 2 / (1 / (2 * a - 1)  + 1 / (2 * b - 1));
					w = (x * Math.sqrt(al + h) / h) - (1 / (2 * b - 1) - 1 / (2 * a - 1)) * (al + 5 / 6 - 2 / (3 * h));
					x = a / (a + b * Math.exp(2 * w));
				} else {
					lna = Math.log(a / (a + b));
					lnb = Math.log(b / (a + b));
					t = Math.exp(a * lna) / a;
					u = Math.exp(b * lnb) / b;
					w = t + u;
					if(p < t / w) x = Math.pow(a * w * p, 1 / a);
					else x = 1 - Math.pow(b * w * (1 - p), 1 / b);
				}
				afac = -ASStat.gammaln(a) - ASStat.gammaln(b) + ASStat.gammaln(a + b);
				for(; j < 10; j++) {
					if(x === 0 || x === 1) return x;
					err = ASStat.ibeta(x, a, b) - p;
					t = Math.exp(a1 * Math.log(x) + b1 * Math.log(1 - x) + afac);
					u = err / t;
					x -= (t = u / (1 - 0.5 * Math.min(1, u * (a1 / x - b1 / (1 - x)))));
					if(x <= 0) x = 0.5 * (x + t);
					if(x >= 1) x = 0.5 * (x + t + 1);
					if(Math.abs(t) < EPS * x && j > 0) break;
				}
				return x;
			}

			
					
			// Returns the incomplete beta function I_x(a,b)
			public  static function ibeta(x:Number, a:Number, b:Number):Number {
				// Factors in front of the continued fraction.
				var bt:Number = (x === 0 || x === 1) ?  0 :
					Math.exp(ASStat.gammaln(a + b) - ASStat.gammaln(a) -
					ASStat.gammaln(b) + a * Math.log(x) + b *
					Math.log(1 - x));
				if(x < 0 || x > 1) return Number(false);
				if(x < (a + 1) / (a + b + 2))
					// Use continued fraction directly.
					return bt * ASStat.betacf(x, a, b) / a;
				// else use continued fraction after making the symmetry transformation.
				return 1 - bt * ASStat.betacf(1 - x, b, a) / b;
			}
			
			
			// Returns a normal deviate (mu=0, sigma=1).
			// If n and m are specified it returns a object of normal deviates.
			public static function randn(n:Number=NaN, m:Number=NaN):Number {
				var u:Number;
				var v:Number;
				var x:Number;
				var y:Number;
				var q:Number;
				var mat:Number;
				if (!m) m = n;
				if(n) {
					return ASStat.create(n, m, function() { return ASStat.randn(); });
				}
				do {
					u = Math.random();
					v = 1.7156 * (Math.random() - 0.5);
					x = u - 0.449871;
					y = Math.abs(v) + 0.386595;
					q = x*x + y * (0.19600 * y - 0.25472 * x);
				} while(q > 0.27597 && (q > 0.27846 || v*v > -4 * Math.log(u) * u*u));
				return v / u;
			}
			
			// Returns a gamma deviate by the method of Marsaglia and Tsang.
			public static function randg(shape:Number=NaN, n:Number=NaN, m:Number=NaN):* {
				var oalph:Number = shape;
				var a1:Number;
				var a2:Number;
				var u:Number;
				var v:Number;
				var x:Number;
				var mat:ASStat;
				
				if (!m) m = n;
				if (!shape) shape = 1;
				if(n) {
					mat = ASStat.zeros(n,m);
					mat.alter(function() { return ASStat.randg(shape); });
					return mat;
				}
				if(shape < 1) shape += 1;
				a1 = shape - 1 / 3;
				a2 = 1 / Math.sqrt(9 * a1);
				do {
					do {
						x = ASStat.randn();
						v = 1 + a2 * x;
					} while(v <= 0);
					v = v * v * v;
					u = Math.random();
				} while(u > 1 - 0.331 * Math.pow(x, 4) &&
					Math.log(u) > 0.5 * x*x + a1 * (1 - v + Math.log(v)));
				// alpha > 1
				if(shape == oalph) return a1 * v;
				// alpha < 1
				do { u = Math.random(); } while(u === 0);
				return Math.pow(u, 1 / oalph) * a1 * v;
			}
			  //  
		   private function gamaInstanceMethods(name:*, pam1:*=null, pam2:*=null ):*
		   {
			   return ASStat.map(_array[0], function(val:*):* { return ASStat[String(name)](val);});
			
			   
			   
			   
			   
		   }
		   private function randn(name:*, arg:*):*{
			   return ASStat[String(name)].apply(null, arg);
		
		   }
		   
		   // // generate all distribution instance methods
		   
		   private function generalDistribution(name:*, rest:*):*
		   {
			    
				     /*var myClass:Class = getDefinitionByName(String(name)) as Class;
					 if(!(ASStat[String(name)] is myClass)) {
						
						 ASStat[String(name)] = new myClass(rest[0], rest[1], rest[2]);
						 return;
						 
					 };*/
			         // distribution method to be used on a ASStat instance
					
					 var newthis:Distributions = ASStat[ String(name) ].apply(null, rest);
					 newthis.data = this;
					 return newthis;
					
				   
		   }
		   
		   
		   
	   }

}   

	
	

