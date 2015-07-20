package  {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class DynamicPlatform extends MovieClip {
		protected var behaviuor:Behaviours;
		
		public function DynamicPlatform(world:CreateWorld, 
											  loc:Point, 
											  leftBor:b2Vec2, 
											  rightBor:b2Vec2,
											  speed:b2Vec2 = null) 
		{
			// constructor code
			var body:b2Body = world.createKinematicBox(loc.x, loc.y, this.width, 10, 0, 1.0, 0.4);
			if(!speed) speed = new b2Vec2(4, 4);
			body.GetUserData().sprite = this;
			body.GetUserData().name = "dynamicPlatform"
			body.GetUserData().reference = this;
			behaviuor = new Behaviours(body, speed);
			behaviuor.AddMoveOnLine(leftBor, rightBor);
			
			this.addEventListener(Event.EXIT_FRAME, Update);
		}
		
		public function Die():void
		{
			this.removeEventListener(Event.EXIT_FRAME, Update);
			this.parent.removeChild(this);
		}
		
		public function Update(event:Event = null):void
		{
			behaviuor.Update();
		}
	}
	
}
