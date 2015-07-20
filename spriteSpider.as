package  {
	
	import flash.display.MovieClip;
	
	
	public class spriteSpider extends baseAnimationEnemy {
		
		
		public function spriteSpider() {
			// constructor code
			super([new structAnimation(1, 3, "GO_LEFT"),
				   new structAnimation(5, 3, "GO_RIGHT"),
				   new structAnimation(9, 1, "DIE_LEFT"),
				   new structAnimation(10, 1, "DIE_RIGHT"),
				   new structAnimation(1, 1, "IDLE_LEFT"),
				   new structAnimation(5, 1, "IDLE_RIGHT")],
				   10);
		}
	}
	
}
