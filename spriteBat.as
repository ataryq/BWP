package  {
	
	import flash.display.MovieClip;
	
	public class spriteBat extends baseAnimationEnemy {
		
		public function spriteBat() 
		{
			// constructor code
			var animArray:Array = [new structAnimation(1, 29, "GO_LEFT"),
								   new structAnimation(31, 29, "GO_RIGHT"),
								   new structAnimation(64, 1, "DIE_LEFT"),
								   new structAnimation(65, 1, "DIE_RIGHT"),
								   new structAnimation(61, 1, "IDLE_LEFT"),
								   new structAnimation(62, 1, "IDLE_RIGHT")];
			super(animArray, 60);
		}
	}
}