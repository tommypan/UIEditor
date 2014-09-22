package src.controls
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	import src.containers.ProjectPanel;
	import src.events.EditorEvents;
	import src.events.ProjectEvents;
	import src.models.MainEditorModel;
	import src.models.ProjectModel;

	/**
	 *@author tanshiyu
	 *@date 2013-8-29
	 */
	public class ProjectControls
	{
		private var projectModel:ProjectModel;
		private var projectPanel:ProjectPanel;
		
		public static var dataFiles :Array = new Array();
		private var _xmlDataSelectFile:File;
		private var _mapDataFileFilter:FileFilter = new FileFilter("Image", "*.png;*.jpg;");//地图文件过滤
		private var _dataFile:File;
		
		private var data :ByteArray = new ByteArray();
		private var currentUrlString:String;
		private var currentIndex:int;
		/**
		 *当前拖动的sprite 
		 */
		private var dragSprite:Sprite;
		
		public function ProjectControls(_projectPanel:ProjectPanel,_projectModel:ProjectModel)
		{
			projectPanel = _projectPanel;
			projectModel = _projectModel;
			addListener();
		}
		
		private function addListener():void
		{
			projectPanel.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onDragInHandler);
			projectPanel.openbutton.addEventListener(MouseEvent.CLICK,onOpen);
			EditorEvents.dispathcer.addEventListener(EditorEvents.UPDATE_UI,updateUI);
			EditorEvents.dispathcer.addEventListener(EditorEvents.REMOVE_UI,removeUI);
			EditorEvents.dispathcer.addEventListener(EditorEvents.CLEAR_STAGE,clearStage);
			ProjectEvents.dispatcher.addEventListener(ProjectEvents.UPDATA_PROJECT,updataProject);
		}
		
		/**
		 *当导入XML的时候会把XML里面组件的皮肤和组件添加到相应的项目库中 
		 * @param event
		 * 
		 */
		protected function updataProject(event:ProjectEvents):void
		{
		/*	// add component
			var bitmapdate:BitmapData = new BitmapData(event.data[0].width,event.data[0].height);
			bitmapdate.draw(event.data[0]);
			var bitmap:Bitmap = new Bitmap(bitmapdate);
			bitmap.width = bitmap.height = 20;
			var bitmapBox:Box = new Box();
			bitmapBox.setStyle("borderStyle","solid");
			bitmapBox.width = bitmapBox.height = 20;
			bitmapBox.rawChildren.addChild(bitmap);
			var bitmapLabel:Label = new Label();
			bitmapLabel.text = event.data[0].name;
			var hbox:HBox = new HBox();
			hbox.addChild(bitmapBox);
			hbox.addChild(bitmapLabel);
			projectModel.compDictionary[event.data[0]] = hbox;
			projectPanel.componentsBox.addChild(hbox);*/
			
			//add picture
			var bitmapdata:BitmapData = new BitmapData(event.data[0].width,event.data[0].height);
			bitmapdata.draw(event.data[0]);
			var bitmap:Bitmap = new Bitmap(bitmapdata);
			var bitmapContainer:Sprite = new Sprite();
			bitmapContainer.addChild(bitmap);
			bitmapContainer.width = 20;
			bitmapContainer.height = 20;
			bitmapContainer.buttonMode = true;
			bitmapContainer.name =currentIndex.toString();
			projectModel.urlDictionary[bitmapContainer.name] = event.data[1];
			bitmapContainer.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			var bitmapBox1:UIComponent = new UIComponent;
			bitmapBox1.addChild(bitmapContainer);
			bitmapBox1.setStyle("borderStyle","solid");
			bitmapBox1.width = bitmapContainer.width;
			bitmapBox1.height = bitmapContainer.height;
			projectPanel.resBox.addChild(bitmapBox1);
			currentIndex++;
		}
		
		protected function onOpen(event:MouseEvent):void
		{
			_xmlDataSelectFile = File.applicationDirectory;
			_xmlDataSelectFile.browseForOpenMultiple("选择要处理的图片文件",[_mapDataFileFilter]);
			_xmlDataSelectFile.addEventListener(FileListEvent.SELECT_MULTIPLE,selectMapData);
		}
		
		//选择了地图文件
		/**
		 *选择本地图片时触发该函数 
		 * @param evet
		 * 
		 */
		private function selectMapData(evet:FileListEvent):void{
			
			_xmlDataSelectFile.removeEventListener(Event.SELECT,selectMapData);
			
			for(var i:int=0; i<evet.files.length; i++) {
				_dataFile = File(evet.files[i]);
				dataFiles.push(_dataFile);
				showPic();
			}
		}
		
		/**
		 *拖动图片到项目栏的时候会触发该函数 
		 * @param event
		 * 
		 */
		protected function onDragInHandler(event:NativeDragEvent):void
		{
			var transferable : Clipboard = event.clipboard;
			
			if(transferable.hasFormat(ClipboardFormats.FILE_LIST_FORMAT))
			{
				var files : Array = transferable.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
				
				if(files)
				{
					_dataFile= File(files[files.length-1]);
					
					if((_dataFile.name.indexOf(".png")== -1))
					{
						Alert.show("请导入png文件");
					}else{
						Alert.show("图片文件已经成功导入");
						
						dataFiles.push(_dataFile);
						showPic();
					}
				}
			}
		}
		
		/**
		 *当选择本地图片和拖动图片的时候会吧相应的图片显示在项目栏中的图片库中 
		 * 
		 */
		private function showPic():void
		{
			var fileStream :FileStream = new FileStream();
			fileStream.open(dataFiles[dataFiles.length-1], FileMode.READ);
			fileStream.readBytes(data);//将字节读入data
			
			var dataFile :File = dataFiles[dataFiles.length -1];
			var _urlStr :String= File.applicationDirectory.nativePath;
			var name :String = dataFile.name.substring(0,dataFile.name.length-3);
			_urlStr = _urlStr.replace(/\\/g, "/");
			var path :String = _urlStr+'/data/'+name+"png";
			var fileStream1 :FileStream = new FileStream();
			fileStream1.open( new File(path),FileMode.WRITE);
			fileStream1.writeBytes(data);
			fileStream1.close();
			
			fileStream.close();
			
			var _loader :Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onHadlePic);
