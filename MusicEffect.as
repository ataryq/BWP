package  {
	import flash.utils.Timer;
	import flash.media.SoundChannel;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	
	public class MusicEffect 
	{
		protected var timer:Timer;
		protected var soundChanel:SoundChannel;
		protected var soundTran:SoundTransform;		
		
		public function MusicEffect() {
			// constructor code
		}
		
		private var stepFade:Number = 0.04;
		private var timeFade:Number = 1;
		private var borderBottom:Number = 0;
		private var hightBottom:Number = 1;
		
		private const iterPerSec:Number = 25;
		
		public function FadeOut(_soundChanel:SoundChannel,
								_borderBottom:Number = 0,
								_timeFade:Number = 1):void
		{
			if(!_soundChanel) return;
			borderBottom = _borderBottom;
			timeFade = _timeFade;
			
			stepFade = 1 / (_timeFade * iterPerSec);
			
			soundTran = _soundChanel.soundTransform;
			soundChanel = _soundChanel;
			timer = new Timer(stepFade, _timeFade * iterPerSec);
			timer.addEventListener(TimerEvent.TIMER, TimerCallFadeOut);
			timer.start();
		}
		
		protected function TimerCallFadeOut(event:Event):void
		{
			if(soundTran.volume >= stepFade + borderBottom) {
				soundTran.volume -= stepFade;
				soundChanel.soundTransform = soundTran;
			}
			else {
				if(borderBottom == 0) soundChanel.stop();
			}
		}
		
		public function FadeIn(_soundChanel:SoundChannel,
							   _hightBottom:Number = 1,
							   _timeFade:Number = 1):void
		{
			hightBottom = _hightBottom;
			timeFade = _timeFade;
			
			stepFade = 1 / (_timeFade * iterPerSec);
			
			soundTran = _soundChanel.soundTransform;
			soundChanel = _soundChanel;
			timer = new Timer(stepFade, _timeFade * iterPerSec);
			timer.addEventListener(TimerEvent.TIMER, TimerCallFadeIn);
			timer.start();
		}
		
		public function FadeInNewSound(sound:Sound, 
							   _hightBottom:Number = 1,
							   _startTime:Number = 0,
							   _timeFade:Number = 1):SoundChannel
		{
			if(!sound) return null;
			hightBottom = _hightBottom;
			timeFade = _timeFade;
			soundTran = new SoundTransform(0);
			soundChanel = sound.play(_startTime, 10, soundTran);
			timer = new Timer(stepFade, 1 / stepFade);
			timer.addEventListener(TimerEvent.TIMER, TimerCallFadeIn);
			timer.start();
			return soundChanel;
		}
		
		protected function TimerCallFadeIn(event:Event):void
		{
			if(soundTran.volume < hightBottom - stepFade) {
				soundTran.volume += stepFade;
				soundChanel.soundTransform = soundTran;
			}
		}
		
	}
}
