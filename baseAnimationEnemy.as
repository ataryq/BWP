package  {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class baseAnimationEnemy extends MovieClip 
	{
		private var timer:Timer
		private var delay:Number;
		protected var anim:Number = IDLE_RIGHT;
		protected var animArray:Array = null;
		public var lastDir:Boolean;
		
		public function baseAnimationEnemy(_animArray:Array, _delay = 3) {
			// constructor code
			delay = _delay;
			animArray = _animArray;
			timer = new Timer(1000 / delay);
			timer.addEventListener(TimerEvent.TIMER, playAnimation);
			timer.start();
		}
		
		public static const MOVE_LEFT:Number = 0;
		public static const MOVE_RIGHT:Number = 1;
		public static const DIE_RIGHT:Number = 2;
		public static const DIE_LEFT:Number = 3;
		public static const IDLE_LEFT:Number = 4;
		public static const IDLE_RIGHT:Number = 5;
		
		public function playAnimation(event:Event):void
		{
			if(anim == MOVE_LEFT || anim == IDLE_LEFT) this.lastDir = false;
			else this.lastDir = true;
			(animArray[anim] as structAnimation).playAnim(this);
		}
		
		public function SetAnim(_anim:Number)
		{
			anim = _anim;
		}
		
		public function SetAnimIndleRootInLasdDir():void
		{
			if(this.anim == MOVE_RIGHT || IDLE_RIGHT) anim = IDLE_RIGHT;
			else anim = IDLE_LEFT;
		}
		
		public function GetAnim():Number
		{
			return this.anim;
		}
		public function DeleteBaseAnimEnemy():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, playAnimation);
		}
	}
}
