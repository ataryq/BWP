package  {
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2Fixture;
	
	public class Sword extends Weapon {
		public function Sword() {
			// constructor code
			this.rotation = 30;
		}
		
		public override function Atack(_side:Boolean):void
		{
			this.gotoAndPlay(2);
			var fixture:b2Fixture = rayCast(_side);
			if(fixture) 
			{
				if(!fixture.GetBody()) return;
				if(fixture.GetBody().GetUserData().enemy) {
					fixture.GetBody().GetUserData().reference.Die();
				}
			}
		}
		
		public override function retStartState():void
		{
			if(this.currentFrame < 11) return;
			this.gotoAndStop(1);
		}
		
		public override function onBack():void
		{
			this.gotoAndStop(11);
		}
		
		public function Delete_Sword():void
		{
			
		}
	}
	
}
