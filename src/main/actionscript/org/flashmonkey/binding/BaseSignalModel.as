package org.flashmonkey.binding
{
	public class BaseSignalModel implements ISignalBindable
	{
		private var _signalProxy:ISignalBindable = new SignalProxy(this);
		
		protected function get signalProxy():ISignalBindable
		{
			return _signalProxy;
		}
		
		public function BaseSignalModel()
		{
			
		}
		
		public function bind(property:String, listener:*, autoDispatch:Boolean = true):void
		{
			_signalProxy.bind(property, listener, autoDispatch);
		}
		
		public function unbind(property:String, listener:*):void
		{
			_signalProxy.unbind(property, listener);
		}
		
		public function clear():void
		{
			_signalProxy.clear();
		}
	}
}