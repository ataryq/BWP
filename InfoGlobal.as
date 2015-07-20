package  {
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class InfoGlobal extends Sprite {
		public static var cointNum:Number = 0;
		public static var fineDied:Number = 15;
		public static var money:Number = 0;
		public static const Name:String = "InfoGlobal";
		public static var nextLevelFileName:String;
		public static var EndLevel:Function;
		public static var gameSetting:GameSetting = new GameSetting();
		public static var currentPhase:Number = 1;
		public static var finishGame:Boolean = false;
		public static var NeedMoneyForEnd:Number = 100;
		
		public static var currentLevel:Number = 1;
		
		public function InfoGlobal() 
		{
			// constructor code
			this.name = Name;
		}
		
		public static function SetNextLevel(nextLvlStr:String, nextLvlNum:Number)
		{
			
		}
		
		public static function GetInfoGlobal(_stage):InfoGlobal
		{
			var info:InfoGlobal = _stage.getChildByName(Name) as InfoGlobal;
			if(!info) {
				trace("create InfoGlobal");
				info = new InfoGlobal();
				_stage.addChild(info);
			}
			return info;
		}
		
		public function Reset():void
		{
			InfoGlobal.cointNum = 0;
			InfoGlobal.money = 0;
		}
	}
	
}
