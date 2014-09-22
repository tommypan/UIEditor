/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	
	/**UI事件类*/
	public class UIEvent extends Event {
		//-----------------Component-----------------			
		/**更新完毕*/
		public static const RENDER_COMPLETED:String = "renderCompleted";
		/**显示鼠标提示*/
		public static const SHOW_TIP:String = "showTip";
		/**隐藏鼠标提示*/
		public static const HIDE_TIP:String = "hideTip";
		//-----------------Image-----------------
		/**图片加载完毕*/
		public static const IMAGE_LOADED:String = "imageLoaded";
		//-----------------View-----------------
		/**视图创建完毕*/
		public static const VIEW_CREATED:String = "viewCreated";
		//-----------------FrameClip-----------------
		/**帧跳动*/
		public static const FRAME_CHANGED:String = "frameChanged";
		
		private var _data:*;
		
		public function UIEvent(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		/**事件数据*/
		public function get data():* {
			return _data;
		}
		
		public function set data(value:*):void {
			_data = value;
		}
		
		override public function clone():Event {
			return new UIEvent(type, _data, bubbles, cancelable);
		}
	}
}