package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	import Box2D.Common.Math.b2Vec2;
	
	public class DyanmicThorns extends DamgeBlock 
	{
		private var behaviur:Behaviours;
		protected var speed:b2Vec2;
		protected var wayLeft:b2Vec2;
		protected var wayRight:b2Vec2;
		
		public function DyanmicThorns(X:Number,
									  Y:Number,
									  _wayLeft:b2Vec2,
									  _wayRight:b2Vec2,
									  _speed:b2Vec2 = null)
		{
			// constructor code
			if(_speed) speed = _speed;
			else speed = new b2Vec2(0, 3);
			wayLeft = _wayLeft;
			wayRight = _wayRight;
			
			super(60, 60, new Point(X, Y));
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			this.addEventListener(Event.ENTER_FRAME, Update);
			behaviur = new Behaviours(this.body, speed);
			behaviur.AddMoveOnLine(wayLeft, wayRight);
		}
		
		protected function Update(event:Event):void
		{
			if(!stage) this.removeEventListener(Event.ENTER_FRAME, Update);
			behaviur.Update();
		}
	}
	
}
