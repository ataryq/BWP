package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	
	
	public class FlagHelp extends MovieClip {		
		protected var info:informBlockListPlatform;
		public static const Name:String = "FlagHelp";
		protected var message:String;
		protected var messageArray:Array;
		protected var loc:Point;
		protected var colBlock:CollisionBlock;
		private const symSplit:String = "#";
		
		public function FlagHelp(_loc:Point,
								  _message:String) 
		{
			// constructor code
			message = _message;
			messageArray = message.split(symSplit);
			loc = _loc;
			this.x = loc.x;
			this.y = loc.y;
			this.gotoAndStop(1);
			if(stage) addStage();
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			info.contactListener.addFunction(Out);
			var body:b2Body = info.createWorld.createStaticBox(this.x, this.y, 40, 60);
			body.GetFixtureList().SetSensor(true);
			body.GetUserData().name = FlagHelp.Name;
			body.GetUserData().reference = this;
		}
		
		public function Out(contact:b2Contact):void
		{
			if( gamePlayer.CheckObject(contact) &&
			(contact.GetFixtureA().GetBody().GetUserData().reference == this ||
			contact.GetFixtureB().GetBody().GetUserData().reference == this) ) 
			{
				info.toolBar.dialogField.SetTextArray(messageArray);
				info.toolBar.dialogField.ShowPanel(); 
				this.gotoAndStop(12);
			}
		}
		
	}
	
}

