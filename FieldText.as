
package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class FieldText extends MovieClip {
		protected var speakField:TextField;
		protected var speakFormat:TextFormat;
		protected var finishFormat:TextFormat;
		protected const w:Number = 700;
		protected var timeWaitingText:Timer;
		protected const timeWaiting:Number = 1200;
		
		protected var textArray:Array;
		protected var curNumText:Number = 0;
		
		protected var curState:Boolean = false;
		
		public function FieldText() 
		{
			// constructor code
			init();
			this.addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
		}
		
		public function KeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.CONTROL)
			{
				GoNextText();
			}
		}
		
		public function HidePanel():void
		{
			if(this.currentFrame < 29) return;
			speakField.visible = false;
			curState = false;
			this.gotoAndPlay(1);
		}
		
		public function ShowPanel():void
		{
			speakField.visible = false;
			this.visible = true;
			curState = true;
			this.gotoAndPlay(30);
			timeWaitingText.start();			
		}
		
		public function HidePanelNow():void
		{
			speakField.visible = false;
			curState = false;
			this.gotoAndStop(29);
		}
		
		public function ShowPanelNow():void
		{
			this.visible = true;
			curState = true;
			this.gotoAndStop(60);
			textWaitingTimer(null);
		}
		
		public function SetText(str:String)
		{
			speakField.text = str;
			speakField.setTextFormat(speakFormat);
		}
		
		public function SetTextArray(_textArray:Array):void
		{
			textArray = _textArray;
			curNumText = 0;
			SetText(textArray[curNumText]);
			curNumText++;
		}
		
		protected function GoNextText():void
		{
			if(!textArray) 
			{
				HidePanel();
			}
			else if(textArray.length < curNumText + 1)
			{
				textArray = null;
				HidePanel();
			}
			else
			{
				SetText(textArray[curNumText]);
				curNumText++;
			}
		}
		
		protected function textWaitingTimer(event:TimerEvent):void
		{
			if(!curState) return;
			speakField.visible = true;
		}
		
		protected function init():void
		{
			//Engravers MT
			timeWaitingText = new Timer(timeWaiting, 1);
			timeWaitingText.addEventListener(TimerEvent.TIMER, textWaitingTimer);
			
			speakFormat = new TextFormat();
			speakField = new TextField();
			speakFormat.font = "Franklin Gothic Demi";
			speakFormat.size = 16;
			speakFormat.color = 0x555555;
			speakField.alpha = 1.0;
			speakField.x = 100;
			speakField.y = 0;
			speakField.selectable = false;
			speakField.width = 500;
			speakField.setTextFormat(speakFormat);
			speakField.x = 50;
			speakField.y = 50;
			this.addChild(speakField);
			speakField.visible = false;
		}
		
	}
}

