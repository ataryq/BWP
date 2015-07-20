
package  {
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2World;
	import flash.events.Event;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	
	public class Weapon extends MovieClip {
		protected var world:b2World;
		protected var createWorld:CreateWorld;
		protected var isAtack:Boolean = false;
		protected var player:Player;
		public function Weapon() {
			// constructor code
			this.rotation = 45;
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			player =(stage.getChildByName("infomBlockListPlatform") as informBlockListPlatform).player;
			world = (stage.getChildByName("infomBlockListPlatform") as informBlockListPlatform).world;
			createWorld = (stage.getChildByName("infomBlockListPlatform") as informBlockListPlatform).createWorld;
		}
		
		public function Atack(_side:Boolean):void{}
		public function retStartState():void{}
		public function onBack():void{}
		public function switchOff():void {
			this.visible = false;
		}
		
		public function switchOn():void {
			this.visible = true;
		}
		
		protected const radius:Number = 60 / CreateWorld.SCALE;
		protected function rayCast(_side:Boolean):b2Fixture
		{			
			var radiusY:Number = 35 / CreateWorld.SCALE;
			var radiusX:Number = radius;
			if(!_side) radiusX = -radius;
			
			var original:b2Vec2 = player.GetWorldPosition().Copy();
			var side:b2Vec2 = original.Copy();
			var sideDown:b2Vec2 = original.Copy();
			var sideUp:b2Vec2 = original.Copy();
			
			side.x += radiusX;
			sideDown.x += radiusX;
			sideDown.y -= radiusY;
			sideUp.x += radiusX;
			sideUp.y += radiusY;
			
			var raySide:b2Fixture = world.RayCastOne(original, side);
			var raySideDown:b2Fixture = world.RayCastOne(original, sideDown);
			var raySideUp:b2Fixture = world.RayCastOne(original, sideUp);
			
			if(raySide) return raySide;
			if(raySideDown) return raySideDown;
			if(raySideUp) return raySideUp;
			return null;
		}
		
		public function Update(_side:Boolean):void {}
		
		public function Delete_Weapson():void
		{
			
		}
		
	}
}
