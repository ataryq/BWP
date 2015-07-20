package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Behaviours extends MovieClip{

		public function Behaviours(_body:b2Body,
								   _speedVec:b2Vec2) 
		{
			// constructor code
			body = _body;
			if(!_speedVec) speedVec = b2Vec2.Make(3, 3);
			else speedVec = _speedVec;
			speedX = speedVec.x;
			try {
				sprite = body.GetUserData().sprite as baseAnimationEnemy;
			} 
			catch(error:Error){}
			
		}
		
		protected var body:b2Body;
		protected var speedX:Number;
		protected var speedVec:b2Vec2;
		protected var sprite:baseAnimationEnemy;
		
		protected var GotoPlayer:BehaviourGotoPlayer;
		protected var MoveOnLine:BehaviourMoveOnLine;
		protected var OvercomingJump:behaviurOvercomingJump;
		protected var RotateToBody:BehaviourRotateToBody;
		protected var Shot:BehaviourShot;
		
		protected var addGotoPlayer:Boolean = false;
		protected var addMoveOnLine:Boolean = false;
		protected var addOvercomingJump:Boolean = false;
		protected var addRotateToBody:Boolean = false;
		protected var addShot:Boolean = false;
		
		public function AddGotoPlayer(_maxDistP:b2Vec2,
									  _minDinsP:b2Vec2 = null,
									  _player:Player = null):void
		{
			addGotoPlayer = true;
			var player:Player = _player;
			if(!player) {
				if(!stage) trace("error/get stage/gotoPlayer/Behaviours");
				else player = stage.getChildByName("hero") as Player;
			}
			if(!player) {
				trace("error/get player/gotoPlayer/Behaviours");
				return;
			}

			GotoPlayer = new BehaviourGotoPlayer(_maxDistP, this.body, this.speedVec, player, _minDinsP);
		}
		
		public function AddMoveOnLine(_wayLeftBorder:b2Vec2,
									  _wayRightBorder:b2Vec2):void
		{
			addMoveOnLine = true;
			MoveOnLine = new BehaviourMoveOnLine(_wayLeftBorder,
												 _wayRightBorder,
												 body,
												 speedVec);
		}
		
		public function AddOvercomingJump( _originalForceJump:Number = -50,
											   _deltaForceJump:Number = -10,
											   _numFrameWaiting:Number = 60):void
		{
			OvercomingJump = new behaviurOvercomingJump(body,
														_originalForceJump,
											   			_deltaForceJump,
											   			_numFrameWaiting);
			addOvercomingJump = true;
		}
		
		public function AddRotateToBody(_bodyB:b2Body,
										_firstReg:b2Vec2 = null,
										_secondReg:b2Vec2 = null,
										_speedRotate:Number = 1 / 60,
										_fullRotate:Boolean = false):void
		{
			addRotateToBody = true;
			RotateToBody = new BehaviourRotateToBody(this.body, 
													 _bodyB, 
													 _firstReg,
													 _secondReg,
													 _speedRotate,
													 _fullRotate);
		}
		
		public function AddShot(_world:CreateWorld,
								_impulsBullet:b2Vec2,
								_body:b2Body = null,
								_frameWaiting:Number = 15):void
		{
			addShot = true;
			Shot = new BehaviourShot(_world, this.body, _impulsBullet, _frameWaiting);
			addChild(Shot);
		}
		
		public function Stop():void
		{
			
		}
		
		public function Update():void
		{
			if(addMoveOnLine) MoveOnLine.Update();
			if(addGotoPlayer) GotoPlayer.Update();
			if(addOvercomingJump) OvercomingJump.Update();
			if(addRotateToBody) RotateToBody.Update();
			if(addShot) Shot.Update();
		}
	}
}
