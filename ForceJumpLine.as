package  {
	
	import flash.display.MovieClip;
	
	
	public class ForceJumpLine extends MovieClip {
		
		
		public function ForceJumpLine() {
			// constructor code
		}
		
		public function GoNextFrame():void
		{
			this.gotoAndStop(this.currentFrame + 1);
		}
		
	}
	
}
