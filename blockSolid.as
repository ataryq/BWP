package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class blockSolid extends basePlatform {
		private var h:Number;
		private var w:Number;
		public function blockSolid(_h:Number = 0, _w:Number = 0, _loc:Point = null, _rotat:Number = 0) {
			// constructor code
			if(_w == 0 || _h == 0)
			{
				h = 50 * this.scaleX;
				w = 50 * this.scaleY;
			} else
			{
				h = _h;
				w = _w;
			}
			
			if(_loc)
			{
				this.x = _loc.x;
				this.y = _loc.y;
			}
			
			if(rotation != 0) this.rotation = _rotat;
			
			if(informBlockListPlatform.WORK == informBlockListPlatform.RELEASE)
				this.visible = false;
			super(true);
		}
		
		protected override function addStage(event:Event = null):void {
			if(event != null) this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			CreateStaticPlatform(h, w);		
		}
	}
	
}
