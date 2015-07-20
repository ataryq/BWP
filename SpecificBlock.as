package  {
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SpecificBlock extends MovieClip{
		protected var funct:Function = null;
		
		public function SpecificBlock(_funct:Function) {
			// constructor code
			funct = _funct;
			if(stage) addStage(null);
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event = null):void {
			if(event != null) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			addFunction();
		}
		
		protected function addFunction():void {
			if(funct == null) return;
			var informBlock;
			if(!stage.getChildByName("infomBlockListPlatform")) 
			{
				informBlock = new informBlockListPlatform();
				stage.addChild(informBlock);
			}
			informBlock = stage.getChildByName("infomBlockListPlatform");
			informBlock.AddSpecificBlock(new structSpecificBlock(this.width, 
																 this.height, 
																 new Point(this.x, this.y), 
																 funct, 
																 this.rotation));
		}
		
		// компенсация силы притяжения, силлой действующей снизу
		public static function NonForceAttractingPlayer(_fixture:b2Fixture):Boolean 
		{
			if(_fixture.GetBody().GetType() == b2Body.b2_staticBody) return true;
			_fixture.GetBody().ApplyForce(new b2Vec2(0, -40 * _fixture.GetBody().GetMass()), 
													 _fixture.GetBody().GetWorldCenter());
													 
			return true;
		}
		
		public static function WaterBehavior(_fixture:b2Fixture):Boolean
		{
			if(_fixture.GetBody().GetType() == b2Body.b2_staticBody) return true;
			_fixture.GetBody().ApplyForce(new b2Vec2(0, -10 * _fixture.GetBody().GetMass()), 
													 _fixture.GetBody().GetWorldCenter());
			if(_fixture.GetBody().GetUserData()) {
				if(_fixture.GetBody().GetUserData().name == "hero")
				{
					_fixture.GetBody().GetUserData().reference.speed *= 0.5;
					(_fixture.GetBody().GetUserData().reference as Player).forceJump *= 1.2;
				}
			}
			return true;
		}
	}
	
}
