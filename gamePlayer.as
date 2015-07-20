package  {
	import flash.geom.Point;
	import flash.events.Event;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	
	public class gamePlayer extends Player {
		var createWorld:CreateWorld;
		var bodyPlayer:b2RevoluteJoint;
		public var player:Player;
		var startPos:Point;
		public var dialogField:FieldText;
		public var arrayDelete:Array;
		public static const Name:String = "hero";
		
		const playerH:Number = 66;
		const playerW:Number = 40;
		
		public function gamePlayer(_info:informBlockListPlatform, _startPos:Point) 
		{
			// constructor code
			startPos = _startPos;
			info = _info;
			createWorld = info.createWorld;
			arrayDelete = new Array();
			bodyPlayer = createWorld.createPlayer(_startPos.x, _startPos.y, playerW, playerH);
			super(bodyPlayer.GetBodyB(), bodyPlayer.GetBodyA(), playerH, playerW);
			bodyPlayer.GetBodyA().GetUserData().reference = this;
			bodyPlayer.GetBodyB().GetUserData().reference = this;
			if(!stage) this.addEventListener(Event.ADDED_TO_STAGE, game_addStage);
			else game_addStage();
		}
		
		public function RestartPlayer(_startPos:Point):void
		{
			bodyPlayer = createWorld.createPlayer(_startPos.x, _startPos.y, playerW, playerH);
			bodyBox = bodyPlayer.GetBodyA();
			bodyBox.GetUserData().name = this.bodyBox;
			bodyControl = bodyPlayer.GetBodyB();
			bodyControl.GetUserData().name = this.bodyControl;
			bodyBox.GetUserData().reference = this;
			bodyControl.GetUserData().reference = this;
			this.removeChild(_spriteHero);
			addSprite();
		}
		
		protected function game_addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, game_addStage);
			info.contactListener.addFunction(ProccessingBuller);
			info.contactListener.addFunction(FindCoin);
		}
		
		protected function FindCoin(contact:b2Contact):void
		{
			var USDataA:Object = contact.GetFixtureA().GetBody().GetUserData();
			var USDataB:Object = contact.GetFixtureB().GetBody().GetUserData();
			
			var jeverly:b2Body;
			var hero:b2Body;
			
			if((USDataA.money || USDataB.money) &&
			   (USDataA.name == "bodyBox" || USDataB.name == "bodyBox" || 
				USDataA.name == "bodyControl" || USDataB.name == "bodyControl"))
			   {
				   if(USDataA.money)
				   {
					   jeverly = contact.GetFixtureA().GetBody();
					   hero = contact.GetFixtureB().GetBody();
				   } else
				   {
					   jeverly = contact.GetFixtureB().GetBody();
					   hero = contact.GetFixtureA().GetBody();
				   }
				   
				   if(!jeverly.GetUserData().reference.isDelete) {
				   		this.info.toolBar.counterMoney.AddMoney(jeverly.GetUserData().reference.PRICE);
				   }
				   this.info.toolBar.counterMoney.Update();
				   jeverly.GetUserData().reference.Delete();
				   arrayDelete.push(jeverly);
			   }
		}
		
		public static function CheckObject(_contact:b2Contact):Boolean
		{
			if(_contact.GetFixtureA().GetBody().GetUserData().name == "bodyBox" ||
			   _contact.GetFixtureB().GetBody().GetUserData().name == "bodyBox" ||
			   _contact.GetFixtureA().GetBody().GetUserData().name == "bodyControl" ||
			   _contact.GetFixtureB().GetBody().GetUserData().name == "bodyControl")
			   {
				   return true;
			   }
			return false;
		}
		
		protected function ProccessingBuller(contact:b2Contact):void
		{
			var USDataA:Object = contact.GetFixtureA().GetBody().GetUserData();
			var USDataB:Object = contact.GetFixtureB().GetBody().GetUserData();
			if(USDataA.bullet) 
			{
				if(contact.GetFixtureA().IsSensor()) return;
				USDataA.reference.Delete();
				this.info.world.DestroyBody(contact.GetFixtureA().GetBody());
			}
			if(USDataB.bullet) 
			{
				if(contact.GetFixtureB().IsSensor()) return;
				USDataB.reference.Delete();
				this.info.world.DestroyBody(contact.GetFixtureB().GetBody());
			}
		}
		
		public function SubstractHealth(_damage:Number = 1, _body_jump_back:b2Body = null):void
		{
			trace("Substact " + _damage);
			if(!info.toolBar.counterLives.SubstractLive(_damage)) {
				info.game.DiedPlayer();
			}
			if(_body_jump_back) this.JumpBack(_body_jump_back);
		}
		
		public function game_Update(event:Event):void
		{
			if(arrayDelete.length > 0) 
			{
				for(var i:uint = 0; i < this.arrayDelete.length; i++)
				{
					if(arrayDelete[i]) this.createWorld.world.DestroyBody(arrayDelete[i]);
				}
				arrayDelete = new Array();
			}
			
			this.Update(event, createWorld.world);
		}
	}
}
