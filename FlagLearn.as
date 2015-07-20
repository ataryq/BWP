package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	
	
	public class FlagLearn extends MovieClip {		
		protected var info:informBlockListPlatform;
		protected var firstName:String;
		protected var secondName:String;
		protected var message:String;
		protected var loc:Point;
		protected var colBlock:CollisionBlock;
		
		public function FlagLearn(_loc:Point,
								  _message:String) 
		{
			// constructor code
			message = _message;
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
			firstName = "bodyControl";
			secondName = message;
			colBlock = new CollisionBlock(30, 
										  	100, 
										  	loc, 
											Out, 
											b2Body.b2_staticBody, 
											true);
			
		}
		
		public function Out(contact:b2Contact):void
		{
			if( (contact.GetFixtureA().GetBody().GetUserData().name == firstName ||
			contact.GetFixtureB().GetBody().GetUserData().name == firstName) &&
			(contact.GetFixtureA().GetBody().GetUserData().name == secondName ||
			contact.GetFixtureB().GetBody().GetUserData().name == secondName) ) 
			{
				info.toolBar.dialogField
				info.toolBar.dialogField.SetText(message);
				info.toolBar.dialogField.ShowPanel(); 
				this.gotoAndStop(2);
			}
		}
		
	}
	
}
