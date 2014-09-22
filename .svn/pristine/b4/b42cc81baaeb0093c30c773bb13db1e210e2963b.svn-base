package src
{
	import mx.containers.Canvas;
	import mx.containers.HBox;
	
	import src.containers.ComponentPanel;
	import src.containers.SettingPanel;
	import src.containers.StagePanel;
	import src.controls.ComponentControls;
	import src.controls.EditControls;
	import src.controls.SettingControls;
	import src.controls.StageControls;
	import src.controls.TensileControls;

	public class EditPanel extends Canvas
	{
		/**
		 * 组件选择栏 
		 */		
		private var componentPanel:ComponentPanel; 
		
		/**
		 * 主舞台 
		 */		
		private var stagePanel:StagePanel;
		
		/**
		 * 属性栏 
		 */		
		private var settingPanel:SettingPanel;
		
		/**
		 * 主舞台控制器 
		 */		
		private var stageControls:StageControls;
		
		/**
		 * 组件栏控制器 
		 */		
		private var componentControls:ComponentControls;
		
		/**
		 * 组件栏控制器 
		 */		
		private var settingControls:SettingControls;
		
		private var editStateControls:TensileControls;
		private var editControls:EditControls;
		
		public function EditPanel()
		{
			componentPanel = new ComponentPanel();
			addChild(componentPanel);
			
			stagePanel = new StagePanel();
			addChild(stagePanel);
			stagePanel.x = 190;
			
			settingPanel = new SettingPanel();
			addChild(settingPanel);
			settingPanel.x = EditorConfig.stagePanelWidth+240;
			
			stageControls = new StageControls(stagePanel);
			componentControls = new ComponentControls(componentPanel);
			settingControls = new SettingControls(settingPanel);
			editStateControls = new TensileControls();
			editControls = new EditControls();
		}
	}
}