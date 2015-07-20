package  {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.motion.easing.Back;
	
	public class enemyBat extends MovieClip{
		protected var world:CreateWorld;
		protected var loc:b2Vec2;
		protected var body:b2Body;
		protected var behaviour:Behaviours;
		protected var enemy:baseEnemy;
		public var originalSpeed:b2Vec2;
		public var settingSpeed:b2Vec2;
		
		private const minRadius:b2Vec2 = b2Vec2.Make(5, 5);
		private const maxRadius:b2Vec2 = b2Vec2.Make(300, 300);
		private const bodyR:Number = 40;
		
		public function enemyBat(_world:CreateWorld, _loc:b2Vec2) 
		{
			// constructor code
			loc = _loc;
			this.world = _world;
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			world = informBlockListPlatform.GetInformBlock(stage).createWorld;
			init();
			this.originalSpeed = this.body.GetLinearVelocity().Copy();
			this.settingSpeed = this.body.GetLinearVelocity().Copy();
			this.addEventListener(Event.ENTER_FRAME, Update);
		}
		
		protected function init():void
		{
			body = world.createDynamicCircle(loc.x, loc.y, bodyR, 0, 10, 0);
			enemy = new Bat(body);
			body.GetUserData().reference = this;
			behaviour = new Behaviours(body, b2Vec2.Make(enemy.speed, enemy.speed / 2));
			addChild(behaviour);
			addBehaviour();
			addChild(enemy);
		}
		
		protected const time:Number = 2000;
		protected var timer:Timer = new Timer(time, 1);
		public function Die():void
		{
			if(this.contains(behaviour)) this.removeChild(behaviour);
			behaviour.Stop();
			this.enemy.Die_Base_Enemy();
			this.removeEventListener(Event.ENTER_FRAME, Update);
			this.timer.addEventListener(TimerEvent.TIMER, RemoveScene);
		}
		
		public function RemoveScene(event:Event):void
		{
			if(this.parent) 
				if(this.parent.contains(this))
					this.parent.removeChild(this);
		}
				
		private function addBehaviour():void
		{
			var info:informBlockListPlatform = informBlockListPlatform.GetInformBlock(stage);			
			behaviour.AddGotoPlayer(maxRadius,
									minRadius, 
									info.player);
									
		}
		
		protected function Update_two():void
		{
			
		}
		
		protected function Update(event:Event):void
		{
			Update_two();
			this.originalSpeed = this.body.GetLinearVelocity().Copy();
			if(behaviour) behaviour.Update();
			this.settingSpeed = this.body.GetLinearVelocity().Copy();
		}
		
	}
}
