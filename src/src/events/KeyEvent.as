package src.events
{
	import flash.events.Event;

	public class KeyEvent extends Event
	{
		/**
		 * 保存代码 
		 */		
		public static const SAVE_CODE:String 				= "save_code";
		/**
		 * 取消选择
		 */		
		public static const CANCEL_UI:String 				= "cancel_ui";
		/**
		 * 撤销
		 */		
		public static const REVOKE:String 					= "revoke";
		/**
		 * 重做
		 */		
		public static const REDO:String 					= "Redo";
		
		private var _data:*;
		
		public function KeyEvent(type:String,data:*=null)
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