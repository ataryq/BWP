package  {
	import flash.display.MovieClip;
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
	import flash.sensors.Accelerometer;
	
	public class Game extends MovieClip 
	{
		public var WORK:Boolean = RELEASE;
		public static const DEBUG:Boolean = true;
		public static const RELEASE:Boolean = false;
		public var finishGame:Boolean = false;
		public var restartGame:Boolean = false;
				
		var locationW:Number = 3000;
		var locationH:Number = 1500;
		var stageW:Number = 800;
		var stageH:Number = 600;
		var scale_x:Number = 0.7;
		var scale_y:Number = 0.7;
		
		public var startPosPlayer:Point;
		
		public var createWorld:CreateWorld;
		public var player:gamePlayer;
		public var info:informBlockListPlatform;
		public var toolBar:ToolBar;
		private var arrayEnemy:Array;
		
		public var restartPlayer:Boolean = false;
		
		public function Game() 
		{
			// constructor code
			if(!stage) this.addEventListener(Event.ADDED_TO_STAGE, addStage);
			else addStage();
		}
		
		public function DeleteGame():void
		{
			this.removeEventListener(Event.ENTER_FRAME, Update);
			
			for(var i:uint; i < arrayEnemy.length; i++)
			{
				try {arrayEnemy[i].Die();}
				catch(error:Error){}
			}
			this.removeChild(this.createWorld);
			player.DeletePlayer();
			this.removeChild(this.player);
			stage.removeChild(info);
			toolBar.Delete();
			this.parent.removeChild(this);
		}
		
		protected function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			init();
			this.addEventListener(Event.ENTER_FRAME, Update);
		}
				
		function init():void
		{
			this.parent.scaleX = this.scale_x;
			this.parent.scaleY = this.scale_y;
			
			info = informBlockListPlatform.GetInformBlock(stage);
			info.game = this;
			createWorld = new CreateWorld(locationW, locationH);
			if(WORK) createWorld.addDebugDraw();
			createWorld.world.SetContactListener(info.contactListener);
			info.contactListener.addFunction(CollisionWithWalls);
			initContactListenerWithEnemy();
			
			addChildAt(createWorld, 0);
			
			arrayEnemy = new Array();
			player = new gamePlayer(info, startPosPlayer);
			//if(!this.WORK) player.accessMoveUp = false;
			//if(!this.WORK) player.accessMoveDown = false;
			addChild(player);
			toolBar = new ToolBar();
			stage.addChild(this.toolBar);
			info.toolBar = toolBar;
			trace(InfoGlobal.cointNum);
		}
		
		public function DiedPlayer():void
		{
			//this.restartGame = true;
			this.restartPlayer = true;
			info.toolBar.dialogField.SetText("История осталась незавершенной...");
			info.toolBar.dialogField.ShowPanel();
			if( (InfoGlobal.money - InfoGlobal.fineDied) > 0 ) InfoGlobal.money -= InfoGlobal.fineDied;
			informBlockListPlatform.GetInformBlock(stage).toolBar.counterLives.SetHealth();
			informBlockListPlatform.GetInformBlock(stage).toolBar.counterMoney.Update();
		}
		
		public function initContactListenerWithEnemy():void
		{
			info.contactListener.addFunction(Cogwheel.CollisionWithHidrance);
		}
		
		public function CollisionWithWalls(contact:b2Contact):void
		{
			if(gamePlayer.CheckObject(contact) &&
			   (contact.GetFixtureA().GetBody().GetUserData().wall || 
			   contact.GetFixtureB().GetBody().GetUserData().wall)) 
			{
				DiedPlayer();
			}
		}
		
		public function RestartPlayer():void
		{
			this.restartPlayer = false;
			player.DeletePlayer();
			this.removeChild(player);
			player = new gamePlayer(info, startPosPlayer);
			this.addChild(player);
		}
		
		public function addEnemy(enemy:Object):void
		{
			this.arrayEnemy.push(enemy);
		}
		
		function Update(event:Event):void 
		{
			if(restartPlayer) this.RestartPlayer();
			createWorld.UpdateWorld(event);
			this.player.game_Update(event);
			UpdateScreen();
			toolBar.Update();
		}

		public function CompleteGame():void
		{
			
			info.toolBar.dialogField.SetText("Игра пройдена!");
			info.toolBar.dialogField.ShowPanel();
			this.finishGame = true;
		}
		
		protected function UpdateScreen():void
		{
			var playerPosition:b2Vec2 = player.GetPosition();
			
			playerPosition.x *= CreateWorld.SCALE;
			playerPosition.y *= CreateWorld.SCALE;
			
			if(this.parent) this.parent.x = -playerPosition.x * this.scale_x + stageW / 2;
			if(this.parent) this.parent.y = -playerPosition.y * this.scale_y + stageH / 2;
		}
	}
	
}
