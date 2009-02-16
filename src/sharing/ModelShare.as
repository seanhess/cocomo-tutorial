
package sharing
{
	import com.adobe.rtc.events.SharedPropertyEvent;
	import com.adobe.rtc.sharedModel.CollectionNode;
	import com.adobe.rtc.sharedModel.SharedProperty;
	
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class ModelShare
	{
		public var fields:Object = {}; // which fields to serialize
		protected var _model:IEventDispatcher; // the guy you will be serializing
		public var collectionNode:CollectionNode;
		public var modelID:String;
		public var property:SharedProperty;
		public var type:Class;
		
		public var value:*;
		
		public function subscribe():void
		{
			if (!property)
			{
				property = new SharedProperty();
				property.collectionNode = collectionNode;
				property.nodeName = "HI";
				property.addEventListener(SharedPropertyEvent.CHANGE, onPropertyChange);
				property.subscribe();
			}
			
			// set it for the first time
			property.value = convert(model, Object);
			
			// listen to the fields // 
		}
		
		public function set model(value:IEventDispatcher):void
		{
			if (_model)
				_model.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onModelChange);
			
			if(value)
				value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onModelChange);
				
			_model = value;
		}
		
		public function get model():IEventDispatcher
		{
			return _model;
		}
		
		protected function onModelChange(event:PropertyChangeEvent):void
		{
			// we only care if we're listening for that property
			if (fields[event.property])
			{
				var value:Object = convert(model, Object);
					value[event.property] = event.newValue;
				
				property.value = value; 
			}
		}
		
		protected function onPropertyChange(event:SharedPropertyEvent):void
		{
			// it updates the whole thing! // 
			value = convert(event.value, type);
		}
		
		protected function convert(source:*, type:Class=null):*
		{
			if (type == null)
				type = Object;
				
			if (source == null)
				return null;
			
			var result:* = new type();
			
			for (var field:String in fields)
			{
				result[field] = source[field];
			}
			
			return result;
		}		
	}
}