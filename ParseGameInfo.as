package  {
	
	public class ParseGameInfo {
		public static const SaveFile:String = "SaveFileBWP.xml";
		public static const saveFile:File = File.applicationStorageDirectory.resolvePath(SaveFile);
		public static var xmlSave:XML;
		public static const StartGameParam:XML = <GAME 
					CURRENT_LEVEL_NAME_FILE = "2"
					FULL_SCREEN = "1"
					MUSIC = "1"
					SOUND = "1">
					
					</GAME>;
		private static var fileStream:FileStream = new FileStream();   
		
		public function ParseGameInfo() {
			// constructor code
		}
		
		public static function StartParsing():void
		{
			try 
			{
				if(saveFile.size == 0) xmlSave = StartGameParam.copy();
				fileStream.open(saveFile, FileMode.READ);
				xmlSave = new XML(fileStream.readUTFBytes(saveFile.size));
				fileStream.close();
				
			} catch(error:Error) {
				xmlSave = StartGameParam.copy();
			}
			
			trace(xmlSave);
			saveXmlSave();
			
			InfoGlobal.currentLevel = Number(xmlSave.@CURRENT_LEVEL_NAME_FILE);
			InfoGlobal.gameSetting.FullScreen = Number(xmlSave.@FULL_SCREEN);
			InfoGlobal.gameSetting.Music = Number(xmlSave.@MUSIC);
			InfoGlobal.gameSetting.Sound = Number(xmlSave.@SOUND);
		}
		
		public static function saveXmlSave():void
		{
			fileStream.open(saveFile, FileMode.WRITE);
			fileStream.writeUTFBytes(xmlSave); 
			fileStream.close();
		}
		
	}
	
}
