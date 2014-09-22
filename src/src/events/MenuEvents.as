package src.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 *@author tanshiyu
	 *@date 2013-9-22
	 */
	public class MenuEvents extends Event
	{
		public static const dispatcher:EventDispatcher = new EventDispatcher();
		public static const IDINDEX_UPDATA:String   = "IDINDEX_UPDATA";
		private var _data:*;

		public function get data():*
		{
			return _data;
		}

		public function MenuEvents(type:String,data:*)
		{
			_data = data;
			super(type,_data);
		}
	}
}