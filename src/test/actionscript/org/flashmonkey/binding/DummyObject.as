package org.flashmonkey.binding
{
	public class DummyObject implements IDummyModel, ISignalBindable
	{
		private var _signalProxy:ISignalBindable = new SignalProxy(this);
		
		[Signal] public function get myProperty():String 
		{
			return _signalProxy["myProperty"];
		}
		public function set myProperty(value:String):void 
	   	{
			_signalProxy["myProperty"] = value;   
		}
		
		public function bind(property:String, listener:*, autoDispatch:Boolean = true):void
		{
			_signalProxy.bind(property, listener);
		}
		
		public function unbind(property:String, listener:*):void
		{
			_signalProxy.unbind(property, listener);
		}
		
		public function clear():void
		{
			_signalProxy.clear();
		}
		
		public function DummyObject()
		{
			
		}
	}
}