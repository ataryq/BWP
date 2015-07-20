package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	public class behaviurOvercomingJump {
		protected var numFrameWaiting:Number;
		protected var originalForceJump:Number;
		protected var deltaForceJump:Number;
		protected var body:b2Body;
		protected var enemy:enemyBat;
		protected var currentFrameWaiting:Number;
											   
		public function behaviurOvercomingJump(_body:b2Body, 
											   _originalForceJump:Number = -50,
											   _deltaForceJump:Number = -10,
											   _numFrameWaiting:Number = 10)
		{
			// constructor code
			body = _body;
			originalForceJump = _originalForceJump;
			deltaForceJump = _deltaForceJump;
			numFrameWaiting = _numFrameWaiting;
			enemy = (body.GetUserData().reference) as enemyBat;
			
		}
		
		public function Update():void
		{
			Jump();
		}
		
		protected function Jump():void
		{
			//trace(enemy.originalSpeed.x + " " + enemy.settingSpeed.x);
			if(Math.abs(enemy.originalSpeed.x) < 1 && Math.abs(enemy.settingSpeed.x) > 1)
			{
				//trace("true");
				if(currentFrameWaiting % numFrameWaiting == 0) {
					body.ApplyImpulse(new b2Vec2(0, currentFrameWaiting * deltaForceJump / numFrameWaiting + originalForceJump),
								 	  body.GetWorldCenter());
				}
				currentFrameWaiting++;
			}
			else {
				//trace("false");
				currentFrameWaiting = 0;
			}
		}
	}
}
