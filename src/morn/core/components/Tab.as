/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**选择项改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**Tab标签*/
	public class Tab extends Box implements IItem {
		protected var _items:Vector.<Button>;
		protected var _selectHandler:Handler;
		protected var _selectedIndex:int;
		protected var _skin:String;
		protected var _labels:String;
		protected var _labelColors:String;
		protected var _labelStroke:String;
		protected var _labelSize:Object;
		protected var _labelBold:Object;
		
		public function Tab(labels:String = null, skin:String = null) {
			this.skin = skin;
			this.labels = labels;
		}
		
		/**初始化*/
		public function initItems():void {
			_items = new Vector.<Button>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:Button = getChildByName("item" + i) as Button;
				if (item == null) {
					break;
				}
				_items.push(item);
				item.selected = (i == _selectedIndex);
				item.clickHandler = new Handler(itemClick, [i]);
			}
		}
		
		protected function itemClick(index:int):void {
			selectedIndex = index;
		}
		
		/**所选按钮的索引*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				setSelect(_selectedIndex, false);
				_selectedIndex = value;
				setSelect(_selectedIndex, true);
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
			}
		}
		
		protected function setSelect(index:int, selected:Boolean):void {
			if (_items != null && index > -1 && index < _items.length) {
				_items[index].selected = selected;
			}
		}
		
		/**选择被改变时执行的处理器(默认返回参数index:int)*/
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**Button皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeLabels);
			}
		}
		
		/**标签集合*/
		public function get labels():String {
			return _labels;
		}
		
		public function set labels(value:String):void {
			if (_labels != value) {
				_labels = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		public function get labelColors():String {
			return _labelColors;
		}
		
		public function set labelColors(value:String):void {
			if (_labelColors != value) {
				_labelColors = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get labelStroke():String {
			return _labelStroke;
		}
		
		public function set labelStroke(value:String):void {
			if (_labelStroke != value) {
				_labelStroke = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签大小*/
		public function get labelSize():Object {
			return _labelSize;
		}
		
		public function set labelSize(value:Object):void {
			if (_labelSize != value) {
				_labelSize = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object {
			return _labelBold;
		}
		
		public function set labelBold(value:Object):void {
			if (_labelBold != value) {
				_labelBold = value;
				callLater(changeLabels);
			}
		}
		
		protected function changeLabels():void {
			if (StringUtils.isNotEmpty(_labels)) {
				removeAllChild();
				var a:Array = _labels.split(",");
				var right:int = 0
				for (var i:int = 0, n:int = a.length; i < n; i++) {
					var item:String = a[i];
					var btn:Button = _skin != null ? new Button(_skin, item) : new LinkButton(item);
					btn.name = "item" + i;
					if (_labelColors) {
						btn.labelColors = _labelColors;
					}
					if (_labelStroke) {
						btn.labelStroke = _labelStroke;
					}
					if (_labelSize) {
						btn.labelSize = _labelSize;
					}
					if (_labelBold) {
						btn.labelBold = _labelBold;
					}
					addElement(btn, right, 0);
					right += btn.width;
				}
				initItems();
			}
		}
		
		/**按钮集合*/
		public function get items():Vector.<Button> {
			return _items;
		}
		
		/**选择项*/
		public function get selection():Button {
			return _selectedIndex > -1 && _selectedIndex < _items.length ? _items[_selectedIndex] : null;
		}
		
		public function set selection(value:Button):void {
			selectedIndex = _items.indexOf(value);
		}
		
		override public function set dataSource(value:Object):void {
			if (value is int) {
				selectedIndex = value as int;
			} else {
				_dataSource = value;
				for (var prop:String in _dataSource) {
					if (hasOwnProperty(prop)) {
						this[prop] = _dataSource[prop];
					}
				}
			}
		}
	}
}