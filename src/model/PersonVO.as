package model
{
	[Bindable]
	[Event("propertyChange")]
	public class PersonVO
	{
		public var firstName:String;
		public var lastName:String;
		public var age:Number;
	}
}