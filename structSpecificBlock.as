package  {
	import flash.geom.Point;
	
	public class structSpecificBlock {
		public var loc:Point;
		public var h:Number;
		public var w:Number;
		public var angle:Number;
		public var funct:Function;
		
		public function structSpecificBlock(_w:Number,
											_h:Number,
											_loc:Point,
											_funct:Function,
											_angle:Number = 0
											) 
		{
			// constructor code
			h = _h;
			w = _w;
			loc = _loc;
			angle = _angle;
			funct = _funct;
		}

	}
	
}
