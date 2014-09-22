package src.utils
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class KeyStateUtil
	{
		private static var key:Object = new Object();
		private static var stage:Stage;
		private static var fun:Function;
		
		public static function setStage(_stage:Stage):void
		{
			stage = _stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down, false, 2);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up, false, 2);
		}
		
		public static function setReturnFun(_fun:Function):void
		{
			fun = _fun;
		}
		
		//返回某键是否被按下
		public static function keyIsDown(keyCode:int):Boolean
		{
			return key[keyCode];
		}
		
		private static function key_down(evt:KeyboardEvent):void
		{
			key[evt.keyCode] = true; 
			if(fun!=null)fun();
		}
		
		private static function key_up(evt:KeyboardEvent):void
		{
			key[evt.keyCode] = false;
		}
	}        
}