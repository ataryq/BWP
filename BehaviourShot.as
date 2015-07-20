package  {
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	
	public class BehaviourShot extends MovieClip {
		protected var impulsBullet:b2Vec2;
		protected var world:CreateWorld;
		protected var body:b2Body;
		protected var frameWaiting:Number;
		protected var curFrame:Number = 0;
		protected var sprite:spriteBulletMiniGun;
		
		private const radiusBullet:Number = 5;
		
		public function BehaviourShot(_world:CreateWorld,
									  _body:b2Body,
									  _impulsBullet:b2Vec2, 
									  _frameWaiting:Number = 15) {
			// constructor code
			world = _world;
			body = _body;
			impulsBullet = _impulsBullet;
			frameWaiting = _frameWaiting;
		}
		
		public function Delete():void
		{
			this.parent.removeChild(this);
			trace("delete");
		}
		
		public function Update():void
		{
			curFrame++;
			var curImpuls:b2Vec2;
			if(curFrame % frameWaiting != 0) return; 
			var bodyBullet:b2Body = this.world.createDynamicCircle(body.GetWorldCenter().x * CreateWorld.SCALE,
																   body.GetWorldCenter().y * CreateWorld.SCALE,
																   radiusBullet);
			bodyBullet.GetUserData().bullet = true;
			bodyBullet.GetUserData().type = "hindrance";
			bodyBullet.SetBullet(true);
			sprite = new spriteBulletMiniGun();
			bodyBullet.GetUserData().sprite = sprite;
			addChild(sprite); 
			bodyBullet.GetUserData().reference = sprite;
			bodyBullet.ApplyImpulse(new b2Vec2(impulsBullet.x * Math.cos(body.GetAngle()),
											   impulsBullet.y * Math.sin(body.GetAngle())),
											   bodyBullet.GetWorldCenter());
		}
	}
}
