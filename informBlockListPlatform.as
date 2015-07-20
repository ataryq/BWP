package  {
	import flash.display.Sprite;
	import flash.geom.Point;
	import Box2D.Dynamics.b2World;
	import flash.events.Event;
	
	public class informBlockListPlatform extends Sprite
	{
		public var listStaticSolidPlatform:Array = new Array();
		public var listSpecificBlock:Array = new Array();
		public var listKinematicBlock:Array = new Array();
		public var world:b2World = null;
		public var player:Player;
		public var createWorld:CreateWorld = null
		public var contactListener:ContactLisener;
		public var game:Game;
		public var toolBar:ToolBar;
		public var WORK:Boolean = Game.DEBUG;
		
		public static const WORK:Number = RELEASE;
		public static const DEBUG:Number = 0;
		public static const RELEASE:Number = 1;
		
		public function informBlockListPlatform() {
			// constructor code
			this.name = "infomBlockListPlatform";
			trace("create infomBlockListPlatform");
			contactListener = new ContactLisener();
			toolBar = new ToolBar();
		}
		
		public static function GetInformBlock(_stage):informBlockListPlatform
		{
			var info:informBlockListPlatform = _stage.getChildByName("infomBlockListPlatform") as informBlockListPlatform;
			if(!info) {
				info = new informBlockListPlatform();
				_stage.addChild(info);
			}
			return info;
		}
		
		protected function init():void
		{
			
		}
		
		public function AddSpecificBlock(block:structSpecificBlock):void {
			
			listSpecificBlock.push(block);
		}
		
		public function AddStaticPlatform(platform:structPlatform):void {
			listStaticSolidPlatform.push(platform);
		}
		
		public function AddKinematicBody(platform:structKinematicBody):void {
			listKinematicBlock.push(platform);
		}
		
		public function AllTrace():void {
			for(var i:int; i < listStaticSolidPlatform.length; i++) {
				trace(listStaticSolidPlatform[i].loc.x + " " + listStaticSolidPlatform[i].loc.y);
			}
		}
	}
}
