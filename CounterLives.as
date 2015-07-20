package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class CounterLives extends MovieClip 
	{
		public var lives:Number = 6;
		public var info:informBlockListPlatform;
		public static var MAX_LIVES:Number = 6;
		
		public function CounterLives() 
		{
			// constructor code
			Update();
			if(stage) addStage();
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		public function addStage(event:Event = null):void
		{
			if(event) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
		}
		
		public function SetHealth(_lives:Number = 6):void
		{
			if(_lives >= MAX_LIVES) this.lives = MAX_LIVES;
			else if(_lives <= 0) this.lives = 0;
			lives = _lives;
			Update();
		}
		
		public function SubstractLive(_lives:Number = 1):Boolean
		{
			if(lives - _lives >= MAX_LIVES) lives = MAX_LIVES;
			if(lives - _lives <= 0) {
				trace("history not finished...");
				if(info) if(info.game) info.game.DiedPlayer();
				return false;
			}  else
			{
				lives -= _lives;
				Update();
			}
			return true;
		}
				
		public function Update(event:Event = null):void
		{
			if(lives > MAX_LIVES || lives < 0)  {
				trace("error");
			}
			else this.gotoAndStop(lives + 1);
		}
		
	}
}
