package src.events
{
	import flash.events.Event;

	public class CodeEvent extends Event
	{
		/**
		 * 导入XML
		 */		
		public static var IMPORT_FILE:String 				= "IMPORT_FILE";
		/**
		 * 创建XML
		 */			
		public static const CREATE_FILE:String 				= "CREATE_FILE";
		
		/**
		 *创建代码 
		 */
		public static const CREAT_CODE:String               = "CREATE_CODE";
		
		private var _data:*;
		
		public function CodeEvent(type:String,data:*=null)
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