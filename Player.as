
package  {
	import flash.display.Sprite;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import Box2D.Common.Math.b2Vec2;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	
	public class Player extends MovieClip 
	{
		public var bodyControl:b2Body;
		public var bodyBox:b2Body;
		protected var h:Number;
		protected var w:Number;
		public var _spriteHero:spriteHero;
		protected var weapon:Weapon;
		protected var sword:Sword;
		protected var gun:GunYelMini;
		protected var board:BoardWood;
		protected var mouseDownCoordX:Number;
		protected var spriteSpeedTime:SpriteSpeedTime;
		protected var isMouseDown:Boolean = false;
		public var info:informBlockListPlatform;
		public var lastCoord:b2Vec2;
		protected var forceJumpBack:Number = 60;
		private var world:b2World;
		
		protected const originalSpeed:Number = 7;
		protected const originalForceJump:Number = 120;
		protected const maxHoldKeyJump:Number = 20;
		protected const kHoldKeyJump:Number = 2;
		protected const maxSpeed:Number = 15;
		public const SWORD:Boolean = false;
		public const GUN:Boolean = true;
		public static const NameBodyBox:String = "bodyBox";
		public static const NameBodyControl:String = "bodyControl";
		
		public var accessAction:Boolean = true;
		public var accessMoveRight:Boolean = true;
		public var accessMoveLeft:Boolean = true;
		public var accessMoveUp:Boolean = false;
		public var accessMoveDown:Boolean = false;
		public var accessJump:Boolean = true;
		public var accessJumpInMove:Boolean = true;
		public var accessAtack:Boolean = true;
		public var accessBoardClose:Boolean = true;
		public var accessSword:Boolean = true;
		public var accessGun:Boolean = false;
		public var accessChangeSpeedTime:Boolean = false;
		public var accessEnlargeSpeedTime:Boolean = false;
		public var accessReductSpeedTime:Boolean = false;
		public var accessBackJump:Boolean = true;
		
		public function Player(_bodyControl:b2Body, _bodyBox:b2Body, _h:Number, _w:Number) 
		{
			// constructor code
			bodyBox = _bodyBox;
			bodyBox.GetUserData().name = NameBodyBox;
			bodyControl = _bodyControl;
			bodyControl.GetUserData().name = NameBodyControl;
			h = _h;
			w = _w;
			this.name = "hero";
			addSprite();
			if(stage) addStage(null);
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addSprite():void 
		{
			_spriteHero = new spriteHero();
			_spriteHero.x = -w / 2;
			_spriteHero.y = -h / 2;
			addChildAt(_spriteHero, 0);
			
			var _userData:Object = bodyBox.GetUserData();
			_userData.sprite = _spriteHero;
		}
		
		private function addStage(event:Event = null):void 
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, ClickDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, ClickUp);
			var info:informBlockListPlatform = informBlockListPlatform.GetInformBlock(stage);
			info.player = this;
			initTestWeapon();
			
			spriteSpeedTime = new SpriteSpeedTime();
			stage.addChild(spriteSpeedTime); 
			spriteSpeedTime.visible = false;
			info = informBlockListPlatform.GetInformBlock(stage);
			world = info.createWorld.world;
		}
		
		public function JumpBack(body:b2Body):void
		{
			if(!accessBackJump) return;
			var goUp:Boolean = true;
			var difX:Number = body.GetWorldCenter().x - bodyControl.GetWorldCenter().x;
			var difY:Number = body.GetWorldCenter().y - bodyControl.GetWorldCenter().y;
			var speedJump:Number = -10;
			const speedUpJump:Number = -10;
			const speedJumpOnLand:Number = -12;
			
			if(this.CheckOnLand()) speedJump = speedJumpOnLand;
			
			if(difY < 0) {
				if(difX < 0) {
					this.bodyBox.SetLinearVelocity(b2Vec2.Make(-speedJump, 0));
					this.bodyControl.SetLinearVelocity(b2Vec2.Make(-speedJump, 0));
				} else {
					this.bodyBox.SetLinearVelocity(b2Vec2.Make(speedJump, 0));
					this.bodyControl.SetLinearVelocity(b2Vec2.Make(speedJump, 0));
				}
			} else {
				if(difX < 0) {
					this.bodyBox.SetLinearVelocity(b2Vec2.Make(-speedJump, speedUpJump));
					this.bodyControl.SetLinearVelocity(b2Vec2.Make(-speedJump, speedUpJump));
				} else {
					this.bodyBox.SetLinearVelocity(b2Vec2.Make(speedJump, speedUpJump));
					this.bodyControl.SetLinearVelocity(b2Vec2.Make(speedJump, speedUpJump));
				}
			}
		}
		
		protected function ClickDown(event:MouseEvent):void
		{
			if(accessChangeSpeedTime)
			{
				mouseDownCoordX = stage.mouseX;
				spriteSpeedTime.visible = true;
				isMouseDown = true;
			}
		}
		
		protected function ClickUp(event:MouseEvent):void
		{
			if(accessChangeSpeedTime) {
				var deltaDis:Number = stage.mouseX - mouseDownCoordX;
				if(deltaDis < -100 && accessEnlargeSpeedTime) {
					if(stage) informBlockListPlatform.GetInformBlock(stage).createWorld.timeStep /= Math.abs(deltaDis / 100);
				} else if(deltaDis > 100 && accessReductSpeedTime) {
					if(stage) informBlockListPlatform.GetInformBlock(stage).createWorld.timeStep *= Math.abs(deltaDis / 100);
				} else if(stage) informBlockListPlatform.GetInformBlock(stage).createWorld.timeStep = CreateWorld.BASE_TIME_STEP;
				spriteSpeedTime.visible = false;
				isMouseDown = false;
			}
		}
		
		public function DeletePlayer():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, ClickDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, ClickUp);
			gun.Delete_Weapson();
			sword.Delete_Sword();
			accessAction = false;
			info.world.DestroyBody(bodyBox);
			info.world.DestroyBody(bodyControl);
			if(stage.contains(spriteSpeedTime)) stage.removeChild(spriteSpeedTime);
		}
		
		public function deleteSword():void
		{
			sword.switchOff();
			accessSword = false;
			if(!accessGun) this._spriteHero.removeWeapon();
			bodyControl.GetFixtureList().SetSensor(true);
			bodyBox.GetFixtureList().SetSensor(true);
		}
		
		public function deleteGun():void
		{
			gun.switchOff();
			accessGun = false;
			if(!accessSword) this._spriteHero.removeWeapon();
		}
		
		public function SwithOnWeapon(_weapon:Boolean):void
		{
			if(_weapon == this.GUN) {
				if(this.gun) {
					weapon = gun;
					if(this.sword) sword.switchOff();
				}
			} else if(_weapon == this.SWORD){
				if(this.sword) {
					weapon = sword;
					if(this.gun) gun.switchOff();
				}
			}
			weapon.switchOn();
			this._spriteHero.addWeapon();
		}
		
		public function addSword(num:Number):Boolean
		{
			if(!accessSword) return false;
			sword = new Sword();
			_spriteHero.addChild(sword);
			weapon = sword;
			_spriteHero.addWeapon();
			return true;
		}
		
		public function addGun(num:Number):Boolean
		{
			if(!accessGun) return false;
			gun = new GunYelMini();
			_spriteHero.addChild(gun);
			weapon = gun;
			_spriteHero.addWeapon();
			return true;
		}
		
		public function initTestWeapon():void
		{
			sword = new Sword();
			gun = new GunYelMini();
			_spriteHero.addChild(sword);
			_spriteHero.addChild(gun);
			gun.switchOff();
			weapon = sword;
			_spriteHero.addWeapon();
		}
		
		public function GetPosition():b2Vec2 {
			return bodyBox.GetPosition();
		}
		
		public function GetWorldPosition():b2Vec2 {
			return bodyBox.GetWorldCenter();
		}
		
		public function GetContactBody():b2Body {
			return bodyControl;
		}
		
		public function addWeapon(_weapon:Weapon):void
		{
			weapon = _weapon;
			_spriteHero.addChild(weapon);
			_spriteHero.addWeapon();
			weapon.onBack();
		}
		
		public function addBoard(_board:BoardWood):void
		{
			board = _board;
			_spriteHero.addChild(board);
			board.Open();
		}
		
		
		private var goLeft:Boolean = false;
		private var goRight:Boolean = false;
		private var jump:Boolean = false;
		private var releaseJump:Boolean = true;
		private var goUp:Boolean = false;
		private var goDown:Boolean = false;
		private var atack:Boolean = false;
		private var boardHold:Boolean = false;
		
		protected var jumpKeyHoldTime:Number = 0;
		protected var atackKeyHoldTime:Number = 0;
		protected var boardKeyHoldTime:Number = 0;
		public var speed:Number = 7;
		public var forceJump:Number = 125;
		private var lastDir:Boolean = false;
		
		private function KeyDown(event:KeyboardEvent)
		{
			if(!accessAction) return;
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
				case Keyboard.A: {
					if(accessMoveLeft)
						goLeft = true;
				} break;
				
				case Keyboard.RIGHT:
				case Keyboard.D: {
					if(accessMoveRight)
						goRight = true;
				} break;
				
				case Keyboard.UP:
				case Keyboard.W: {
					if(accessMoveUp)
						goUp = true;
				} break;
				
				case Keyboard.DOWN:
				case Keyboard.S: {
					if(accessMoveDown)
						goDown = true;
				} break;
				
				case Keyboard.NUMPAD_0:
				case Keyboard.SPACE: {
					if(accessJump) {
						jump = true;
					}
						
				} break;
				
				case Keyboard.SHIFT: {
					if(accessAtack && weapon) {
						atack = true;
						weapon.Atack(lastDir);
					}
				} break;
				
				case Keyboard.NUMBER_1: {
					if(!accessGun) return;
					if(sword) this.sword.switchOff();
					if(gun) this.gun.switchOn();
					else return;
					this.weapon = this.gun;
				} break;
				
				case Keyboard.NUMBER_2: {
					if(!accessSword) return;
					if(sword) this.sword.switchOn();
					else return;
					if(gun) this.gun.switchOff();
					this.weapon = this.sword;
				} break;
				
				case Keyboard.NUMPAD_1:
				case Keyboard.Q: {
					if(stage) informBlockListPlatform.GetInformBlock(stage).createWorld.timeStep /= 1.4;
				} break;
				
				case Keyboard.NUMPAD_2:
				case Keyboard.E: {
					if(stage) informBlockListPlatform.GetInformBlock(stage).createWorld.timeStep *= 1.4;
				} break;
			}
		}
		
		private function KeyUp(event:KeyboardEvent) 
		{
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
				case Keyboard.A: {
					this.bodyBox.GetLinearVelocity().x = 0.3;
					this.bodyBox.GetLinearVelocity().x = 0.3;
					goLeft = false;
				} break;
				
				case Keyboard.RIGHT:
				case Keyboard.D: {
					this.bodyBox.GetLinearVelocity().x = 0.3;
					this.bodyBox.GetLinearVelocity().x = 0.3;
					goRight = false;
				} break;
				
				case Keyboard.UP:
				case Keyboard.W: {
					goUp = false;
				} break;
				
				case Keyboard.DOWN:
				case Keyboard.S: {
					goDown = false;
				}
				
				case Keyboard.NUMPAD_0:
				case Keyboard.SPACE: {
					jump = false;
					releaseJump = true;
				} break;
				
				case Keyboard.SHIFT: {
					atack = false;
					atackKeyHoldTime = 0;
				} break;
				
				/*case Keyboard.E:
				case Keyboard.NUMPAD_1: {
					boardHold = false;
					if(accessBoardClose && this.board) {
						board.Open();
						boardKeyHoldTime = 0;
					}
				} break;*/
			}
		}
		
		protected function MoveHero():void
		{
			lastCoord = bodyControl.GetWorldCenter().Copy();
			if(goRight) 
			{
				if(bodyControl.GetLinearVelocity().x < maxSpeed) {
					bodyControl.ApplyImpulse(b2Vec2.Make(150 / 30, 0), bodyControl.GetWorldCenter());
					this.bodyBox.ApplyImpulse(b2Vec2.Make(150 / 30, 0), bodyControl.GetWorldCenter());
				}
			}
			else if(goLeft) 
			{
				if(bodyControl.GetLinearVelocity().x > -maxSpeed) {
					bodyControl.ApplyImpulse(b2Vec2.Make(-150 / 30, 0), bodyControl.GetWorldCenter());
					this.bodyBox.ApplyImpulse(b2Vec2.Make(-150 / 30, 0), bodyControl.GetWorldCenter());
				}
			}
			
			if(goUp) 
			{
				bodyControl.SetLinearVelocity(b2Vec2.Make(0, -15));
				this.bodyBox.SetLinearVelocity(b2Vec2.Make(0, -15));
			}
			else if(goDown) 
			{
				bodyControl.GetLinearVelocity().y = 0;
			}
			
			if(this.atack) this.atackKeyHoldTime++;
			if(this.boardHold) this.boardKeyHoldTime++;
		}
		
		protected function SetAnimationMove():void
		{
			if(goRight) 
			{
				_spriteHero.SetAnimation(spriteHero.GO_RIGHT);
				lastDir = true;
			}
			else if(goLeft) 
			{
				_spriteHero.SetAnimation(spriteHero.GO_LEFT);
				lastDir = false;
			}
			else 
			{
				if(lastDir) _spriteHero.SetAnimation(spriteHero.IDLE_RIGHT);
				else _spriteHero.SetAnimation(spriteHero.IDLE_LEFT);
			}
			if(goUp) 
			{
				_spriteHero.SetAnimation(spriteHero.CLIMB);
				if(weapon) weapon.onBack();
			} 
			else if(goDown) 
			{
				if(weapon) weapon.onBack();
				_spriteHero.SetAnimation(spriteHero.CLIMB);				
			} else {
				if(weapon) weapon.retStartState();
			}
		}
	
		protected function CheckOnLand():Boolean
		{
			var original:b2Vec2 = bodyControl.GetPosition().Copy();
			var radius:Number = 40;
			var down:b2Vec2 = bodyControl.GetPosition().Copy();
			down.y += (radius / 2 + 5) / CreateWorld.SCALE;
			var downLeft:b2Vec2 = bodyControl.GetPosition().Copy();
			downLeft.x += (radius / 2 - 5) / CreateWorld.SCALE;
			downLeft.y += (radius / 2 + 5) / CreateWorld.SCALE;
			var downRight:b2Vec2 = bodyControl.GetPosition().Copy();
			downRight.x -= (radius / 2 - 5) / CreateWorld.SCALE;
			downRight.y += (radius / 2 + 5) / CreateWorld.SCALE;
	
			var rayDown:b2Fixture = world.RayCastOne(original, down);
			var rayDownLeft:b2Fixture = world.RayCastOne(original, downLeft);
			var rayDownRight:b2Fixture = world.RayCastOne(original, downRight);
			
			if(rayDown || rayDownLeft || rayDownRight)
			{
				if(rayDown) if(!rayDown.GetBody().GetUserData().activeObject) return true;
				if(rayDownLeft) if(!rayDownLeft.GetBody().GetUserData().activeObject) return true;
				if(rayDownRight) if(!rayDownRight.GetBody().GetUserData().activeObject) return true;
			}
			return false;
		}
		
		protected function JumpHero():void 
		{
			if (CheckOnLand()) 
			{
				SetAnimationMove();
				if(jump && releaseJump) 
				{
					bodyControl.ApplyImpulse(new b2Vec2(0.0, -forceJump), bodyControl.GetWorldCenter());
					releaseJump = false;
				}
				else if(jumpKeyHoldTime != 0) {
					jumpKeyHoldTime = 0;
				}
			} else 
			{
				if(jumpKeyHoldTime < maxHoldKeyJump && jump) {
						jumpKeyHoldTime++;
						if(bodyControl.GetLinearVelocity().y < 0) bodyControl.ApplyImpulse(new b2Vec2(0.0, -4), bodyControl.GetWorldCenter());
					}
					else {
						jumpKeyHoldTime = 0;
						jump = false;
					}
				if(weapon) weapon.retStartState();
				SetAnimationJump();
			}
		}
		
		protected function SetAnimationJump():void 
		{
			if(goLeft) {
				_spriteHero.SetAnimation(spriteHero.JUMP_LEFT);
				lastDir = false;
			}
			else if(goRight) {
				_spriteHero.SetAnimation(spriteHero.JUMP_RIGHT);
				lastDir = true;
			}
			else if((_spriteHero.GetAnimation() != spriteHero.JUMP_LEFT) &&
					(_spriteHero.GetAnimation() != spriteHero.JUMP_RIGHT))
						_spriteHero.SetAnimation(spriteHero.JUMP_RIGHT);
		}
		
		public function Update(event:Event, _world:b2World) 
		{
			
			MoveHero();
			JumpHero();
			speed = originalSpeed;
			forceJump = originalForceJump;
			if(accessGun) weapon.Update(lastDir);
			if(!isMouseDown) 
			{
				if(stage) spriteSpeedTime.x = stage.mouseX;
				if(stage) spriteSpeedTime.y = stage.mouseY;
			}
		}
	}
	
}
