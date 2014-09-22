package src.containers
{
	import mx.containers.HBox;
	import mx.controls.Button;

	public class MenuPanel extends HBox
	{
		public var exportCodeBtn:Button;
		public var importXMLBtn:Button;
		public var exportXMLBtn:Button;
		public var helpBtn:Button;
		public var newBuild:Button;
		
		public var codePanel:CodePanel;
		public var selectCodePanel:SelectCodePanel;
		
		public function MenuPanel()
		{
			this.setStyle("fontSize",12);
			
			exportCodeBtn = new Button();
			exportCodeBtn.label = "导出代码";
			exportCodeBtn.name = "exportCode";
			addChild(exportCodeBtn);
			
			importXMLBtn = new Button();
			importXMLBtn.label = "导入文件";
			importXMLBtn.name = "import";
			addChild(importXMLBtn);
			
			exportXMLBtn = new Button();
			exportXMLBtn.label = "导出文件";
			exportXMLBtn.name = "export";
			addChild(exportXMLBtn);
			
			
			codePanel = new CodePanel();
			selectCodePanel = new SelectCodePanel();
			trace("实例化");
//			helpBtn = new Button();
//			helpBtn.label = "帮助";
//			addChild(helpBtn);
//			
//			newBuild = new Button();
//			newBuild.label = "新建";
//			addChild(newBuild);
		}
	}
}