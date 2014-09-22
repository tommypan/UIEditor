package src.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 *@author tanshiyu
	 *@date 2013-9-17
	 */
	public class SettingEvents extends Event
	{
		public static var dispatcher:EventDispatcher  = new EventDispatcher();
		
		public static var UPDATE_SKINS:String         = "UPDATE-SKINS";
		
		private static var _data:*;
		
		public function SettingEvents(type:String,data:* = null)
		{
			_data = data;
			super(type,_data)
		}
		
		public function get data():*{
			return _data;
		}
	}
}