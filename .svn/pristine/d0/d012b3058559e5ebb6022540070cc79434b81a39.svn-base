package src.events
{
	import flash.events.Event;
	
	public class ComponentEvent extends Event
	{
		/**
		 * 按下组件 
		 */		
		public static var DOWN_UI:String 					= "down_ui";
		/**
		 * 创建UI 
		 */		
		public static const CREATEUI:String   				= "createui";
		/**
		 * 导入创建UI 
		 */		
		public static const IMPORT_CREATEUI:String   		= "import_createui";
		/**
		 * 导入创建自定义UI 
		 */		
		public static const IMPORT_CREATE_CUSTOMUI:String   = "import_create_customui";
		/**
		 * 导入创建自定义UI按钮
		 */		
		public static const IMPORT_CREATE_CUSTOMBTN:String  = "import_create_custombtn";
		/**
		 * 创建自定义UI 
		 */		
		public static const CREATE_CUSTOMUI:String   		= "create_customui";
		/**
		 * 拖动自定义组件
		 */		
		public static const DOWN_CUSTOMUI:String   			= "down_customui";
		/**
		 * 删除新组件 
		 */		
		public static const REMOVE_CUSTOMUI:String 			= "remove_customui";
		/**
		 * 删除全部新组件 
		 */		
		public static const REMOVE_ALLCUSTOMUI:String 		= "remove_allcustomui";
		
		private var _data:*;
		
		public function ComponentEvent(type:String,data:*=null)
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