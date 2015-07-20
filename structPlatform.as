package  {
	import flash.geom.Point;
	
	public class structPlatform {
		public var loc:Point;
		public var h:Number;
		public var w:Number;
		public var angle:Number;
		public var density:Number;
		public var Name:String;
		public var isSensor:Boolean;
		public var friction:Number;
		public var reference;
		
		public function structPlatform(_w:Number,
									   _h:Number,
									   _loc:Point,
									   _angle:Number = 0,
									   _density:Number = 1,
									   _friction:Number = 0.1,
									   _isSensor:Boolean = false,
									   _Name:String = null,
									   _reference = null) {
			// constructor code
			h = _h;
			w = _w;
			loc = _loc;
			angle = _angle;
			density = _density;
			Name = _Name;
			isSensor = _isSensor;
			this.friction = _friction;
			reference = _reference;
		}
	}
	
}

