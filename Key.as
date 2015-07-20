package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	
	
	public class Key extends MovieClip {
		public static const YELLOW:Number = 1;
		public static const GREEN:Number = 2;
		public static const RED:Number = 3;
		public static const BLUE:Number = 4;
		public var curColor:Number = YELLOW;
		public static const Name:String = "key";
		protected var info:informBlockListPlatform;
		public var body:b2Body;
		
		public function Key(color:Number, withoutBody:Boolean = false, loc:Point = null) {
			// constructor code
			if(color > 0 && color < 5) {
				this.gotoAndStop(color);
				this.curColor = color;
			} else {
				trace("error set color key");
			}
			if(loc)
			{
				this.x = loc.x;
				this.y = loc.y;
			}
			if(!withoutBody) {
				if(stage) addStage();
				else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
			}
			
		}
		
		protected function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			body = info.createWorld.createStaticBox(this.x, this.y, 45, 45);
			body.GetFixtureList().SetSensor(true);
			body.GetUserData().reference = this;
			body.GetUserData().name = Name;
			body.GetUserData().item = true;
			body.GetUserData().activeObject = true;
		}
		
		public function Delete():void
		{
			if(this.parent) this.parent.removeChild(this);
			if(body && info) {
				info.game.player.arrayDelete.push(body);
			}
		}
	}
	
}