//			_loader.loadBytes(data);
			var urlstring:String;
			urlstring = "data/" + name + "png";
			_loader.load(new URLRequest(urlstring));
			function onHadlePic(event:Event):void
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onHadlePic);
				var bitmap :Bitmap = event.target.content as Bitmap;
				var bitmapContainer:Sprite = new Sprite();
				bitmapContainer.addChild(bitmap);
				bitmapContainer.width = 20;
				bitmapContainer.height = 20;
				bitmapContainer.buttonMode = true;
				bitmapContainer.name =currentIndex.toString();
				projectModel.urlDictionary[bitmapContainer.name] = urlstring;
				bitmapContainer.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				bitmapContainer.getChildAt(0);
				
				var bitmapBox:UIComponent = new UIComponent;
				bitmapBox.addChild(bitmapContainer);
				bitmapBox.setStyle("borderStyle","solid");
				bitmapBox.width = bitmapContainer.width;
				bitmapBox.height = bitmapContainer.height;
				projectPanel.resBox.addChild(bitmapBox);
				currentIndex++;
			}
		}
		
		/**
		 *为项目栏中的图片添加mousedown监听，当点击图片过后会复制一个图片 
		 * @param event
		 * 
		 */
		protected function onMouseDown(event:MouseEvent):void
		{
			currentUrlString = projectModel.urlDictionary[event.target.name];
			var bitmapdate:BitmapData = new BitmapData(event.target.getChildAt(0).width,event.target.getChildAt(0).height,true);
			bitmapdate.draw(event.target as DisplayObject);
			var bitmap:Bitmap = new Bitmap(bitmapdate);
			bitmap.width = 30;
			bitmap.height = 30;
			dragSprite = new Sprite();
			dragSprite.addChild(bitmap);
			dragSprite.x = projectPanel.stage.mouseX - dragSprite.width/2;
			dragSprite.y = projectPanel.stage.mouseY - dragSprite.height/2;
			dragSprite.buttonMode = true;
			
			projectPanel.stage.addChild(dragSprite);
			dragSprite.startDrag();
			projectPanel.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		/**
		 *为拖动图片添加相应的舞台mouseup监听，如果这是为属性栏里面设置皮肤用的 
		 * @param event
		 * 
		 */
		protected function onMouseUp(event:MouseEvent):void
		{
			event.target.stopDrag();
			projectPanel.stage.removeChild(dragSprite);
			projectPanel.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			//判断现在是否是在编辑皮肤状态，如果是则发送拖动图片消息，如果不是则不发送
			if(MainEditorModel.isEditSkin) {
				EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CHANGE_SKIN,currentUrlString));
			}
		}
		
		/**
		 *当创建相应Ui的时候会在项目栏中的组件栏创建相应的组件 
		 * @param event
		 * 
		 */
		protected function updateUI(event:EditorEvents):void {
			var bitmapdate:BitmapData = new BitmapData(event.data.width,event.data.height);
			bitmapdate.draw(event.data);
			var bitmap:Bitmap = new Bitmap(bitmapdate);
			bitmap.width = bitmap.height = 20;
			var bitmapBox:Box = new Box();
			bitmapBox.setStyle("borderStyle","solid");
			bitmapBox.width = bitmapBox.height = 20;
			bitmapBox.rawChildren.addChild(bitmap);
			var bitmapLabel:Label = new Label();
			bitmapLabel.text = event.data.name;
			var hbox:HBox = new HBox();
			hbox.addChild(bitmapBox);
			hbox.addChild(bitmapLabel);
			projectModel.compDictionary[event.data] = hbox;
			projectPanel.componentsBox.addChild(hbox);
		}
		
		/**
		 *当移除UI的时候会才项目栏中的组件栏中移除相应的组件 
		 * @param event
		 * 
		 */
		protected function removeUI(event:EditorEvents):void {
			projectPanel.componentsBox.removeChild(projectModel.compDictionary[event.data]);
			delete projectModel.compDictionary[event.data];
		}
		
		
		/**
		 *清空整个舞台的时候清空的项目栏 
		 * @param event
		 * 
		 */
		protected function clearStage(event:Event):void
		{
			currentIndex = 0;
			for(var id:* in projectModel.urlDictionary) {
				delete projectModel.urlDictionary[id];
			}
			projectModel.urlDictionary = new Dictionary();
			for(var index:* in projectModel.compDictionary) {
				projectPanel.componentsBox.removeChild(projectModel.compDictionary[index]);
				delete projectModel.compDictionary[index];
			}
			projectModel.compDictionary = new Dictionary();
			while(projectPanel.resBox.numChildren != 0) {
				projectPanel.resBox.removeChildAt(0);
			}
		}
	}
}