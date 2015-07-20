package  {
	
	import flash.display.MovieClip;
	
	
	public class spriteCogwheel extends baseAnimationEnemy {
		
		
		public function spriteCogwheel() {
			// constructor code
			var animArray:Array = [new structAnimation(1, 2, "GO_LEFT"),
								   new structAnimation(1, 2, "GO_RIGHT"),
								   new structAnimation(4, 1, "DIE_LEFT"),
								   new structAnimation(4, 1, "DIE_RIGHT"),
								   new structAnimation(1, 1, "IDLE_LEFT"),
								   new structAnimation(1, 1, "IDLE_RIGHT")];
			super(animArray, 24);
		}
	}
	
}
