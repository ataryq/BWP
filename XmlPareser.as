package  {
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.geom.Point;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import Box2D.Common.Math.b2Vec2;
	import flash.utils.*;
	
	public class XmlPareser extends MovieClip
	{
		public var loader:URLLoader;
		public var xmlFile:XML = null;
		public static const STATIC_MODE:Boolean = true;
		
		public function XmlPareser() 
		{
			// constructor code
		}
				
		public function InitLevelFromMap(fileName:String):void
		{
			try {
				if(!stage) return;
	
				loader = new URLLoader(); 
				var request:URLRequest = new URLRequest(fileName); 
				loader.load(request); 
				loader.addEventListener(Event.COMPLETE, onComplete); 
			} catch(error:Error){}
		}
		
		function onComplete(event:Event):void 
		{ 
			xmlFile = new XML(loader.data);
		}
		
		private var timeHelp:Timer = new Timer(200, 1);
		public function GetLevel():void
		{
			timeHelp.start();
			timeHelp.addEventListener(TimerEvent.TIMER_COMPLETE, CreateGameFromXML);
			
			var levelXml:XML;
			switch(InfoGlobal.nextLevelFileName)
			{
				case "level.xml": levelXml = new XML((new levelXML_1()).toString()); break;
				case "level2.xml": levelXml = new XML((new levelXML_2()).toString()); break;
				case "level3.xml": levelXml = new XML((new levelXML_3()).toString()); break;
				case "level4.xml": levelXml = new XML((new levelXML_4()).toString()); break;
				case "level5.xml": levelXml = new XML((new levelXML_5()).toString()); break;
				case "level6.xml": levelXml = new XML((new levelXML_6()).toString()); break;
				case "level7.xml": levelXml = new XML((new levelXML_7()).toString()); break;
				case "level8.xml": levelXml = new XML((new levelXML_8()).toString()); break;
				case "level9.xml": levelXml = new XML((new levelXML_9()).toString()); break;
			}
			xmlFile = levelXml;
		}
		
		public function CreateGameFromXML(event:Event = null):void
		{
			if(STATIC_MODE)
			{
				if(!xmlFile) 
				{
					GetLevel();
					return;
				}
				if(event) {
					loader.removeEventListener(TimerEvent.TIMER_COMPLETE, CreateGameFromXML);
				}
			} else
			{
				if(!xmlFile) 
				{
					loader.addEventListener(Event.COMPLETE, CreateGameFromXML);
					return;
				}
				if(event) loader.removeEventListener(Event.COMPLETE, CreateGameFromXML);
			}
			
			
			//load texture
			
			ParseGameInfo();
			
			try {
				try {CreateTexture();} catch(error:Error){}
				try {CreateDyanmicPlatform("DYNAMIC_PLATFORM", DynamicPlatform);} catch(error:Error){}
				try {CreateDyanmicPlatform("MINI_DYNAMIC_PLATFORM", MiniDynamicPlatform);} catch(error:Error){}
				try {CreateObjectWithPosition("COIN", Coin);} catch(error:Error){}
				try {CreateObjectWithPosition("JEVEL", Jevel);} catch(error:Error){}
				try {CreateObjectWithPosition("FLAG", Flag);} catch(error:Error){}
				try {CreateObjectWithPosition("THORNS", Thorns);} catch(error:Error){}
				try {CreateDynamicThorns();} catch(error:Error){}
				try {CreateCogwheel();} catch(error:Error){}
				try {CreateRotationPlatform();} catch(error:Error){}
				try {CreateStaticPlatform("STATIC_PLATFORM");} catch(error:Error){}
				try {CreateObjectWithTypeBodyPosition("KEY", Key);} catch(error:Error){}
				try {CreateObjectWithTypeBodyPosition("DOOR", Door);} catch(error:Error){}
				try {CreateObjectWithPosition("DYNAMIK_BOX", DynamicBox);} catch(error:Error){}
				try {CreateObjectWithPositionAndText("FLAG_HELP", FlagHelp);} catch(error:Error){}
				try {SetDebugDrawing();} catch(error:Error){}
			} catch(error:Error){}
			
		}
		
		function CreateRotationPlatform()
		{
			var nameObject:String = "ROTATION_PLATFORM";
			var classObject:Class = RotationPlatform;
			var xmlList:XMLList = xmlFile.child(nameObject);
			var scale:Number;

			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try {
					trace(Number(xmlList[i].@X) + " " + 
						  Number(xmlList[i].@Y) + " " + nameObject);
						  
					addChild(new classObject(new Point(Number(xmlList[i].@X), 
												Number(xmlList[i].@Y)),
												Number(xmlList[i].@S)
												));
				} catch(error:Error){}
			}
		}
		
		function CreateCogwheel()
		{
			var nameObject:String = "COGWHEEL";
			var classObject:Class = hindranceCogwheel;
			var xmlList:XMLList = xmlFile.child(nameObject);
			
			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try {
					trace(Number(xmlList[i].@X) + " " + 
						  Number(xmlList[i].@Y) + " " + nameObject);
					addChild(new classObject(informBlockListPlatform.GetInformBlock(stage).createWorld,
											 new b2Vec2(Number(xmlList[i].@X), Number(xmlList[i].@Y))
												));
				} catch(error:Error){}
			}
		}
		
		protected function CreateDynamicThorns():void
		{
			var nameObject:String = "DYNAMIC_THORNS";
			var classObject:Class = DyanmicThorns;
			var xmlList:XMLList = xmlFile.child(nameObject);
			
			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try 
				{
					trace(Number(xmlList[i].@X) + " " +  Number(xmlList[i].@Y) + " " +  nameObject);
						  
					addChild(new classObject(Number(xmlList[i].@X), 
												 Number(xmlList[i].@Y),
												 new b2Vec2(Number(xmlList[i].@LEFT_B_X), Number(xmlList[i].@LEFT_B_Y)),
												 new b2Vec2(Number(xmlList[i].@RIGHT_B_X), Number(xmlList[i].@RIGHT_B_Y)),
												 new b2Vec2(Number(xmlList[i].@SPEED_X), Number(xmlList[i].@SPEED_Y))
												));
				} catch(error:Error){}
			}
		}
		
		protected function ParseGameInfo():void
		{
			try {
				informBlockListPlatform.GetInformBlock(stage).toolBar.dialogField.SetText(xmlFile.@START_MESSAGE);
				if(xmlFile.@START_MESSAGE != "") informBlockListPlatform.GetInformBlock(stage).toolBar.dialogField.ShowPanelNow();
				else informBlockListPlatform.GetInformBlock(stage).toolBar.dialogField.HidePanelNow();
			} catch(error:Error){}
		}
		
		function SetDebugDrawing():void
		{
			
		}
		
		
		
		protected function CreateDyanmicPlatform(nameObject:String, classObject:Class):void
		{
			var xmlList:XMLList = xmlFile.child(nameObject);
			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try {
					trace(Number(xmlList[i].@X) + " " + 
						  Number(xmlList[i].@Y) + " " +  nameObject);
					addChild(new classObject(informBlockListPlatform.GetInformBlock(stage).createWorld, 
												 new Point(Number(xmlList[i].@X), Number(xmlList[i].@Y)),
												 new b2Vec2(Number(xmlList[i].@LEFT_B_X), Number(xmlList[i].@LEFT_B_Y)),
												 new b2Vec2(Number(xmlList[i].@RIGHT_B_X), Number(xmlList[i].@RIGHT_B_Y)),
												 new b2Vec2(Number(xmlList[i].@SPEED_X), Number(xmlList[i].@SPEED_Y))
												));
				} catch(error:Error){}
			}
		}
		
		protected function CreateObjectWithPositionAndText(nameObject:String, classObject:Class):void
		{
			var xmlList:XMLList = xmlFile.child(nameObject);
			if(!xmlList) return;
			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try 
				{
					trace(Number(xmlList[i].@X) + " " + 
						  Number(xmlList[i].@Y) + " " + nameObject);
					addChild(new classObject(new Point(Number(xmlList[i].@X), 
												Number(xmlList[i].@Y)),
												(xmlList[i].@M).toString()
												));
				} catch(error:Error){}
			}
		}
		
		function CreateObjectWithTypeBodyPosition(nameObject:String, classObject:Class)
		{
			var xmlList:XMLList = xmlFile.child(nameObject);
			var type:Number;
			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try
				{
					trace(Number(xmlList[i].@X) + " " + 
						  Number(xmlList[i].@Y) + " " + nameObject);
					addChild(new classObject(Number(xmlList[i].@T),
											 false,
											 new Point(Number(xmlList[i].@X), 
												Number(xmlList[i].@Y))
												));
				} catch(error:Error){}
			}
		}
		
		function CreateTexture()
		{
			const TEXTURE:String = "TEXTURE";
			var xmlList:XMLList = xmlFile.child(TEXTURE);
			if(!xmlList) trace("non object TEXTURE");
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try {
					trace(Number(xmlList[i].@X), 
					Number(xmlList[i].@Y));
					CreateTextureImg(String(xmlList[i].@L), Number(xmlList[i].@X), Number(xmlList[i].@Y));
				} catch(error:Error){}
			}
		}
		
		function CreateTextureImg(nameObject:String, X:Number, Y:Number)
		{
			trace( "TEXTURE " + nameObject);
			
			var textureClass:Class;
			var image:Bitmap;
			switch(nameObject)
			{
				//texture
					// GreenPlatform
				case "GREEN_PLATFORM_LEFT": 
				{
					textureClass = ImgSource.GreenPlatformLeft;
				} break;
				case "GREEN_PLATFORM_MIDDLE": 
				{
					textureClass = ImgSource.GreenPlatformMiddle;
				} break;
				case "GREEN_PLATFORM_RIGHT": 
				{
					textureClass = ImgSource.GreenPlatformRight;
				} break;
				
							// mini green
				case "MINI_GREEN_PLATFORM_LEFT": 
				{
					textureClass = ImgSource.miniGreenPlatformLeft;
				} break;
				case "MINI_GREEN_PLATFORM_MIDDLE": 
				{
					textureClass = ImgSource.miniGreenPlatformMiddle;
				} break;
				case "MINI_GREEN_PLATFORM_RIGHT": 
				{
					textureClass = ImgSource.miniGreenPlatformRight;
				} break;
				case "MINI_GREEN_PLATFORM": 
				{
					textureClass = ImgSource.miniGreenPlatform;
				} break;
				
					// BrownPlatform
				
				case "BROWN_PLATFORM_LEFT": 
				{
					textureClass = ImgSource.BrownPlatformLeft;
				} break;
				case "BROWN_PLATFORM_MIDLE": 
				{
					textureClass = ImgSource.BrownPlatformMiddle;
				} break;
				case "BROWN_PLATFORM_RIGHT": 
				{
					textureClass = ImgSource.BrownPlatformRigth;
				} break;
						//miniBrownPlatform
				case "MINI_BROWN_PLATFORM_LEFT": 
				{
					textureClass = ImgSource.miniBrownPlatformLeft;
				} break;
				case "MINI_BROWN_PLATFORM_MIDLE": 
				{
					textureClass = ImgSource.miniBrownPlatformMiddle;
				} break;
				case "MINI_BROWN_PLATFORM_RIGHT": 
				{
					textureClass = ImgSource.miniBrownPlatformRigth;
				} break;
				
				case "MINI_BROWN_PLATFORM": 
				{
					textureClass = ImgSource.miniBrownPlatform;
				} break; 
				
				
				
					// BrownIcePlatform
				
				case "BROWN_ICE_PLATFORM_LEFT": 
				{
					textureClass = ImgSource.BrownIcePlatformLeft;
				} break;
				case "BROWN_ICE_PLATFORM_MIDLE": 
				{
					textureClass = ImgSource.BrownIcePlatformMiddle;
				} break;
				case "BROWN_ICE_PLATFORM_RIGHT": 
				{
					textureClass = ImgSource.BrownIcePlatformRigth;
				} break;
				
						//miniBrownIcePlatform
				case "MINI_BROWN_ICE_PLATFORM_LEFT": 
				{
					textureClass = ImgSource.miniBrownIcePlatformLeft;
				} break;
				case "MINI_BROWN_ICE_PLATFORM_MIDLE": 
				{
					textureClass = ImgSource.miniBrownIcePlatformMiddle;
				} break;
				case "MINI_BROWN_ICE_PLATFORM_RIGHT": 
				{
					textureClass = ImgSource.miniBrownIcePlatformRigth;
				} break;
				case "MINI_BROWN_ICE_PLATFORM": 
				{
					textureClass = ImgSource.miniBrownIcePlatform;
				} break; 
				
				
				
				case "BROWN_LAND": 
				{
					textureClass = ImgSource.BrownLand;
				} break; 
				
				case "WATER": 
				{
					textureClass = ImgSource.Water;
				} break; 
				
				// game
				case "BOX": 
				{
					textureClass = ImgSource.Box;
				} break;
				case "WOOD_WALL": 
				{
					textureClass = ImgSource.WoodWall;
				} break;
				
				//pointers
				case "POINTER_EMTY":
				{
					textureClass = ImgSource.PointerEmpty;
				} break;
				case "POINTER_L":
				{
					textureClass = ImgSource.PointerL;
				} break;
				case "POINTER_R":
				{
					textureClass = ImgSource.PointerR;
				} break;
			}
			trace(textureClass);
			image = new textureClass();
			addChild(image);
			image.x = X;
			image.y = Y;
		}
		
		function CreateObjectWithPosition(nameObject:String, classObject:Class)
		{
			var xmlList:XMLList = xmlFile.child(nameObject);
			if(xmlList.length() == 0) trace("non object " + nameObject);
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try 
				{
					trace(Number(xmlList[i].@X) + " " + 
						  Number(xmlList[i].@Y) + " " + nameObject);
					addChild(new classObject(new Point(Number(xmlList[i].@X), 
												Number(xmlList[i].@Y))
												));
				} catch(error:Error){}
			}
		}
		
		function CreateStaticPlatform(nameObject:String)
		{
			var xmlList:XMLList = xmlFile.child(nameObject);
			if(!xmlList) trace("non object " + nameObject);
			var createWorld:CreateWorld = informBlockListPlatform.GetInformBlock(stage).createWorld;
			for(var i:uint = 0; i < xmlList.length(); i++)
			{
				try 
				{
					trace(Number(xmlList[i].@X), 
						  Number(xmlList[i].@Y), 
						  Number(xmlList[i].@W),
						  Number(xmlList[i].@H),
						  Number(xmlList[i].@A));
					createWorld.createStaticBox(Number(xmlList[i].@X),
												Number(xmlList[i].@Y),
												Number(xmlList[i].@W),
												Number(xmlList[i].@H),
												Number(xmlList[i].@A) / 180 * Math.PI
												);
				} catch(error:Error){}
			}
		}
	}
	
}
