package com.PageParse.Page.Elements
{
	import com.PageParse.Page.Elements.Primitives.AbstractPermute;
	import com.PageParse.Page.Elements.Primitives.Statistic;

	public class Stats extends Maths
	{
		
		
		public function Stats(){
			super();
		}
		
		
		override protected function calcCommand():AbstractPermute{
			return new Statistic(formula,inputRequests,resultF);
		}
	}
	
	
}