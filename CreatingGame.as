package  
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CreatingGame extends MovieClip
	{
		private var creatingStage:CreatingStage;
		private var btnBack;
		
		public function CreatingGame() 
		{
			// constructor code
			creatingStage = new CreatingStage();
			addChild(creatingStage);
			InfoGlobal.EndLevel = FinishLevel;
			
			btnBack = new BackMenuBtn();
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.addChild(btnBack);
			btnBack.addEventListener(MouseEvent.CLICK, EndGame);
			btnBack.x = 10;
			btnBack.y = 500;
		}
		
		public function EndGame(event:Event = null):void
		{
			if(stage.contains(btnBack)) stage.removeChild(btnBack);
			if(this.creatingStage) this.creatingStage.DeleteStage();
			for(var i:uint = this.numChildren; i < this.numChildren; i++) this.removeChildAt(0);
			(this.parent as MovieClip).gotoAndStop(1);
			ControlMusic.StopLevelMusic(InfoGlobal.currentPhase);
			
			this.parent.removeChild(this);
		}
		
		public function FinishLevel(contact:b2Contact = null):void
		{
			if(stage.contains(btnBack)) stage.removeChild(btnBack);
			informBlockListPlatform.GetInformBlock(stage).toolBar.dialogField.SetText("Уровень пройден!");
			informBlockListPlatform.GetInformBlock(stage).toolBar.dialogField.ShowPanel();
			ControlMusic.StartFinishLevelMusic();
			ControlMusic.QuietLevelMusic(InfoGlobal.currentPhase);
			var timer:Timer = new Timer(4000, 1);
			timer.addEventListener(TimerEvent.TIMER, GoNextLevel);
			timer.start();
			if(InfoGlobal.nextLevelFileName == new String("level" + (InfoGlobal.currentLevel + 1).toString() + ".xml"))
				InfoGlobal.currentLevel++;
			informBlockListPlatform.GetInformBlock(stage).player.accessAction = false;
		}
		
		protected function CheckVideo():Boolean
		{
			var Parent = this.parent;
			
			if(InfoGlobal.nextLevelFileName == "movie1") {
				EndGame();
				(Parent as MovieClip).gotoAndStop(2);
				return true;
			}
			else if(InfoGlobal.nextLevelFileName == "movie2") {
				EndGame();
				(Parent as MovieClip).gotoAndStop(3);
				return true;
			}
			else if(InfoGlobal.nextLevelFileName == "END") {
				EndGame();
				(Parent as MovieClip).gotoAndStop(4);
				return true;
			}
			return false;
		}
		
		
		public function GoNextLevel(event:Event = null):void
		{
			ControlMusic.NormalLevelMusic(InfoGlobal.currentPhase);
			if( CheckVideo() ) return;
			
			ControlMusic.StopMenuMusic();
			
			this.creatingStage.DeleteStage();
			for(var i:uint = this.numChildren; i < this.numChildren; i++) this.removeChildAt(0);
			addChild(creatingStage);
			trace(InfoGlobal.nextLevelFileName);
			
			if(InfoGlobal.nextLevelFileName != "END") 
				this.creatingStage.CreateStage("mapCreater\\maps\\" + InfoGlobal.nextLevelFileName);
			else trace("end Game");
			if(!stage.contains(btnBack)) stage.addChild(btnBack);
		}

	}
	
}
