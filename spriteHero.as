package  {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class spriteHero extends MovieClip {
				
		private var anim:Number = 0;
		private var timer:Timer;
		private var curFramePerSec:Number;
		public var _change:Boolean = true;
		
		public static const IDLE_LEFT:Number = 0;
		public static const IDLE_RIGHT:Number = 1;
		public static const GO_LEFT:Number = 2;
		public static const GO_RIGHT:Number = 3;
		public static const JUMP_RIGHT:Number = 4;
		public static const JUMP_LEFT:Number = 5;
		public static const CLIMB:Number = 6;
		public static const IDLE_CLIMB:Number = 7;
		
		private const idle_start:Number = 1;
		private const go_right_start:Number = 6;
		private const jump_right_start:Number = 11;
		private const climb_start:Number = 14;
		
		private const idle_weapon_start:Number = 3;
		private const go_right_weapon_start:Number = 8;
		private const jump_right_weapon_start:Number = 12;
		
		private var idle:Number = 1;
		private var go_right:Number = 6;
		private var jump_right:Number = 11; 
		private var climb:Number = 14;
		
		public function addWeapon():void
		{
			idle = idle_weapon_start;
			go_right = go_right_weapon_start;
			jump_right = jump_right_weapon_start;
		}
		
		public function removeWeapon():void
		{
			idle = idle_start;
			go_right = go_right_start;
			jump_right = jump_right_start;
		}
		
		public function spriteHero(_curFramePerSec:Number = 6) {
			// constructor code
			curFramePerSec = _curFramePerSec;
			SetTimer(_curFramePerSec);
			timer.addEventListener(TimerEvent.TIMER, playAnimation);
			
		}
		
		public function SetTimer(deley:Number):void {
			timer = new Timer(1000 / deley);
			timer.start();
		}
		
		private function playAnimation(event:Event):void {
			var curFrame:Number = this.currentFrame;
			if(anim == GO_LEFT || anim == JUMP_LEFT || anim == IDLE_LEFT)
				this.rotationY = 180;
			else this.rotationY = 0;
				
			switch(anim)
			{
				case IDLE_RIGHT:
				case IDLE_LEFT: 
				{
					if(curFrame == idle) this.gotoAndStop(curFrame +  1);
					else this.gotoAndStop(idle);
				} break;
				case GO_LEFT: 
				case GO_RIGHT: 
				{
					if(curFrame == go_right) this.gotoAndStop(curFrame + 1);
					else this.gotoAndStop(go_right);
				} break;
				case JUMP_LEFT: 
				case JUMP_RIGHT: 
				{
					this.gotoAndStop(jump_right);
				} break;
				case CLIMB:
				{
					if(curFrame == climb) this.gotoAndStop(curFrame + 1);
					else this.gotoAndStop(climb);
				} break;
				case IDLE_CLIMB:
				{
					this.gotoAndStop(climb);
				} break;
				default: trace("error animation hero");
			}
		}
		
		public function SetAnimation(_anim:Number) {
			anim = _anim;
		}
		
		public function GetAnimation():Number {
			return anim;
		}
	}
}
