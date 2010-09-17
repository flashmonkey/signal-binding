package org.flashmonkey.binding
{
	public interface ISignalBindable
	{
		function bind(property:String, listener:*, autoDispatch:Boolean = true):void;
		
		function unbind(property:String, listener:*):void;
		
		function clear():void 
	}
}