package org.flashmonkey.binding
{
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertTrue;
	
	public class SignalProxyTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testBind():void
		{
			var dummy:DummyObject = new DummyObject();
			var proxy:SignalProxy = new SignalProxy(dummy);
			
			try 
			{
				proxy.bind("non-existent property", onMyPropertyChange);
			}
			catch (e:Error)
			{
				assertTrue(true);
			}
			
			proxy.bind("myProperty", onMyPropertyChange);
		}
		
		private function onMyPropertyChange(value:String):void 
		{
			
		}
	}
}