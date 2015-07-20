package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class Cogwheel extends baseEnemy
	{
		public static const DAMAGE:Number = 1;
		public static const Name:String = "cogwheel";
		
		public function Cogwheel(_body:b2Body) 
		{
			// constructor code
			this.name = Name;
			this.sprite = new spriteCogwheel();
			super(_body);
			this.body.GetUserData().enemy = false;
			this.body.GetUserData().hidrance = true;
			this.body.GetUserData().activeObject = true;
			this.sprite.SetAnim(baseAnimationEnemy.MOVE_LEFT);
		}
		
		public static function CollisionWithHidrance(contact:b2Contact):void
		{
			var userDataA:Object = contact.GetFixtureA().GetBody().GetUserData();
			var userDataB:Object = contact.GetFixtureB().GetBody().GetUserData();
			
			if(gamePlayer.CheckObject(contact) && 
			   ((userDataA.name == Cogwheel.Name) ||
			   (userDataB.name == Cogwheel.Name)))
			{
				
				if(userDataA.name == Player.NameBodyBox || userDataA.name == Player.NameBodyControl) 
					(userDataA.reference as gamePlayer).SubstractHealth(Cogwheel.DAMAGE, 
																		contact.GetFixtureA().GetBody());
				else (userDataB.reference as gamePlayer).SubstractHealth(Cogwheel.DAMAGE, 
																		 contact.GetFixtureB().GetBody());
			}
		}

	}
}
