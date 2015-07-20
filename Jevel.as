package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import Box2D.Dynamics.b2Body;
	
	
	public class Jevel extends MovieClip {
		public var info:informBlockListPlatform;
		public var PRICE:Number = 10;
		public static const Name:String = "jevel";
		public var body:b2Body;
		public var isDelete:Boolean = false;
		
		public function Jevel(_loc:Point) {
			// constructor code
			this.x = _loc.x;
			this.y = _loc.y;
			if(stage) addStage();
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		public function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			body = info.createWorld.createStaticBox(this.x, this.y, 50, 50);
			body.GetUserData().reference = this;
			body.GetUserData().money = true;
			body.GetUserData().name = Jevel.Name;
			body.GetFixtureList().SetSensor(true);
		}
		
		public function Delete():void
		{
			isDelete = true;
			if(this.parent) this.parent.removeChild(this);
		}
	}
	
}
