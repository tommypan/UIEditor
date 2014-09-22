package src.events
{
	import flash.events.Event;
	
	public class PopupWinEvent extends Event
	{
		public static var CLICK:String = "click";
		
		private var _data:*;
		
		public function PopupWinEvent(type:String,data:*=null)
		{
			super(type,data);
			_data = data;
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}