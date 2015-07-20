package  {
	
	import flash.display.MovieClip;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.geom.Point;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;
	
	
	public class Flag extends MovieClip {
		
		public var info:informBlockListPlatform;
		public static const Name:String = "flag";
		public var isOpen:Boolean = false;
		
		public function Flag(loc:Point) {
			// constructor code
			this.x = loc.x;
			this.y = loc.y;
			this.gotoAndStop(1);
			if(stage) addStage();
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		public function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			info.contactListener.addFunction(CompleteGame);
			var body:b2Body = info.createWorld.createStaticBox(this.x, this.y, 40, 60);
			body.GetFixtureList().SetSensor(true);
			body.GetUserData().name = Flag.Name;
		}
		
		public function CompleteGame(contact:b2Contact):void
		{
			if(isOpen) return;
			if((contact.GetFixtureA().GetBody().GetUserData().name == "bodyControl" || 
			   contact.GetFixtureB().GetBody().GetUserData().name == "bodyControl") &&
			   (contact.GetFixtureA().GetBody().GetUserData().name == "flag" || 
			   contact.GetFixtureB().GetBody().GetUserData().name == "flag")) 
			   {
				   isOpen = true;
				   this.gotoAndStop(2);
				   if(InfoGlobal.EndLevel) InfoGlobal.EndLevel.call();
				   else info.game.CompleteGame();
			   }
			   
		}
	}
	
}
