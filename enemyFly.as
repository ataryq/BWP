package  {
	import Box2D.Common.Math.b2Vec2;
	
	public class enemyFly extends enemyBat {
		private const bodyR:Number = 40;
		private const minRadius:b2Vec2 = b2Vec2.Make(70, 70);
		private const maxRadius:b2Vec2 = b2Vec2.Make(300, 300);
		
		public function enemyFly(_world:CreateWorld, _loc:b2Vec2) {
			// constructor code
			super(_world, _loc);
		}
		
		protected override function init():void
		{
			body = world.createDynamicCircle(loc.x, loc.y, bodyR);
			enemy = new Fly(body);
			body.GetUserData().reference = this;
			behaviour = new Behaviours(body, b2Vec2.Make(enemy.speed, enemy.speed));
			addBehaviour();
			addChild(enemy);
		}
		
		private function addBehaviour():void
		{
			var info:informBlockListPlatform = informBlockListPlatform.GetInformBlock(stage);			
			behaviour.AddGotoPlayer(maxRadius,
									minRadius, 
									info.player);
		}
	}
	
}
