package  {
	
	import flash.display.MovieClip;
	
	public class spriteFly extends baseAnimationEnemy {
		
		
		public function spriteFly() {
			// constructor code
			var animArray:Array = [new structAnimation(1, 2, "GO_LEFT"),
								   new structAnimation(4, 2, "GO_RIGHT"),
								   new structAnimation(7, 1, "DIE_LEFT"),
								   new structAnimation(8, 1, "DIE_RIGHT"),
								   new structAnimation(1, 1, "IDLE_LEFT"),
								   new structAnimation(4, 1, "IDLE_RIGHT")];
			super(animArray, 45);
		}
	}
	
}
