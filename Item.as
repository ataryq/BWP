package  {
	
	import flash.display.MovieClip;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	
	
	public class Item extends MovieClip {
		public var arrayKey:Array;
		public const DISTANCE_BETWEEN_KEY:Number = 50;
		protected var info:informBlockListPlatform;
		
		public function Item() 
		{
			// constructor code
			arrayKey = new Array();
			if(stage) addStage();
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		public function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			info.contactListener.addFunction(CollisionWithKey);
			info.contactListener.addFunction(CollisionWithDoor);
		}
		
		public function CollisionWithKey(contact:b2Contact):void
		{
			var userDataA:Object = contact.GetFixtureA().GetBody().GetUserData();
			var userDataB:Object = contact.GetFixtureB().GetBody().GetUserData();
			
			if(gamePlayer.CheckObject(contact) && 
			   ((userDataA.name == Key.Name) ||
			   (userDataB.name == Key.Name)))
			   {
				   if(userDataA.name == Key.Name) {
					   this.AddKey((userDataA.reference as Key).curColor);
					   (userDataA.reference as Key).Delete();
				   }
				   else {
					   this.AddKey((userDataB.reference as Key).curColor);
					   (userDataB.reference as Key).Delete();
				   }
			   }
		}
		
		public function CollisionWithDoor(contact:b2Contact):void
		{
			var userDataA:Object = contact.GetFixtureA().GetBody().GetUserData();
			var userDataB:Object = contact.GetFixtureB().GetBody().GetUserData();
			
			if(gamePlayer.CheckObject(contact) && 
			   ((userDataA.name == Door.Name) ||
			   (userDataB.name == Door.Name)))
			   {
				   if(userDataA.name == Door.Name) {
					   if(DeleteKey((userDataA.reference as Door).curColor)) {
						  (userDataA.reference as Door).Delete(); 
					   }
				   }
				   else {
					   if(DeleteKey((userDataB.reference as Door).curColor)) {
						  (userDataB.reference as Door).Delete(); 
					   }
				   }
			   }
		}
		
		public function DeleteKey(_color:Number):Boolean
		{
			for(var i:uint = 0; i < arrayKey.length; i++)
			{
				if(!arrayKey[i]) continue;
				if((arrayKey[i] as Key).curColor == _color)
				{
					(arrayKey[i] as Key).Delete();
					arrayKey[i] = null;
					return true;
				}
			}
			return false;
		}
		
		public function AddKey(_color:Number):void
		{
			var key:Key = new Key(_color, true);
			arrayKey.push(key);
			addChild(key);
			
			key.x = -190 + arrayKey.length * 50;
			key.y = - key.height / 2;
		}
		
	}
	
}
