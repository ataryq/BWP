package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	public class Spider extends baseEnemy{

		public function Spider(_body:b2Body) {
			// constructor code
			this.name = "Spider";
			this.sprite = new spriteSpider();
			super(_body);
			this.sprite.SetAnim(baseAnimationEnemy.MOVE_LEFT);
		}
		
	}
}
