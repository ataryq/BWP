package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ToolBar extends Sprite 
	{
		public var counterMoney:CounterMoney;
		public var counterLives:CounterLives;
		public var dialogField:FieldText;
		public var itemField:Item;
		public var forceJumpLine:ForceJumpLine;
		protected var info:informBlockListPlatform;
		
		public function ToolBar() 
		{
			// constructor code
			InitCounterMoney();
			InitCounterLives();
			InitDialogField();
			InitItemField();
			//InitForceJumpLine();
			if(stage) addStage();
			else this.addEventListener(Event.ADDED_TO_STAGE, addStage);
			
		}
		
		public function Delete():void
		{
			this.parent.removeChild(this);
		}
		
		public function addStage(event:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			info = informBlockListPlatform.GetInformBlock(stage);
			info.toolBar = this;
		}
		
		protected function InitForceJumpLine():void
		{
			forceJumpLine = new ForceJumpLine();
			addChild(forceJumpLine);
			forceJumpLine.x = 780;
			forceJumpLine.y = 280;
		}
		
		protected function InitCounterLives():void
		{
			counterLives = new CounterLives();
			addChild(counterLives);
			counterLives.x = 380;
			counterLives.y = 50;
		}
		
		protected function InitCounterMoney():void
		{
			counterMoney = new CounterMoney();
			addChild(counterMoney);
			counterMoney.x = 130;
			counterMoney.y = 50;
		}
		
		protected function InitDialogField():void
		{
			dialogField = new FieldText();
			addChild(dialogField);
			dialogField.y = 400;
			dialogField.x = 10;
		}
		
		protected function InitItemField():void
		{
			itemField = new Item();
			addChild(itemField);
			itemField.x = 720;
			itemField.y = 50;
		}
		
		public function Update():void
		{
			
		}
	}
}
