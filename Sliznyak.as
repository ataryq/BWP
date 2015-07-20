package  {
	import flash.display.Sprite;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Sliznyak extends baseEnemy 
	{
		public static const GREEN:Number = 1;
		public static const PINK:Number = 2;
		public static const BLUE:Number = 3;
		
		public function Sliznyak(_body:b2Body,
								 _color:Number = GREEN) 
		{
			// constructor code
			switch(_color)
			{
				case GREEN: this.sprite = new spriteSliznyakGrin(); break;
				case PINK: this.sprite = new spriteSliznyakPink(); break;
				case BLUE: this.sprite = new spriteSliznyakBlue(); break;
			}
			this.name = "sliznyak";
			_body.GetFixtureList().GetUserData().name = "sliznyak";
			super(_body);
			this.sprite.SetAnim(baseAnimationEnemy.IDLE_LEFT);
		}
	
	}
}