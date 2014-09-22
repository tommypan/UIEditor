package src.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 *@author tanshiyu
	 *@date 2013-9-17
	 */
	public class ProjectEvents extends Event
	{
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		public static var UPDATA_PROJECT:String      = "UPDATA_PROJECT";
		private var _data:*;

		public function ProjectEvents(type:String,data:*)
		{
			_data = data;
			super(type,_data);
		}

		public function get data():*
		{
			return _data;
		}
	}
}