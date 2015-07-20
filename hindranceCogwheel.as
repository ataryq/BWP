package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;

	public class hindranceCogwheel extends enemyBat {
		private const bodyR:Number = 60;
		public function hindranceCogwheel(_world:CreateWorld, _loc:b2Vec2) {
			// constructor code
			super(_world, _loc);
		}
		
		protected override function init():void
		{
			body = world.createDynamicCircle(loc.x, loc.y, bodyR, 0, 1, 0, b2Body.b2_kinematicBody);
			var enemy:Cogwheel = new Cogwheel(body);
			behaviour = new Behaviours(body, b2Vec2.Make(enemy.speed, enemy.speed));
			addChild(enemy);
		}
		
		override protected function Update(event:Event):void
		{
			
		}
	}
	
}
