/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import morn.core.handlers.Handler;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.StringUtils;
	
	import org.utils.ClassManager;
	
	/**图片被加载后触发*/
	[Event(name="imageLoaded",type="morn.core.components.UIEvent")]
	
	/**图像类*/
	public class Image extends Component {
		protected var _bitmap:Bitmap;
		protected var _sizeGrid:Array;
		protected var _url:String;
		
		public function Image(url:String = null) {
			this.url = url;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new Bitmap());
		}
		
		/**图片地址*/
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			if (_url != value && StringUtils.isNotEmpty(value)) {
				_url = value;
				bitmapData = ClassManager.createBitmapDataInstance(_url);
			} 
		}
		
		public function set bitmapData(value:BitmapData):void {
			if (value) {
				_width = _width == 0 ? value.width : _width;
				_height = _height == 0 ? value.height : _height;
				_bitmap.bitmapData = value;
				callLater(changeSize);
			}
		}
		
		protected function setBitmapData(bmd:BitmapData):void {
			bitmapData = bmd;
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		override protected function changeSize():void {
			if (_bitmap.bitmapData != null) {
				if (_sizeGrid == null) {
					_bitmap.width = _width;
					_bitmap.height = _height;
				} else {
					_bitmap.bitmapData = BitmapUtils.scale9Bmd(ClassManager.createBitmapDataInstance(_url), _sizeGrid, _width, _height);
				}
				super.changeSize();
			}
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			return _sizeGrid.toString();
		}
		
		public function set sizeGrid(value:String):void {
			_sizeGrid = StringUtils.fillArray([4, 4, 4, 4], value);
		}
		
		/**位图控件*/
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean {
			return _bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void {
			_bitmap.smoothing = value;
		}
		
		override public function set dataSource(value:Object):void {
			if (value is String) {
				url = value as String;
			} else {
				super.dataSource = value;
			}
		}
	}
}