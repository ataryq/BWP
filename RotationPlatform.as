package 
{
	import flash.display.Sprite;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.geom.Point;
	import flash.events.Event;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2DistanceJoint;

	public class RotationPlatform extends Sprite
	{
		protected var loc:Point;
		protected var scale:Number;
		
		public function RotationPlatform(_loc:Point, _scale:Number = 1)
		{
			// constructor code
			scale = _scale;
			loc = _loc;
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event):void
		{
			trace("ratPlat");
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			var createWorld:CreateWorld = informBlockListPlatform.GetInformBlock(stage).createWorld;
			var _bodyA:b2Body = createWorld.createStaticBox(loc.x - (62 * scale), loc.y - (20 * scale), 138 * scale, 30);
			var _bodyB:b2Body = createWorld.createDynamicBox(loc.x, loc.y + 20 * scale, 210 * scale, 30, 1, 1, 0.2);
			_bodyB.SetSleepingAllowed(false);
			var _join:b2DistanceJoint;
			var _jointDef:b2DistanceJointDef = new b2DistanceJointDef();
			_jointDef.bodyA = _bodyA; //первое тело соединения
			_jointDef.bodyB = _bodyB; //второе тело соединения
			_jointDef.localAnchorA = new b2Vec2(0, 1); //якорная точка первого тела
			_jointDef.localAnchorB = new b2Vec2(0, -1); //якорная точка второго тела
			_jointDef.length = 9 * scale; //длина соединения
			_jointDef.collideConnected = true; //тела могут сталкиваться
			createWorld.world.CreateJoint(_jointDef); //создаем и добавляем соединение в мир
			
			var spriteA:Sprite = new SpriteRotatePlatfor_static();
			spriteA.width *= scale;
			addChild(spriteA);
			_bodyA.GetUserData().sprite = spriteA;
			spriteA.x = _bodyA.GetWorldCenter().x * CreateWorld.SCALE;
			spriteA.y = _bodyA.GetWorldCenter().y * CreateWorld.SCALE;
			var spriteB:Sprite = new SpriteRotatePlatfor_dynamic();
			addChild(spriteB);
			spriteB.width *= scale;
			_bodyB.GetUserData().sprite = spriteB;
			_bodyB.SetFixedRotation(true);
		}
	}

}