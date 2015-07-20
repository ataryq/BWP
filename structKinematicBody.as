package  {
	import flash.geom.Point;
	
	public class structKinematicBody {
		var loc:Point; 
		var h:Number; 
		var w:Number;
		var angle:Number;
		var density:Number;
		var friction:Number;
		var target;
		
		public function structKinematicBody(_loc:Point,
											_height:Number, 
											_width:Number,
											_angle:Number = 0.0,
											_density:Number = 1.0,
											_friction:Number = 1.0,
											_targer = null) 
		{
			// constructor code
			loc = _loc;
			h = _height;
			w = _width;
			angle = _angle;
			density = _density;
			friction = _friction;
			target = _targer;
		}

	}
	
}
