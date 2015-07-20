package  {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;

	
	public class basePlatform extends MovieClip{
		protected var _density:Number = 1;
		
		public function basePlatform(addSolidKarkas:Boolean = true) {
			// constructor code
			
			if(!addSolidKarkas) return;
			if(stage) addStage(null);
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		protected function addStage(event:Event = null):void {
			if(event != null) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			CreateStaticPlatform(this.width, 5);
		}
		
		protected function CreateStaticPlatform(_w:Number, _h:Number):void {
			/*
			var informBlock:informBlockListPlatform = informBlockListPlatform.GetInformBlock(stage);
			informBlock.AddStaticPlatform(new structPlatform(_w,
															 _h, 
															 new Point(this.x, this.y), 
															 this.rotation / 180 * Math.PI, 
															 _density));
															 */
		}

	}
	
}
