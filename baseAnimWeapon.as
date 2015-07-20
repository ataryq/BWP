package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class baseAnimWeapon extends MovieClip
	{
		protected var animArray:Array;
		private var timer:Timer;
		protected var anim:Number = 0;
		
		public function baseAnimWeapon(_animArray:Array = null, _delay:Number = 3) {
			// constructor code
			if(!_animArray) return;
			animArray = _animArray;
			timer = new Timer(1000 / _delay);
			timer.addEventListener(TimerEvent.TIMER, playAnimation);
			timer.start();
		}
		
		private function playAnimation(event:Event):void
		{
			(animArray[anim] as structAnimation).playAnim(this);
		}
		
		public function SetAnim(_anim:Number)
		{
			anim = _anim;
		}
		
		public function Delete_base_anim():void
		{
			
		}
		
	}
}
