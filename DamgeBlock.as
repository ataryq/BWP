package  
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import Box2D.Dynamics.b2Body;
	import Box2D.Collision.Shapes.b2MassData;
	import flash.events.Event;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	
	public class DamgeBlock extends CollisionBlock 
	{
		public static const Name:String = "DAMAGE_BLOCK";
		public var numDamage:Number = 1;
		
		public function DamgeBlock(_w:Number,
								   _h:Number,
								   _loc:Point,
								   _sensor:Boolean = false) 
		{
			// constructor code
 			super(_w, _h, _loc, CheckCollision, b2Body.b2_kinematicBody, _sensor, 1000);
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			body.GetUserData().sprite = this;
			body.GetUserData().name = DamgeBlock.Name;
			body.GetUserData().reference = this;
			body.GetUserData().activeObject = true;
		}
		
		public function CheckCollision(contact:b2Contact):void
		{
			var userDataA:Object = contact.GetFixtureA().GetBody().GetUserData();
			var userDataB:Object = contact.GetFixtureB().GetBody().GetUserData();
			
			if(gamePlayer.CheckObject(contact) && 
			   ((userDataA.reference == this) ||
			   (userDataB.reference == this)))
			   {
				   trace(this.numDamage);
				   if(userDataA.name == DamgeBlock.Name) 
				   {
					   (userDataB.reference as gamePlayer).SubstractHealth(this.numDamage, this.body);
				   }
				   else 
				   {
					   (userDataA.reference as gamePlayer).SubstractHealth(this.numDamage, this.body);
				   }
			   }
		}
	}
	
}
