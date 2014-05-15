package com.AS3Stat.test
{
   import com.AS3Stat.*;
	public class assert
	{

		public static function deepEqual(ls:*, rs:*):Boolean
		{
			var rval:Boolean = true;
			 if( ls is ASStat){
			   //trace("  ls .... array is custing ...");
			   ls = ASStat(ls).array;
		     }
			  if( rs is ASStat){
			  // trace("   rs.... array is custing ...");
			   rs = ASStat(rs).array;
		     }
			// checks if type matches
			if (typeof ls != typeof rs)
			{
				
				return false;
			}
			
			switch (typeof ls)
			{
				
				case "object" :
					// if both are objects checks if proerty lengts are equal
					if (objectPropLength(ls)!=objectPropLength(rs))
					{
						rval = false;
						break;
					}
					// checks he property values in Object
					for (var s:* in ls)
					{

						if (! assert.deepEqual(ls[s],rs[s]))
						{

							rval = false;
							break;
						}

					}



					break;
				case "number" :
				case "boolean" :
				// number and boolean are checked or equality
					if (ls != rs)
					{
						rval = false;
					}
					break;
			}
			return rval;
		}



		public static function objectPropLength(obj:Object):int
		{
          
			var cnt:int = 0; 
			for (var s:* in obj)
			{

				cnt++;
				
			}
			return cnt;
		}
	}

}