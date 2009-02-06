package model
{
	[Bindable]
	[Event("propertyChange")]
	public class PersonVO
	{
		public var uid:String = Math.random().toString();
		public var firstName:String;
		public var lastName:String;
		public var age:Number;
		
		public function toString():String
		{
			return firstName + " " + lastName + ", Age " + age;
		}
	}
}