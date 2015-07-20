package  {
	
	import flash.display.MovieClip;
	
	
	public class baseWater extends SpecificBlock {
		
		public function baseWater() {
			// constructor code
			if(informBlockListPlatform.WORK == informBlockListPlatform.RELEASE) 
				this.visible = false;
			super(SpecificBlock.WaterBehavior);
		}
	}
	
}
