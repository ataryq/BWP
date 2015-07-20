package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class CounterMoney extends MovieClip 
	{
		protected var fieldCounterMoney:TextField;
		protected var formatCounterMoney:TextFormat;
		protected var globalInfo:InfoGlobal;
		
		public function CounterMoney() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE ,addStage);
			InitText();
		}
		
		protected function addStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE ,addStage);
			globalInfo = InfoGlobal.GetInfoGlobal(stage);
			Update();
		}
			
		public function GetMoney():Number
		{
			return InfoGlobal.money;
		}
		
		public function SetMoney(_money:Number):void
		{
			InfoGlobal.money = _money;
		}
		
		public function AddMoney(_money:Number):void
		{
			InfoGlobal.money += _money;
			Update();
			this.gotoAndPlay(2);
		}
		
		public function Update():void
		{
			fieldCounterMoney.text = InfoGlobal.money.toString();
			fieldCounterMoney.setTextFormat(formatCounterMoney);
		}
		
		protected function InitText():void
		{
			fieldCounterMoney = new TextField();
			formatCounterMoney = new TextFormat();
			//Engravers MT			
			formatCounterMoney.font = "Franklin Gothic Demi";
			formatCounterMoney.size = 20;
			formatCounterMoney.color = 0xFFFF00;
			fieldCounterMoney.width = 80;
			fieldCounterMoney.selectable = false;
			fieldCounterMoney.setTextFormat(formatCounterMoney);
			fieldCounterMoney.x = 0;
			fieldCounterMoney.y = -15;
			this.addChild(fieldCounterMoney);
			//speakField.visible = false;
		}
	}
	
}
