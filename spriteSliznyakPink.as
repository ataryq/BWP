package  {
	import flash.display.MovieClip;	
	public class spriteSliznyakPink extends baseAnimationEnemy 
	{
		
		public function spriteSliznyakPink()
		{
			// constructor code
			var animArray:Array = [new structAnimation(1, 49, "GO_LEFT"),
								   new structAnimation(52, 49, "GO_RIGHT"),
								   new structAnimation(104, 1, "DIE_LEFT"),
								   new structAnimation(105, 1, "DIE_RIGHT"),
								   new structAnimation(107, 1, "IDLE_LEFT"),
								   new structAnimation(108, 1, "IDLE_RIGHT")];
			super(animArray, 30);
			this.y -= 5;
		}
	}
	
}
