package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	
	
	public class bulletSmall extends MovieClip {
		protected const forceBull:Number = 10;
		protected var circle:b2Body;
		
		public function bulletSmall(_circle:b2Body,
									_angle:Number,
									_side:Boolean) 
		{
			// constructor code
			this.name = "bulletSmall";
			var angle:Number = _angle;
			circle = _circle;
			_circle.GetUserData().name = "bulletSmall";
			_circle.GetUserData().bullet = true;
			_circle.GetUserData().sprite = this;
			_circle.GetUserData().reference = this;
			_circle.SetBullet(true);
			var cos:Number = Math.cos(angle / 180 * Math.PI);
			var sin:Number = Math.sin(angle / 180 * Math.PI);
			
			if(_side)
				_circle.ApplyImpulse(b2Vec2.Make(forceBull * cos, 
												 forceBull * sin), _circle.GetWorldCenter());
			else _circle.ApplyImpulse(b2Vec2.Make(-forceBull * cos, 
												 forceBull * sin), _circle.GetWorldCenter());
		}
		
		public function Delete():void
		{
			this.parent.removeChild(this);
		}
	}
	
}
