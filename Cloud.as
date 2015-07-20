package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Cloud extends MovieClip 
	{
		public var speed:Number;
		public static var baseSpeed:Number = 0.3;
		public static var radiusSpeed:Number = 0.5;
		public static var radiusStartY:Number = 200;
		
		public function Cloud() 
		{
			// constructor code
			var rand:Number = Math.random() * 5 / 10 + 0.5;
			//trace(rand);
			this.scaleX = rand;
			this.scaleY = rand;
			
			this.y -= Math.random() * radiusStartY;
			
			speed = Math.random() * radiusSpeed + baseSpeed;
		}
		
		public function Update(event:Event = null):void
		{
			this.x += speed;
			if(this.x > 4000) 
			{
				this.x = -100;
			}
		}
		
	}
}
