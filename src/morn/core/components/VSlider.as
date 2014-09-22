/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**垂直滑动条*/
	public class VSlider extends Slider {
		
		public function VSlider(skin:String = null) {
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = VERTICAL;
		}
	}
}