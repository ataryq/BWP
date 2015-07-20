package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import Box2D.Dynamics.b2Body;
	
	public class Coin extends MovieClip {
		public var info:informBlockListPlatform;
		public var loc:Point;
		public const PRICE:Number = 1;
		public static const Name:String = "coin";
		public var body:b2Body;
		public var isDelete:Boolean = false;
		
		public function Coin(_loc:Point = null) 
		{
			// constructor code
			loc = _loc;
			if(loc)
			{
				this.x = _loc.x;
				this.y = _loc.y;
			}
			if(stage) addStage();
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		public function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			if(!loc) info.AddStaticPlatform(new structPlatform(50, 50, new Point(this.x, this.y), 0, 1, 0, true, "coin", this));
			else 
			{
				body = info.createWorld.createStaticBox(loc.x, loc.y, 50, 50);
				body.GetUserData().reference = this;
				body.GetUserData().name = Coin.Name;
				body.GetUserData().money = true;
				body.GetFixtureList().SetSensor(true);
				body.GetUserData().activeObject = true;
			}
		}
		
		public function Delete():void
		{
			isDelete = true;
			if(this.parent) this.parent.removeChild(this);
		}
	}
}
