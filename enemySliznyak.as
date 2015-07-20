package  {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	
	public class enemySliznyak extends enemyBat
	{
		private var color:Number;
		private var leftBor:Number;
		private var rightBor:Number;
		
		private const h:Number = 24;
		private const w:Number = 56;
		
		public function enemySliznyak(_world:CreateWorld, 
									  _loc:b2Vec2,
									  _leftBor:Number,
									  _rightBor:Number,
									  _color:Number = 1) 
		{
			// constructor code
			color = _color;
			leftBor = _leftBor;
			rightBor = _rightBor;
			super(_world, _loc);
		}
		
		protected override function init():void
		{
			body = world.createDynamicBox(loc.x, loc.y, w, h, 1, 0);
			enemy = new Sliznyak(body, color);
			body.GetUserData().reference = this;
			behaviour = new Behaviours(body, b2Vec2.Make(enemy.speed, 0));
			addBehaviour();
			addChild(enemy);
		}
		
		private function addBehaviour():void
		{
			behaviour.AddMoveOnLine(b2Vec2.Make(leftBor, 0), b2Vec2.Make(rightBor, 0));
		}
		
		protected override function Update_two():void
		{
			if(this.enemy.sprite.GetAnim() == baseAnimationEnemy.DIE_LEFT ||
			   this.enemy.sprite.GetAnim() == baseAnimationEnemy.DIE_RIGHT) return
			if(this.body.GetLinearVelocity().x > 0.1)  this.enemy.sprite.SetAnim(baseAnimationEnemy.MOVE_RIGHT);
			else if(this.body.GetLinearVelocity().x < 0.1)  this.enemy.sprite.SetAnim(baseAnimationEnemy.MOVE_LEFT);
			else this.enemy.sprite.SetAnimIndleRootInLasdDir();
		}

	}
}
