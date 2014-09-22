package src.events
{
	import flash.events.Event;

	public class CodeEvent extends Event
	{
		/**
		 * 导入代码 
		 */		
		public static var IMPORT_CODE:String 				= "import_code";
		/**
		 * 创建代码 
		 */			
		public static const CREATE_CODE:String 				= "CREATE_CODE";
		
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