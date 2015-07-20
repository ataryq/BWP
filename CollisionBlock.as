package  {
	import flash.geom.Point;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2World;
	import flash.events.Event;
	
	public class CollisionBlock extends MovieClip
	{
		private var info:informBlockListPlatform;
		protected var body:b2Body;
		private var type:Number;
		private var isSensor:Boolean;
		private var funct:Function;
		private var density:Number;
		private var W:Number;
		private var H:Number;
		private var loc:Point;
		
		public function CollisionBlock(_w:Number,
									   _h:Number,
									   _loc:Point,
									   _funct:Function,
									   _type:Number = 2,
									   _isSensor:Boolean = false,
									   _density:Number = 1.0) 
		{
			// constructor code
			W = _w;
			H = _h;
			loc = _loc;
			this.type = _type;
			this.isSensor = _isSensor;
			this.funct = _funct;
			this.density = _density;
			
			if(stage) addStage();
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			trace("createBox " + this.type);
			body = info.createWorld.createBox(loc.x, 
											  loc.y, 
											  W, 
											  H, 
											  this.type);
			body.GetFixtureList().SetSensor(this.isSensor);
			info.contactListener.addFunction(this.funct);
		}
		
	}
}
