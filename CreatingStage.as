package  {
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2DebugDraw;
	import flash.display.Sprite;
	import flash.events.Event;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.events.MouseEvent;
	import flash.display.SpreadMethod;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import fl.motion.easing.Back;
	import flash.display.StageDisplayState
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class CreatingStage extends MovieClip 
	{
		protected var LocationHeight:Number = 3000;
		protected var LocationWidth:Number = 4000;
		public var game:Game;
		public var StartPosPlayer:Point = new Point(350, 100);
		public var refParent;
		public var xmlPareser:XmlPareser;
		private var loadAnim:MovieClip = new LoadScreen();

		public function CreatingStage() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			this.addEventListener(Event.ENTER_FRAME, Update);
			refParent = this.parent;
			xmlPareser = new XmlPareser();
			addChild(xmlPareser);
		}
		
		protected function SetGameParams(event:Event = null):void
		{
			var xmlGameParams:XML = this.xmlPareser.xmlFile;
			if(event) xmlPareser.loader.removeEventListener(Event.COMPLETE, SetGameParams);
			var dubug:String = String(xmlGameParams.@DEBUG);
			if(dubug == "1") game.WORK = Game.DEBUG;
			else if(dubug == "0") game.WORK = Game.RELEASE;
			else trace("error! DEBUG params!");
			trace("NOW DEBUG " + game.WORK);
			trace("XML DEBUG " + dubug);
			
			InfoGlobal.nextLevelFileName = xmlGameParams.@NEXT_LEVEL_NAME_FILE;
			
			if(xmlGameParams.@STAGE_H != "0") this.game.locationH = Number(xmlGameParams.@STAGE_H);
			if(xmlGameParams.@STAGE_W != "0") this.game.locationW = Number(xmlGameParams.@STAGE_W);
			trace("stage " + xmlGameParams.@STAGE_H + " " + xmlGameParams.@STAGE_W);
			trace("player position " + xmlGameParams.@PLAYER_X + " " + xmlGameParams.@PLAYER_Y);
			
			game.startPosPlayer = new Point(Number(xmlGameParams.@PLAYER_X), Number(xmlGameParams.@PLAYER_Y));
			
			this.refParent.addChild(game);
		}
		
		public function CreateStage(nameLevel:String):void
		{
			if(!stage) 
			{
				trace("error, no stage");
				return;
			}
			
			stage.addChild(loadAnim);
			
			xmlPareser.InitLevelFromMap(nameLevel);
			
			game = new Game();
			game.locationH = this.LocationHeight;
			game.locationW = this.LocationWidth;
			game.startPosPlayer = StartPosPlayer;
			refParent = this.parent;
			
			if(xmlPareser.xmlFile) SetGameParams();
			else xmlPareser.loader.addEventListener(Event.COMPLETE, SetGameParams);
			
			xmlPareser.CreateGameFromXML();
			
			stage.removeChild(loadAnim);
		}
		
		public function DeleteStage():void
		{
			if(this.xmlPareser)
			{
				this.removeChild(this.xmlPareser);
				this.xmlPareser = new XmlPareser();
				this.addChild(this.xmlPareser);
			}
			
			if(game)
			{
				game.info.contactListener.clearFunction();
				game.DeleteGame();
			}
		}
		
		protected function Update(event:Event)
		{
			
		}
		
	}
}