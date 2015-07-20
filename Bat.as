package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	
	public class Bat extends baseEnemy {

		public function Bat(_body:b2Body) {
			// constructor code
			this.name = "bat";
			this.sprite = new spriteBat();
			super(_body);
			_body.GetFixtureList().GetUserData().name = "bat";
			this.sprite.SetAnim(baseAnimationEnemy.IDLE_LEFT);
		}
		
		protected override function Move():void
		{
			body.ApplyForce(new b2Vec2(0, -40 * body.GetMass()), body.GetWorldCenter());
		}
		
		public function Die_Bat():void
		{
			Die_Base_Enemy();
		}
	}
}
