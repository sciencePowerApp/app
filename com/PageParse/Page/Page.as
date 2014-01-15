package com.PageParse.Page
{
	import com.PageParse.Page.Elements.Row;

	public class Page
	{
		public var tokenisedRows:Vector.<Row> = new Vector.<Row>;
			
		public function add(row:Row):void{
			tokenisedRows.push(row);
		}
	}
}