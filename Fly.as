
package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;

	public class Fly extends baseEnemy {

		public function Fly(_body:b2Body) {
			// constructor code
			this.name = "Fly";
			this.sprite = new spriteFly();
			super(_body);
			this.sprite.SetAnim(baseAnimationEnemy.MOVE_LEFT);
		}
		
		protected override function Move():void
		{
			body.ApplyForce(new b2Vec2(0, -40 * body.GetMass()), body.GetWorldCenter());
		}
	}
	
}
