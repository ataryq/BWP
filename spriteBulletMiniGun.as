package  {
	
	import flash.display.MovieClip;
	
	
	public class spriteBulletMiniGun extends MovieClip {
		
		
		public function spriteBulletMiniGun() {
			// constructor code
		}
		
		public function Delete():void
		{
			this.parent.removeChild(this);
		}
	}
	
}
