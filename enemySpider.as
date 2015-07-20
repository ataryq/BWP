package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	public class enemySpider extends enemyBat {

		public function enemySpider(_world:CreateWorld, _loc:b2Vec2) {
			// constructor code
			super(_world, _loc);
		}
		
		protected override function init():void
		{
			body = world.createDynamicCircle(loc.x, loc.y, 40, 0, 4);
			enemy = new Spider(body);
			enemy.GetSprite().scaleX = 0.5;
			enemy.GetSprite().scaleY = 0.5;
			enemy.speed = 8;
			body.GetUserData().reference = this;
			body.GetUserData().setAnimForHor = true;
			behaviour = new Behaviours(body, b2Vec2.Make(enemy.speed, 0));
			addBehaviour();
			addChild(enemy);
		}
				
		private function addBehaviour():void
		{
			//behaviour.AddMoveOnLine(200, 400);
			behaviour.AddGotoPlayer(new b2Vec2(300, 300), new b2Vec2(100, 100), informBlockListPlatform.GetInformBlock(stage).player);
			behaviour.AddOvercomingJump(-40, -20, 45);
		}
	}
	
}
