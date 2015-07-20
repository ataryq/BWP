package  {
	import flash.net.*;
	
	public class LevelLoader {
		public var xmlFile:XML;
		protected var loader:URLLoader;
		
		public function LevelLoader(levelPath:String) 
		{
			// constructor code
			var loader:URLLoader = new URLLoader(); 
			var request:URLRequest = new URLRequest(levelPath); 
			loader.load(request); 
			loader.addEventListener(Event.COMPLETE, onComplete); 
		}
		
		function onComplete(event:Event):void 
		{ 
			var xmlFile:XML = new XML(loader.data); 
			trace(externalXML.toXMLString()); 
		}

	}
	
}
