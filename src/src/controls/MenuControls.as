package src.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.core.ByteArrayAsset;
	import mx.skins.spark.EditableComboBoxSkin;
	
	import src.containers.MenuPanel;
	import src.events.CodeEvent;
	import src.events.EditorEvents;
	import src.events.KeyEvent;
	import src.events.MenuEvents;
	import src.models.MainEditorModel;
	import src.models.MenuModel;
	
	/**
	 * 菜单控制器 
	 * @author yurs
	 * 
	 */	
	public class MenuControls
	{
		private var state:String = "";
		private var menuPanel:MenuPanel;
		private var menuModel:MenuModel;
		private var byteArray:ByteArray = new ByteArray();
		private var number:int;
		
		private var file:File = new File();
		private var fileft:FileFilter = new FileFilter("ui","*ui");
		public function MenuControls(_menuPanel:MenuPanel,_menuModel:MenuModel)
		{
			menuPanel = _menuPanel;
			menuModel = _menuModel;
			
			MenuEvents.dispatcher.addEventListener(MenuEvents.IDINDEX_UPDATA,function(e:MenuEvents):void{
				menuModel.IDindex = e.data[0];
				menuModel.IDUIObject = e.data[1]
			});
			
			EditorEvents.dispathcer.addEventListener(EditorEvents.CREATE_FILE_COMPLETE,function(e:EditorEvents):void{
				trace("i'm very happy");
				byteArray = e.data[0];
				menuPanel.codePanel.codeText.text = e.data[1];
			});
			EditorEvents.dispathcer.addEventListener(EditorEvents.CREATE_CODE_COMPLETE,function(e:EditorEvents):void{
				menuPanel.codePanel.codeText.text = e.data;
			});
			
			menuPanel.exportCodeBtn.addEventListener(MouseEvent.CLICK,function():void{codeBtnClick("exportcode")});
			menuPanel.importXMLBtn.addEventListener(MouseEvent.CLICK,function():void{codeBtnClick("IMPORTFILE")});
			menuPanel.exportXMLBtn.addEventListener(MouseEvent.CLICK,function():void{codeBtnClick("exportfile")});
			menuPanel.codePanel.x = 200,menuPanel.codePanel.y = 100;
			menuPanel.selectCodePanel.x = 400,menuPanel.selectCodePanel.y = 250;
			
		}
		
		/**
		 * 点击菜单按钮，自己进行判断
		 * @param e
		 * 
		 */		
		private function codeBtnClick(name:String):void
		{
			state = "";
			MainEditorModel.isEditState = false;
			
			
			switch(name) {
				case "exportcode":
					state = "EXPORTCODE";
					menuPanel.parent.addChild(menuPanel.selectCodePanel);
					menuPanel.selectCodePanel.Label.text = "类名";
					menuPanel.selectCodePanel.danli.visible = true;
					menuPanel.selectCodePanel.codeButton.addEventListener(MouseEvent.CLICK,onclick);
					break;
				case "exportfile":
					state = "EXPORTFILE";
					menuPanel.parent.addChild(menuPanel.selectCodePanel);
					menuPanel.selectCodePanel.Label.text = "文件名";
					menuPanel.selectCodePanel.danli.visible = false;
					menuPanel.selectCodePanel.codeButton.addEventListener(MouseEvent.CLICK,onclick);
					break;
				case "IMPORTFILE":
					file.browse([fileft]);
					file.addEventListener(Event.SELECT,onSelect);
					break;
				case "EXPORTCODE":
					state = "EXPORTCODE";
					menuPanel.codePanel.title = "导出代码";
					menuPanel.parent.addChild(menuPanel.codePanel);
					menuPanel.selectCodePanel.codeButton.removeEventListener(MouseEvent.CLICK,onclick);
					if(menuPanel.selectCodePanel.parent)menuPanel.selectCodePanel.parent.removeChild(menuPanel.selectCodePanel);
					EditorEvents.dispathcer.dispatchEvent(new CodeEvent(CodeEvent.CREAT_CODE,[menuModel.IDindex,menuModel.IDUIObject,menuPanel.selectCodePanel.cName.text,menuPanel.selectCodePanel.danli.selected]));
					menuPanel.codePanel.codeBtn.removeEventListener(MouseEvent.CLICK,codeEnter);
					menuPanel.codePanel.codeBtn.addEventListener(MouseEvent.CLICK,codeEnter);
					break;
				case "EXPORTFILE":
					state = "EXPORTFILE";
					menuPanel.codePanel.title = "导出文件";
					menuPanel.parent.addChild(menuPanel.codePanel);
					if(menuPanel.selectCodePanel.parent)menuPanel.selectCodePanel.parent.removeChild(menuPanel.selectCodePanel);
					EditorEvents.dispathcer.dispatchEvent(new CodeEvent(CodeEvent.CREATE_FILE,[menuModel.IDindex,menuModel.IDUIObject]));
					menuPanel.selectCodePanel.codeButton.removeEventListener(MouseEvent.CLICK,onclick);
					menuPanel.codePanel.codeBtn.removeEventListener(MouseEvent.CLICK,codeEnter);
					menuPanel.codePanel.codeBtn.addEventListener(MouseEvent.CLICK,codeEnter);
					break;
			}
		}
		
		protected function onclick(event:MouseEvent):void
		{
			codeBtnClick(state);
		}
		
		/**
		 * 导入代码 
		 * @param e
		 * 
		 */		
		private function codeEnter(e:MouseEvent):void
		{
			menuPanel.codePanel.parent.removeChild(menuPanel.codePanel);
			menuPanel.codePanel.codeBtn.removeEventListener(MouseEvent.CLICK,codeEnter);
			
			switch(state) {
				case "EXPORTFILE":
					new FileReference().save(byteArray,menuPanel.selectCodePanel.cName.text+".ui");
					break;
				case "EXPORTCODE":
					//					var code:ByteArray =new ByteArray();
					//					code.writeMultiByte(codePanel.codeText.text,"utf-8");
					var code:String = menuPanel.codePanel.codeText.text;
					new FileReference().save(code,menuPanel.selectCodePanel.cName.text+".as");
					break;
			}
		}
		
		protected function onSelect(event:Event):void
		{
			var filestream:FileStream = new FileStream();
			filestream.open(file,FileMode.READ);
			var data:ByteArray = new ByteArray();
			filestream.readBytes(data);
			EditorEvents.dispathcer.dispatchEvent(new CodeEvent(CodeEvent.IMPORT_FILE,data));
		}
	}
}