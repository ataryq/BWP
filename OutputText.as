package  {
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class OutputText {
		protected var info:informBlockListPlatform;
		protected var firstName:String;
		protected var secondName:String;
		protected var message:String;
		
		public function OutputText(_info:informBlockListPlatform, 
								   _firstName:String,
								   _secondName:String,
								   _message:String) 
		{
			// constructor code
			info = _info;
			firstName = _firstName;
			secondName = _secondName;
			message = _message;
		}

		public function Out(contact:b2Contact):void
		{
			if( (contact.GetFixtureA().GetBody().GetUserData().name == firstName ||
			contact.GetFixtureB().GetBody().GetUserData().name == firstName) &&
			(contact.GetFixtureA().GetBody().GetUserData().name == secondName ||
			contact.GetFixtureB().GetBody().GetUserData().name == secondName) ) 
			{
				info.dialogField.SetText(message);
				info.dialogField.ShowPanel(); 
			}
		}
		
	}
}
