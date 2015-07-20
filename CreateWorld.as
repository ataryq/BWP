package  {
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2DebugDraw;
	import flash.display.Sprite;
	import flash.events.Event;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import Box2D.Collision.b2AABB;
	import flash.ui.*;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	public class CreateWorld extends Sprite{
		public var world:b2World;
		private var locationRightBorder:Number;
		private var locationBottomBorder:Number;
		public static var SCALE:Number = 30;
		private var isActiveDebugDraw:Boolean = false;
		public static var forceAttrcting:Number = 40;
		protected var listSpecificBlock:Array = null;
		protected var recInformBlock:informBlockListPlatform;
		public var timeStep:Number = 1 / 40;
		public static const BASE_TIME_STEP:Number = 1 / 40;
		
		public function CreateWorld(_locationRightBorder:Number,
									_locationBottomBorder:Number) 
		{
			// constructor code
			locationRightBorder = _locationRightBorder;
			locationBottomBorder = _locationBottomBorder;
			
			world = new b2World(new b2Vec2(0, forceAttrcting), true);
			createWalls();
			name = "CreateWorld";
			if(stage) addStage(null);
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event) {
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			recInformBlock = informBlockListPlatform.GetInformBlock(stage);
			recInformBlock.world = this.world;
			recInformBlock.createWorld = this;  
			createInformBlocks();
		}
		
		public function Delete():void
		{
			for (var bodiesList:b2Body = world.GetBodyList(); bodiesList; bodiesList = bodiesList.GetNext()) 
			{
				
			}
		}
		
		protected function createInformBlocks():void 
		{
			if(!recInformBlock) return;
			if(recInformBlock.listStaticSolidPlatform.length == 0) return;
			var list:Array = recInformBlock.listStaticSolidPlatform;
			
			var _body:b2Body;
			var _loc:Point;
			var _w:Number = list[i].w;
			var _h:Number = list[i].h;
			var _angle:Number = list[i].angle;
			var _density:Number = list[i].density;
			var _friction:Number;
			var isSensor:Boolean;
			var _target;
			
			for(var i:uint = 0; i < list.length; i++) 
			{
				_w = list[i].w;
				_h = list[i].h;
				_angle = list[i].angle;
				_density = list[i].density;
				_body = createStaticBox(list[i].loc.x - _w / 2, list[i].loc.y - _h / 2, _w, _h, _angle, _density, list[i].friction);
				if(list[i].isSensor) _body.GetFixtureList().SetSensor(true);
				_body.GetUserData().name = list[i].Name;
				_body.GetUserData().reference = list[i].reference;
			}
			
			list = recInformBlock.listKinematicBlock;
			for(i = 0; i < list.length; i++) 
			{
				_loc = list[i].loc;
				_w = list[i].w;
				_h = list[i].h;
				_angle = list[i].angle;
				_density = list[i].density;
				_friction = list[i].friction;
				_target = list[i].target;
				if(_target) 
					_target.body = this.createKinematicBox(_loc.x - _w / 2, _loc.y - _h / 2, _w, _h, _angle, _density);
				else this.createKinematicBox(_loc.x - _w / 2, _loc.y - _h / 2, _w, _h, _angle, _density);
			}
			
		}
				
		public function UpdateWorld(event:Event):void 
		{
			world.Step(this.timeStep, 10, 10);
 			
			for (var bodiesList:b2Body = world.GetBodyList(); bodiesList; bodiesList = bodiesList.GetNext()) {
				if(bodiesList.GetType() == b2Body.b2_staticBody) continue;
				var _userData:* = bodiesList.GetUserData(); 
				var position:b2Vec2 = bodiesList.GetPosition();
 				
				if(_userData != null)
					if(_userData.sprite != null) 
					{
						_userData.sprite.x = position.x * SCALE;
						_userData.sprite.y = position.y * SCALE;
						_userData.sprite.rotation = bodiesList.GetAngle() * 180 / Math.PI;
					}
			}
			world.ClearForces();
			if(isActiveDebugDraw) world.DrawDebugData();
		}

		
		protected function createWalls():void 
		{
			var wallThickness:Number = 2;
			var wall:b2Body;
			wall = createStaticBox(0, 0, locationRightBorder, wallThickness);
			wall.GetUserData().wall = true;
			wall = createStaticBox(0, 0, wallThickness, locationBottomBorder);
			wall.GetUserData().wall = true;
			wall = createStaticBox(0, locationBottomBorder, locationRightBorder, wallThickness);
			wall.GetUserData().wall = true;
			wall = createStaticBox(locationRightBorder, 0, wallThickness, locationBottomBorder);
			wall.GetUserData().wall = true;
		}
				
		public function createDynamicBox(x:Number,
										 y:Number,
										 w:Number,
										 h:Number,
										 density:Number = 1,
										 angle:Number = 0,
										 friction:Number = 0):b2Body
		{
			var _body:b2Body;
			var _def:b2BodyDef = new b2BodyDef();
			var _shape:b2PolygonShape = new b2PolygonShape();
			var _fixture:b2FixtureDef = new b2FixtureDef();
			
			var _w:Number = w;
			var _h:Number = h;
			
			if (angle != 0) 
			{
				_w *= Math.cos(angle);
				_h *= Math.sin(angle); 
			}
			
			_shape.SetAsBox(w / SCALE/ 2, h / SCALE / 2);
			_def.active = true;
			_def.type = b2Body.b2_dynamicBody;
			_def.position.Set(x / SCALE + w / SCALE / 2, y / SCALE + h / SCALE / 2);
			_body = world.CreateBody(_def);
			
			_fixture.density = density;
			_fixture.friction = friction;
			_fixture.shape = _shape;
			_fixture.restitution = 0.05;
			_fixture.userData = new Object();
			_body.CreateFixture(_fixture);
			
			_body.SetUserData(new Object());
			return _body;
		}
		
		public function createKinematicBox(x:Number, 
										y:Number, 
										w:Number, 
										h:Number, 
										angle:Number = 0, 
										density:Number = 1,
										friction:Number = 0.0):b2Body 
		{
			var _body:b2Body;
			var _def:b2BodyDef = new b2BodyDef();
			var _shape:b2PolygonShape = new b2PolygonShape();
			var _fixture:b2FixtureDef = new b2FixtureDef();
			var _w:Number = w;
			var _h:Number = h;
			
			if (angle != 0) 
			{
				_w *= Math.cos(angle);
				_h *= Math.sin(angle); 
			}
			
			_shape.SetAsBox(w / SCALE/ 2, h / SCALE / 2);
			_def.active = true;
			_def.type = b2Body.b2_kinematicBody;
			_def.position.Set(x / SCALE + w / SCALE / 2, y / SCALE + h / SCALE / 2);
			_def.angle = angle;
			_body = world.CreateBody(_def);
			
			_fixture.density = density;
			_fixture.friction = friction;
			_fixture.shape = _shape;
			_fixture.restitution = 0.05;
			_fixture.userData = new Object();
			_body.CreateFixture(_fixture);
			
			_body.SetUserData(new Object());
						
			return _body;
		}
		
		public function createStaticBox(x:Number, 
										y:Number, 
										w:Number, 
										h:Number, 
										angle:Number = 0, 
										density:Number = 1,
										friction:Number = 0.1):b2Body 
		{
			var _body:b2Body;
			var _def:b2BodyDef = new b2BodyDef();
			var _shape:b2PolygonShape = new b2PolygonShape();
			var _fixture:b2FixtureDef = new b2FixtureDef();
			
			_shape.SetAsBox(w / SCALE/ 2, h / SCALE / 2);
			_def.active = true;
			_def.type = b2Body.b2_staticBody;
			_def.position.Set(x / SCALE + w / SCALE / 2, y / SCALE + h / SCALE / 2);
			_def.angle = angle;
			_body = world.CreateBody(_def);
			
			_fixture.density = density;
			_fixture.friction = friction;
			_fixture.shape = _shape;
			_fixture.restitution = 0.05;
			_fixture.userData = new Object();
			_body.CreateFixture(_fixture);
			
			_body.SetUserData(new Object());
						
			return _body;
		}
		
		public function createBox(x:Number, 
										y:Number, 
										w:Number, 
										h:Number, 
										type:Number,
										angle:Number = 0, 
										density:Number = 1,
										friction:Number = 0.1):b2Body 
		{
			var _body:b2Body;
			var _def:b2BodyDef = new b2BodyDef();
			var _shape:b2PolygonShape = new b2PolygonShape();
			var _fixture:b2FixtureDef = new b2FixtureDef();
			
			_shape.SetAsBox(w / SCALE/ 2, h / SCALE / 2);
			_def.active = true;
			_def.type = type;
			_def.position.Set(x / SCALE + w / SCALE / 2, y / SCALE + h / SCALE / 2);
			_def.angle = angle;
			_body = world.CreateBody(_def);
			
			_fixture.density = density;
			_fixture.friction = friction;
			_fixture.shape = _shape;
			_fixture.restitution = 0.05;
			_fixture.userData = new Object();
			_body.CreateFixture(_fixture);
			
			_body.SetUserData(new Object());
						
			return _body;
		}
		
		// x, y - координаты центра фигуры
		public function createPoligon(x:Number,
									  y:Number,
									  array:Array,
									  numVer:Number,
									  density:Number = 1):b2Body 
		{
			var _body:b2Body;
			var _def:b2BodyDef = new b2BodyDef();
			var _shape:b2PolygonShape = new b2PolygonShape();
			var _fixture:b2FixtureDef = new b2FixtureDef();
			
			_shape.SetAsArray(array, numVer);
			_def.active = true;
			_def.type = b2Body.b2_staticBody;
			_def.position.Set(x / SCALE, y / SCALE);
			_body = world.CreateBody(_def);
			
			_fixture.density = density;
			_fixture.friction = 0.0;
			_fixture.shape = _shape;
			_fixture.restitution = 0.05;
			
			_body.CreateFixture(_fixture);
			_body.SetUserData(new Object());
			
			return _body;
		}
		
		public function createDynamicCircle(x:Number, 
											y:Number, 
											r:Number, 
											angle:Number = 0, 
											density:Number = 1,
											friction:Number = 0,
											type:Number = 2):b2Body
		{
			var _body:b2Body;
			var _def:b2BodyDef = new b2BodyDef();
			var _shape:b2CircleShape;	
			var _fixture:b2FixtureDef = new b2FixtureDef();
			
			_shape = new b2CircleShape(r / SCALE / 2);
			_def.active = true;
			_def.type = type;
			_def.position.Set(x / SCALE + r / SCALE / 2, y / SCALE + r / SCALE / 2);
			_def.angle = angle;
			_body = world.CreateBody(_def);
			
			_fixture.density = density;
			_fixture.friction = friction;
			_fixture.shape = _shape;
			_fixture.restitution = 0.05;
			_fixture.userData = new Object();
			_body.CreateFixture(_fixture);
			
			_body.SetUserData(new Object());
						
			return _body;
		}
		
		public function createPlayer(x:Number,
									 y:Number,
									 w:Number,
									 h:Number):b2RevoluteJoint
		{
			var _bodyA:b2Body = this.createDynamicBox(x, y, w, h, 2, 0, 0);			
			var _bodyB:b2Body = this.createDynamicCircle(x, y + h / 3 * 2, 40, 0, 2, 1);
			var _joint:b2RevoluteJoint;
			var _jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			_jointDef.bodyA = _bodyA;
			_jointDef.bodyB = _bodyB;
			_jointDef.localAnchorA = b2Vec2.Make(0, w / 3 * 2 / SCALE);
			_jointDef.localAnchorB = b2Vec2.Make(0, 0);
			_joint = this.world.CreateJoint(_jointDef) as b2RevoluteJoint;
			
			_bodyA.SetSleepingAllowed(false);
			_bodyA.SetFixedRotation(true);
			
			_bodyB.SetSleepingAllowed(false);
			_bodyB.SetFixedRotation(true);
			
			return _joint;
		}
		
		public function deleteDebugDraw():void
		{
			
		}
		
		private var _debugDraw:b2DebugDraw;
		
		public function addDebugDraw():void 
		{
			_debugDraw = new b2DebugDraw();
			
			_debugDraw.SetSprite(this);
			_debugDraw.SetDrawScale(SCALE);
			_debugDraw.SetLineThickness(5.0);
			_debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit | b2DebugDraw.e_aabbBit);
			world.SetDebugDraw(_debugDraw);
			isActiveDebugDraw = true;
		}
		
		function error(code:Number) {
			trace("error " + code);
		}
	}
	
}
