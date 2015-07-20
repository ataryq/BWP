package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class BehaviourMoveOnLine {

		protected var body:b2Body;
		protected var speedX:Number;
		protected var speedY:Number;
		protected var speedVec:b2Vec2;
		
		public function BehaviourMoveOnLine(_wayLeftBorder:b2Vec2,
									  _wayRightBorder:b2Vec2,
									  _body:b2Body,
									  _speedVec:b2Vec2)
		{
			body = _body;
			speedVec = _speedVec;
			speedX = speedVec.x;
			speedY = speedVec.y;
			
			wayLeftBorder = _wayLeftBorder;
			wayRightBorder = _wayRightBorder;
		}
				
		private var wayLeftBorder:b2Vec2;
		private var wayRightBorder:b2Vec2;
		private var dirMoveX:Boolean = false;
		private var dirMoveY:Boolean = false;
		
		public function Update():void
		{
			if(speedVec.y != 0) moveOnLineY();
			if(speedVec.x != 0) moveOnLineX();
		}
		
		protected function moveOnLineX():void
		{
			if(body.GetWorldCenter().x > wayRightBorder.x / CreateWorld.SCALE) dirMoveX = false;
			else if(body.GetWorldCenter().x < wayLeftBorder.x / CreateWorld.SCALE ) dirMoveX = true;
			if(dirMoveX) {
				body.GetLinearVelocity().x = speedX;
			}
			else {
				body.GetLinearVelocity().x = -speedX;
			}
		}
		
		protected function moveOnLineY():void
		{
			if(body.GetWorldCenter().y > wayRightBorder.y / CreateWorld.SCALE) dirMoveY = false;
			else if(body.GetWorldCenter().y < wayLeftBorder.y / CreateWorld.SCALE ) dirMoveY = true;
			if(dirMoveY) {
				body.GetLinearVelocity().y = speedY;
			}
			else {
				body.GetLinearVelocity().y = -speedY;
			}
		}
	}
	
}
