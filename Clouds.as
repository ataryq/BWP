package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class Clouds extends MovieClip {
		private var speed:Number = 0.3;
		
		private const LBor:Number = 3000.0;
		
		public function Clouds() {
			// constructor code
			speed = Math.random() * 0.3 + 0.1;
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event):void
		{
			try
			{ 
				this.addEventListener(Event.ENTER_FRAME, Update);
				trace(int(Math.random()*3 + 1));
				this.gotoAndStop(int(Math.random()*3 + 1))
			}
			catch(er:Error){trace("Error Clouds.as");}
		}
		
		private function Update(event:Event)
		{
			//if(!stage) Delete();
			if(this.x > 1200) this.x = -100;
			this.x += this.speed;
		}
		
		private function Delete()
		{
			this.removeEventListener(Event.ENTER_FRAME, Update);
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			if(stage) stage.removeChild(this);
		}
	}
	
}
