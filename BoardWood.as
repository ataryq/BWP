package  {
	
	import flash.display.MovieClip;
	
	
	public class BoardWood extends MovieClip {
		
		public var closeByBoard:Boolean = false;
		public function BoardWood() {
			// constructor code
		}
		
		public function Close():void
		{
			closeByBoard = true;
			this.gotoAndStop(2);
		}
		
		public function Open():void
		{
			closeByBoard = false;
			this.gotoAndStop(1);
		}
	}
	
}
