package  {
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class ContactLisener extends b2ContactListener{
		public static var arrayFunction:Array = new Array();
		public static var deleteArray:Array = new Array();
				
		override public function BeginContact(contact:b2Contact):void 
		{
			if(!arrayFunction) return;
 			for(var i:Number = 0; i < arrayFunction.length; i++)
			{
				(arrayFunction[i] as Function).call(this, contact);
			}
		}
		
		public function clearFunction():void
		{
			arrayFunction = new Array();
		}
		
		public function addFunction(fun:Function):void {
			arrayFunction.push(fun);
		}

	}
	
}
