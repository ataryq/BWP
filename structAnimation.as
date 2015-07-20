package  {
	import flash.display.MovieClip;
	
	public class structAnimation 
	{
		protected var startAnim:Number;
		protected var numFrame:Number;
		protected var curFrame:Number;
		protected var name:String;
		
		public function structAnimation(_startAnim:Number, 
										_numFrame:Number, 
										_name:String = "non") 
		{
			// constructor code
			startAnim = _startAnim;
			numFrame = _numFrame;
			name = _name;
		}
		
		public function playAnim(anim:MovieClip):void
		{
			curFrame = anim.currentFrame;
			if((curFrame < startAnim + numFrame - 1) && (curFrame >= startAnim))
				anim.gotoAndStop(curFrame + 1);
			else 
				anim.gotoAndStop(startAnim);
		}

	}
}