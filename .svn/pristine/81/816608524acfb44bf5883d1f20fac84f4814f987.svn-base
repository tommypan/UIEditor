package src.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.CheckBox;
	import mx.controls.ColorPicker;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	
	import src.containers.SettingPanel;
	import src.events.EditorEvents;
	import src.events.SettingEvents;
	import src.managers.UIFactory;
	import src.models.MainEditorModel;
	import src.models.SettingModel;
	
	public class SettingControls
	{
		private var settingPanel:SettingPanel;
		private var settingModel:SettingModel;
		
		
		
		/**
		 *  相对UI的属性
		 */		
		private var cor:Object = new Object();
		
		/**
		 *当前操作UIs 
		 */
		private var currentUI:DisplayObject;
		
		private var lastUI:DisplayObject;
		
		private var currentSkin:Box;
		private var contextMenu:ContextMenu = new ContextMenu();
		private var removeMenu:NativeMenuItem = new NativeMenuItem("移除");
		public function SettingControls(_settingPanel:SettingPanel,_settingModel:SettingModel,xml:XML)
		{
			settingPanel = _settingPanel;
			settingModel = _settingModel;
			
			//上下文菜单
			contextMenu.addItem(removeMenu);
			
			//初始化组件属性数据  其中包括皮肤skin
			for(var i:int=0; i<xml.children().length();i++) {
				var object:Object = new Object();
				var newxml:XML = xml.children()[i];
				for(var j:int=0; j<newxml.children().length(); j++){
					if(newxml.children()[j].name().localName == "skin"){
						var skinObject:Object =  new Object();
						var skinxml:XML = newxml.children()[j];
						for(var k:int=0; k<skinxml.children().length();k++) {
							skinObject[k] = skinxml.children()[k];
						}
						settingModel.componentsskins[xml.children()[i].@name] = skinObject;
					} else {
						var string:String = newxml.children()[j];
						var arr:Array = string.split(",");
						object[j] = arr;
					}
				}
				settingModel.componentsAttributes[xml.children()[i].@name] = object;
			}
			
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.GET_COMPONENTSATTRIBUTES,[settingModel.componentsAttributes,settingModel.componentsskins]));
			
			allSetting()
			addEvents();			
		}
		
		/**
		 * 全局设置 
		 */		
		private function allSetting():void
		{
			//previewModeBox.addChild(createBooleanItem(null,"previewMode"));
			
			settingPanel.editStateCheck.addEventListener(Event.CHANGE,function():void{
				MainEditorModel.isEditState=settingPanel.editStateCheck.selected;
				EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.EDIT_STATE,currentUI));
			} );
			
			/*
			点击组件出现编辑皮肤的选项框 
			*/
			settingPanel.editSkinCheck.addEventListener(Event.CHANGE,function():void {
				MainEditorModel.isEditSkin = settingPanel.editSkinCheck.selected;
				MainEditorModel.isEditSkin ? settingPanel.skinsBox.visible = true : settingPanel.skinsBox.visible = false;
			} );
		}
		
		private function addEvents():void
		{
			//为上下文菜单添加监听事件
			removeMenu.addEventListener(Event.SELECT,removeSelectSkin);
			
			//为其他事件添加监听
			EditorEvents.dispathcer.addEventListener(EditorEvents.EDITUI,setUI);
			//			EditorEvents.dispathcer.addEventListener(EditorEvents.CANCEL_CHOICE,clearAll);
			EditorEvents.dispathcer.addEventListener(EditorEvents.UPDATE_SETTING,updateSetting);
			EditorEvents.dispathcer.addEventListener(EditorEvents.REMOVE_UI,clearAll);
			EditorEvents.dispathcer.addEventListener(EditorEvents.CHANGE_SKIN,changeSkim);
			EditorEvents.dispathcer.addEventListener(EditorEvents.UPDATE_UIID,updateUIID);
			EditorEvents.dispathcer.addEventListener(EditorEvents.CLEAR_STAGE,clearStage);
			SettingEvents.dispatcher.addEventListener(SettingEvents.UPDATE_SKINS,updataskins);
		}
		
		
		/**
		 *当导入XML的时候更新属性栏里面的数据 
		 * @param event
		 * 
		 */
		protected function updataskins(event:SettingEvents):void
		{
			//清空属性栏
			settingPanel.editSkinCheck.selected = false;
			settingPanel.skinsBox.visible = false;
			clearAll();
			
			//开始设置属性栏里面的数据
			skinSetting(settingModel.UIIDDictionary[event.data[0]]);
			trace(event.data[1],"dedede");
			trace(settingModel.skinboxArr[settingModel.UIIDDictionary[event.data[0]]][event.data[1]]);
			settingModel.skinboxArr[settingModel.UIIDDictionary[event.data[0]]][event.data[1]].rawChildren.addChild(event.data[2]);
			if(settingModel.skinUrl[settingModel.UIIDDictionary[event.data[0]]] == null){settingModel.skinUrl[settingModel.UIIDDictionary[event.data[0]]] = new Object}
			settingModel.skinUrl[settingModel.UIIDDictionary[event.data[0]]][event.data[1]] = event.data[3];
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.GET_SKINATTRIBUTES,settingModel.skinUrl));
		}
		
		/**
		 *当创建UI的时候更新ui与id的引用关系 
		 * @param event
		 * 
		 */
		protected function updateUIID(event:EditorEvents):void
		{
			settingModel.IDUIObject = event.data[0];
			settingModel.UIIDDictionary =event.data[1];
		}
		
		/**
		 *在属性栏里面拖动皮肤图片到 UI组件的相应皮肤编辑框里面的时候触发 
		 * @param e
		 * 
		 */
		protected function changeSkim(e:EditorEvents):void
		{
			var id:int = settingModel.UIIDDictionary[currentUI];
			var skinBoxObject:Object = settingModel.skinboxArr[id];
			for (var i:int=0; i<skinBoxObject["styleArr"].length; i++) {
				var index:String;
				index = skinBoxObject["styleArr"][i];
				if(skinBoxObject[index].mouseX > 0 && skinBoxObject[index].mouseX < skinBoxObject[index].width 
					&& skinBoxObject[index].mouseY > 0 && skinBoxObject[index].mouseY < skinBoxObject[index].height) {
					var _loader :Loader = new Loader();
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onHadlePic);
					_loader.load(new URLRequest(e.data));	
					function onHadlePic(event:Event):void
					{
						_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onHadlePic);
						var bitmap :Bitmap = event.target.content as Bitmap;
						//改变在编辑器中的UI组件样式
						currentUI[index] = bitmap;
						//复制bitmap，在编辑器的编辑框中显示组件样式
						var bitmapdata:BitmapData = new BitmapData(bitmap.width,bitmap.height);
						bitmapdata.draw(bitmap);
						var copybitmap:Bitmap = new Bitmap(bitmapdata);
						copybitmap.x = copybitmap.y = 1;
						copybitmap.width = copybitmap.height = 98;
						if(skinBoxObject[index].rawChildren.numChildren == 2) {
							skinBoxObject[index].rawChildren.removeChildAt(1);
						}
						skinBoxObject[index].rawChildren.addChild(copybitmap);
						skinBoxObject[index].name = index;
						skinBoxObject[index].addEventListener(MouseEvent.MOUSE_DOWN,skinMouseDown);
					}
					//在生成代码时改变组件的皮肤属性
					if(settingModel.skinUrl[id] == null){settingModel.skinUrl[id] = new Object}
					settingModel.skinUrl[id][index] = e.data;
					EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.GET_SKINATTRIBUTES,settingModel.skinUrl));
					return;
				}
			}
		}
		
		
		/**
		 * 显示UI可以设置的属性
		 */		
		private function setUI(e:EditorEvents):void
		{	
			var ui:DisplayObject = e.data;
			if(!ui)return;
			if(currentUI == ui)return;
			if(MainEditorModel.isPreviewMode)return;
			
			clearAll();
			currentUI = ui;
			
			commonSettint(ui);
			skinSetting(settingModel.UIIDDictionary[ui]);
		}
		
		
		/**
		 * 清空 
		 */		
		public function clearAll(e:EditorEvents = null):void
		{
			while(this.settingPanel.commonBox.numChildren!=0){
				this.settingPanel.commonBox.removeChildAt(0);
			}
			while(settingPanel.skinsBox.numChildren!=0){
				settingPanel.skinsBox.removeChildAt(0);
			}
			
			/*判断当是销毁组件的时候，顺便把settingpanel里面组件的皮肤属性销毁了，*/
			
			if(e != null && e.type == EditorEvents.REMOVE_UI) {
				if(settingModel.skinboxArr[settingModel.UIIDDictionary[e.data]] != null) {
					delete settingModel.skinboxArr[settingModel.UIIDDictionary[e.data]];
				}
				if(settingModel.skinUrl[settingModel.UIIDDictionary[e.data]] != null) {
					delete settingModel.skinUrl[settingModel.UIIDDictionary[e.data]];
				}
			}
		}
		
		/**
		 * 公共设置 
		 */		
		private function commonSettint(ui:DisplayObject):void
		{
			var item:HBox;
			for each (var arr:Array in settingModel.componentsAttributes[getQualifiedClassName(ui)]) {
				switch(arr[1]) {
					case "Input":
						item = createTextInputItem(ui,arr[0]);
						break;
					case "Boolean":
						item = createBooleanItem(ui,arr[0]);
						break;
				}
				settingPanel.commonBox.addChild(item);
			}
		}
		
		
		/**
		 *皮肤框设置，把组件拥有哪些皮肤属性全部用皮肤框显示出来，皮肤框里面可以拖动皮肤进去，ui会进行
		 * 相应的皮肤改变 
		 * @param id
		 * 
		 */
		private function skinSetting(id:int):void {
			
			trace(id,"nimamaibia ");
			
			if(settingModel.skinboxArr[id] != null) {
				var skinboxobj:Object = settingModel.skinboxArr[id];
				for(var i:int=0; i < skinboxobj["styleArr"].length; i++) {
					var index:String = skinboxobj["styleArr"][i];
					var styleLabel:Label = new Label();
					styleLabel.text = index;
					settingPanel.skinsBox.addChild(styleLabel);
					settingPanel.skinsBox.addChild(skinboxobj[index]);
				}
				return
			};
			
			var skinObject:Object = settingModel.componentsskins[getQualifiedClassName(settingModel.IDUIObject[id])];
			if(skinObject == null) {return;}
			var skinBoxObject:Object = new Object();
			var styleArr:Array = new Array();
			for each(var string:String in skinObject) {
				var skinLabel:Label = new Label();
				skinLabel.text = string;
				trace(string);
				
				var box:Box = new Box();
				box.setStyle("borderStyle","solid");
				box.width = 100;
				box.height = 100;
				styleArr.push(string);
				styleArr.length;
				skinBoxObject[string] = box;
				settingPanel.skinsBox.addChild(skinLabel);
				settingPanel.skinsBox.addChild(box);
			}
			skinBoxObject["styleArr"] = styleArr;
			//同样判断一遍 组件现在是否处于皮肤编辑状态
			MainEditorModel.isEditSkin ? settingPanel.skinsBox.visible = true : settingPanel.skinsBox.visible = false;
			settingModel.skinboxArr[id] = skinBoxObject;
		}
		
		/**
		 * 更新数据 
		 */		
		private function updateSetting(e:EditorEvents):void
		{
			if(currentUI == e.data){
				for each (var arr:Array in settingModel.componentsAttributes[getQualifiedClassName(e.data)]) {
					switch(arr[1]) {
						case "Input":
							cor[arr[0]].text = currentUI[arr[0]];
							break;
						case "Boolean":
							cor[arr[0]].selected = currentUI[arr[0]];
							break;
					}
				}
			}
		}
		
		private function drawUI(e:Event):void
		{
			//			for each (var arr:Array in settingModel.componentsAttributes[getQualifiedClassName(currentUI)]) {
			//				switch(arr[1]) {
			//					case "Input":
			//						currentUI[arr[0]] = cor[arr[0]].text ;
			//						break;
			//					case "Boolean":
			//						currentUI[arr[0]] = cor[arr[0]].selected;
			//						break;
			//				}
			//			}
			if(e.target is TextArea){
				currentUI[e.target.name] = e.target.text;
				updateset();
			} else {
				currentUI[e.target.name] = e.target.selected;
				updateset();
			}
			
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_STAGE));
		}
		
		private function updateset():void {
			for each (var arr:Array in settingModel.componentsAttributes[getQualifiedClassName(currentUI)]) {
				switch(arr[1]) {
					case "Input":
						cor[arr[0]].text = currentUI[arr[0]];
						break;
					case "Boolean":
						cor[arr[0]].selected = currentUI[arr[0]];
						break;
				}
			}
		}
		/**
		 * 创建项目
		 */		
		public function createTextInputItem(ui:DisplayObject,attributeName:String):HBox
		{
			var nameLabel:Label = new Label();
			nameLabel.text = attributeName;
			nameLabel.width = 50;
			var textArea:TextArea = new TextArea();
			textArea.wordWrap = true;
			textArea.width = 120;
			textArea.height = 22;
			textArea.x = 100;
			textArea.text = ui[attributeName];	
			textArea.name = attributeName;
			var hbox:HBox = new HBox();
			hbox.addChild(nameLabel);
			hbox.addChild(textArea);
			textArea.addEventListener(Event.CHANGE,drawUI);		
			cor[attributeName] = textArea;
			return hbox;
		}
		
		/**
		 * 创建Boolean属性容器
		 */	
		private function createBooleanItem(ui:DisplayObject,attributeName:String):HBox
		{
			var checkBox:CheckBox = new CheckBox();
			var box:HBox = new HBox();
			box.addChild(checkBox);
			checkBox.addEventListener(Event.CHANGE,drawUI);
			checkBox.label = "粗体";
			checkBox.name = attributeName;
			checkBox.selected = ui[attributeName];
			cor[attributeName] = checkBox;
			return box;
		}
		
		/**
		 * 创建ComboBox选择容器
		 */		
		private function createComboBoxItem(ui:DisplayObject,attributeName:String):HBox
		{
			var nameLabel:Label = new Label();
			var comboBox:ComboBox = new ComboBox();
			var hbox:HBox = new HBox();
			var arr:Array = new Array();
			hbox.addChild(nameLabel);
			hbox.addChild(comboBox);
			comboBox.addEventListener(Event.CHANGE,drawUI);
			
			switch(attributeName)
			{
				case "labelPlacement":
					nameLabel.text = "标签位置";
					arr.push({label:"bottom"});
					arr.push({label:"top"});
					arr.push({label:"left"});
					arr.push({label:"right"});
					comboBox.dataProvider = arr;
					if(ui[attributeName] == "bottom"){
						comboBox.selectedIndex = 0
					}else if(ui[attributeName] == "top"){
						comboBox.selectedIndex = 1
					}else if(ui[attributeName] == "left"){
						comboBox.selectedIndex = 2
					}else{
						comboBox.selectedIndex = 3
					}
					cor[attributeName] = comboBox;
					break;
			}
			return hbox;
		}
		
		/**
		 * 创建选择颜色容器 
		 * @return 
		 * 
		 */
		private function creatColorItem(ui:Sprite,attributeName:String):HBox
		{
			var nameLabel:Label = new Label();
			var colorPicker:ColorPicker = new ColorPicker();
			var hbox:HBox = new HBox();
			hbox.addChild(nameLabel);
			hbox.addChild(colorPicker);
			colorPicker.addEventListener(Event.CHANGE,drawUI);
			
			switch(attributeName)
			{
				case "color":
					nameLabel.text = "颜色  :";
					colorPicker.selectedColor = ui[attributeName];
					cor[attributeName] = colorPicker;
					break;
			}
			return hbox;
		}
		
		/**
		 *为皮肤添加点击事件，为以后的移除皮肤做好准备 
		 * @param e
		 * 
		 */
		protected function skinMouseDown(e:MouseEvent):void {
			if(currentSkin) {
				currentSkin.contextMenu = null;
			}
			e.currentTarget.contextMenu = contextMenu;
			currentSkin = e.currentTarget as Box;
		}
		
		/**
		 *移除选择的皮肤 
		 * @param event
		 * 
		 */
		protected function removeSelectSkin(event:Event):void
		{
			trace(currentSkin.rawChildren.numChildren);
			if(currentSkin.rawChildren.numChildren == 2) {
				currentSkin.rawChildren.removeChildAt(1);
			}
			currentUI[currentSkin.name] = UIFactory.uiSkin[getQualifiedClassName(currentUI)][currentSkin.name];
			var id:int = settingModel.UIIDDictionary[currentUI];
			delete settingModel.skinUrl[id][currentSkin.name];
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.GET_SKINATTRIBUTES,settingModel.skinUrl))
		}
		
		/**
		 *清空整个舞台的时候清空的属性栏 
		 * @param event
		 * 
		 */
		protected function clearStage(event:Event):void
		{
			for(var id:* in settingModel.skinUrl) {
				delete settingModel.skinUrl[id];
			}
			settingModel.skinUrl = new Dictionary();
			for(var i:* in settingModel.IDUIObject) {
				delete settingModel.IDUIObject[i];
			}
			settingModel.IDUIObject = new Dictionary();
			for(var j:* in settingModel.UIIDDictionary) {
				delete settingModel.UIIDDictionary[j]
			}
			settingModel.UIIDDictionary = new Dictionary();
			for(var k:* in settingModel.skinboxArr) {
				delete settingModel.skinboxArr[k];
			}
			settingModel.skinboxArr = new Dictionary();
			while(settingPanel.skinsBox.numChildren != 0) {
				settingPanel.skinsBox.removeChildAt(0);
			}
		}
	}
}