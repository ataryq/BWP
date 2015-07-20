package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class GunYelMini extends Weapon {
		private const maxRoot:Number = 60;
		private const minRoot:Number = -60;
		private const rBul:Number = 5;
		private const indentHeroBulX:Number = 40;
		private const indentHeroBulY:Number = -5;
		private var angle:Number;
		
		public function GunYelMini() {
			// constructor code
		}
		
		override public function Atack(_side:Boolean):void
		{
			this.play();
			var indentX:Number = indentHeroBulX;
			var indentY:Number = indentHeroBulY;
			if(!_side) {
				indentX = -indentX;
				indentY = -indentY;
			}
			var bullet:bulletSmall = new bulletSmall(
												createWorld.createDynamicCircle(
														player.GetWorldPosition().x * CreateWorld.SCALE + indentX,
														player.GetWorldPosition().y * CreateWorld.SCALE + indentY,
														rBul),
												this.rotation,
												_side);
			this.player.parent.addChild(bullet);
		}
		
		override public function retStartState():void
		{
			this.gotoAndStop(1);
		}
		
		override public function onBack():void{
			this.gotoAndStop(4);
		}
		
		override public function Update(side:Boolean):void
		{
			var r:Point = this.localToGlobal(new Point(0.0, 0.0));
			var rX:Number;
			var rY:Number;
				rX = stage.mouseX - r.x;
				rY = stage.mouseY - r.y;
			
			angle = Math.atan2(rY, rX) * 180 / Math.PI;
			if(side) {
				if(angle < maxRoot && angle > minRoot)
					this.rotation = angle;
			} else {
				if(angle > maxRoot + 90 || angle < minRoot - 90)
					this.rotation = (-angle + 180);
			}
		}
	}
	
}
