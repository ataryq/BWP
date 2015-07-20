package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class BehaviourGotoPlayer {
		
		protected var body:b2Body;
		protected var speedX:Number;
		protected var speedVec:b2Vec2;
		protected var sprite:baseAnimationEnemy;
		
		private var maxDistP:b2Vec2;
		private var minDinsP:b2Vec2;
		private var player:Player;
							
		public function BehaviourGotoPlayer(_maxDistP:b2Vec2,
										_body:b2Body,
										_speedVec:b2Vec2,
										_player:Player,
									  _minDinsP:b2Vec2 = null):void
		{
			body = _body;
			speedVec = _speedVec;
			speedX = speedVec.x;
			sprite = body.GetUserData().sprite as baseAnimationEnemy;
			maxDistP = _maxDistP;
			if(!_minDinsP) minDinsP = b2Vec2.Make(0, 0);
			else minDinsP = _minDinsP;
			player = _player;
			if(body.GetWorldCenter().x <= player.GetWorldPosition().x) sprite.SetAnim(baseAnimationEnemy.MOVE_RIGHT);
			else sprite.SetAnim(baseAnimationEnemy.MOVE_LEFT);
		}
		
		public function Update():void
		{
			gotoPlayer();
		}
		
		protected var rNeabodyP:Number = 16;
		
		protected function gotoPlayer():void
		{
			var difX:Number = body.GetWorldCenter().x - player.GetWorldPosition().x;
			var difY:Number = body.GetWorldCenter().y - player.GetWorldPosition().y;
			if(difX > maxDistP.x / CreateWorld.SCALE || difY > maxDistP.y / CreateWorld.SCALE ||
			    (Math.abs(difX) < minDinsP.x / CreateWorld.SCALE && Math.abs(difY) < minDinsP.y / CreateWorld.SCALE)) {
				   body.GetLinearVelocity().x *= 0.8;
				   body.GetLinearVelocity().y *= 0.8;
				   return;
			   }
			
			body.SetActive(true);
			
			if(difX < -rNeabodyP / CreateWorld.SCALE) {
				sprite.SetAnim(baseAnimationEnemy.MOVE_RIGHT);
				body.GetLinearVelocity().x = speedVec.x;
			}
			else if(difX > rNeabodyP / CreateWorld.SCALE){
				sprite.SetAnim(baseAnimationEnemy.MOVE_LEFT);
				body.GetLinearVelocity().x = -speedVec.x;
			}
			else body.GetLinearVelocity().x *= 0.8;
			
			if(speedVec.y != 0) {
				if(difY < -rNeabodyP / CreateWorld.SCALE) body.GetLinearVelocity().y = speedVec.y;
				else if(difY > rNeabodyP / CreateWorld.SCALE) body.GetLinearVelocity().y = -speedVec.y;
				else body.GetLinearVelocity().y *= 0.8;
			}
		}
	}
	
}
