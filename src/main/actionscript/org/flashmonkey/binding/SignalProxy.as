package org.flashmonkey.binding
{
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.describeType;
	import flash.utils.flash_proxy;
	
	import org.as3commons.lang.Assert;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.lang.DictionaryUtils;
	import org.osflash.signals.Signal;
	
	dynamic public class SignalProxy extends Proxy implements ISignalBindable
	{
		private var _obj:Object = {};
		
		private var _target:Object;
		
		private var _signalMap:Dictionary = new Dictionary(true);
		
		public function SignalProxy(target:Object)
		{
			super();

			_target = target;
		}
		
		public function bind(property:String, listener:*, autoDispatch:Boolean = true):void 
		{			
			if (_target.hasOwnProperty(property))
			{			
				if (!DictionaryUtils.containsKey(_signalMap, property))
				{					
					var type:String = describeType(_target).accessor.(@name == property).@type.toString().split("::").join(".");
											
					_signalMap[property] = new Signal(ClassUtils.forName(type));
				}
				
				Signal(_signalMap[property]).add(listener);
				
				if (autoDispatch)
				{
					dispatch(property);
				}
			}
			else
			{
				throw new Error("There's no property '" + property + "' on " + _target);
			}
		}
		
		public function unbind(property:String, listener:*):void 
		{
			if (DictionaryUtils.containsKey(_signalMap, property))
			{
				Signal(_signalMap[property]).remove(listener);
			}
		}
		
		public function clear():void 
		{
			for each (var i:String in _signalMap)
			{
				var signal:Signal = Signal(_signalMap[i]);
				
				if (signal)
				{
					signal.removeAll();	
				}
			}
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			return _obj[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			var willDispatch:Boolean = !(_obj[name] == value);
			
			_obj[name] = value;
			
			if (DictionaryUtils.containsKey(_signalMap, String(name)) && willDispatch)
			{
				dispatch(name);
			}
		}
		
		private function dispatch(name:String):void
		{
			Signal(_signalMap[name]).dispatch(_obj[name] ? _obj[name] : null);
		}
	}
}