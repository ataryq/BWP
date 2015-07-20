package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;

	public class DynamicBox extends MovieClip 
	{
		public static const Name:String = "DynamicBox"
		private var loc:Point;
		protected var firction:Number = 0.4;
		public var body:b2Body;
		
		public function DynamicBox(_loc:Point) 
		{
			// constructor code
			loc = _loc;
			if(stage) addStage();
				else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		public function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			var info:informBlockListPlatform = informBlockListPlatform.GetInformBlock(stage);
			
			if(!info) {
				trace("error info == null/DynamicBox/addStage");
				return;
			}
			
			body = info.createWorld.createDynamicBox(loc.x, loc.y, this.width, this.height, 1, 0, firction);
			body.GetUserData().reference = this;
			body.GetUserData().sprite = this;
			body.GetUserData().name = DynamicBox.Name;
		}
		
	}
}
