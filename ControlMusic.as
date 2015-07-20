package  {
	import flash.media.Sound;
	import flash.display.MovieClip;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	public class ControlMusic extends MovieClip 
	{
		protected static const musicLevel:Array = new Array(new LevelMusic1(),
												   new LevelMusic2());
		protected static const menuMusic:Sound = new MenuMusic();
		protected static const finishLevel:Sound = new FinishLevel();
		
		protected static var menuMusicChanel:SoundChannel;
		protected static var chanelsMusic:Array = new Array(10);
		
		public function ControlMusic() {
			// constructor code
			
		}
		
		public static function AllStop():void
		{
			for(var i:uint = 0; i < musicLevel.length; i++) {
				 if(!chanelsMusic[i]) continue;
				 (new MusicEffect()).FadeOut(chanelsMusic[i]);
				 chanelsMusic[i] = null;
			}
			StopMenuMusic();
			trace("stop all music");
		}
		
		static private var isPlayingStartMenuMusic:Boolean = false;
		public static function StartMenuMusic():void
		{
			if(!InfoGlobal.gameSetting.Music) return;
			if(isPlayingStartMenuMusic) return;
			isPlayingStartMenuMusic = true;
			menuMusicChanel = menuMusic.play(0, 999);
		}
		
		public static function StopMenuMusic():void
		{
			if(!menuMusicChanel) {
				trace("error StopMenuMusic/ControlMusic");
				return;
			}
			isPlayingStartMenuMusic = false;
			(new MusicEffect()).FadeOut(menuMusicChanel, 0, 2);
			menuMusicChanel = null;
		}
		
		public static function StartFinishLevelMusic():void
		{
			if(!InfoGlobal.gameSetting.Sound) return;
			finishLevel.play(0, 1);
		}
		
		public static function QuietLevelMusic(numLevel:Number):void
		{
			if(!InfoGlobal.gameSetting.Music) return;
			(new MusicEffect()).FadeOut(chanelsMusic[numLevel], 0.1, 2);
		}
		
		public static function NormalLevelMusic(numLevel:Number):void
		{
			if(!InfoGlobal.gameSetting.Music) return;
			(new MusicEffect()).FadeIn(chanelsMusic[numLevel], 1, 2);
		}
		
		public static function StartLevelMusic(numLevel:Number):void
		{
			if(!InfoGlobal.gameSetting.Music) return;
			if(numLevel > 1 || numLevel < 0) return;
			AllStop();
			chanelsMusic[numLevel] = (new MusicEffect()).FadeInNewSound(musicLevel[numLevel], 1, 0, 3);
		}
		
		public static function StopLevelMusic(numLevel:Number):void
		{
			if(chanelsMusic[numLevel]) (new MusicEffect()).FadeOut(chanelsMusic[numLevel], 0, 2);
		}
		
		public static function SetAllVolume(_volume:Number = 1):void
		{
			SoundMixer.soundTransform = new SoundTransform(_volume);
		}

	}
	
}
