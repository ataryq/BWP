package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	
	public class baseEnemy extends MovieClip{
		protected var body:b2Body;
		public var sprite:baseAnimationEnemy;
		
		public function baseEnemy(_body) 
		{
			// constructor code
			body = _body;
			body.GetUserData().enemy = true;
			body.GetUserData().reference = this;
			body.SetFixedRotation(true);
			body.SetSleepingAllowed(false);
			addSprite();
			if(stage) addStage(null);
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event):void 
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			this.addEventListener(Event.ENTER_FRAME, Update);			
		}
				
		protected function addSprite():void 
		{
			if(sprite == null) {
				trace("error add sprite baseEnemy");
				return;
			}
			sprite.x = - (sprite.width / 2);
			sprite.y = - (sprite.height / 2);
			addChild(sprite);
			
			var _userData:Object = body.GetUserData();
			_userData.sprite = sprite;
			_userData.name = this.name;
			_userData.reference = this;
		}
		
		protected var originalSpeed:Number = 3;
		protected var originalForceJump:Number = 30;
		public var speed:Number = 3;
		public var forceJump:Number = 30;
		
		public function GetSprite():baseAnimationEnemy {
			return this.sprite;
		}
		
		protected function Move():void 
		{
			
		}
		
		protected function Update(event:Event):void 
		{
			Move();
			if(!body.GetUserData().setAnimForHor) return;
			var curSpeed:Number = this.body.GetLinearVelocity().x;
			if(Math.abs(curSpeed) < 0.2) {
				if(this.sprite.lastDir) this.sprite.SetAnim(baseAnimationEnemy.IDLE_RIGHT);
				else this.sprite.SetAnim(baseAnimationEnemy.IDLE_LEFT);
			} else if(this.sprite.GetAnim() != baseAnimationEnemy.DIE_LEFT || 
					  this.sprite.GetAnim() != baseAnimationEnemy.DIE_RIGHT) {
						  if(curSpeed > 1) this.sprite.SetAnim(baseAnimationEnemy.MOVE_RIGHT);
						  else this.sprite.SetAnim(baseAnimationEnemy.MOVE_RIGHT);
					  }
		}
		
		public function Die_Base_Enemy():void
		{
			if(this.sprite.GetAnim() == baseAnimationEnemy.IDLE_LEFT ||
			  this.sprite.GetAnim() == baseAnimationEnemy.MOVE_LEFT) {
				  this.sprite.SetAnim(baseAnimationEnemy.DIE_LEFT);
			  } else {
				   this.sprite.SetAnim(baseAnimationEnemy.DIE_RIGHT);
			  }
			  sprite.playAnimation(null);
			  this.sprite.DeleteBaseAnimEnemy();	
			  this.body.GetFixtureList().SetSensor(true);
			  this.removeEventListener(Event.ENTER_FRAME, Update);		
		}
		
	}
}
