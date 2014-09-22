package src
{
	import mx.containers.Canvas;
	
	import qmang2d.loader.LoaderManager;
	
	import src.containers.ComponentPanel;
	import src.containers.MenuPanel;
	import src.containers.ProjectPanel;
	import src.containers.SettingPanel;
	import src.containers.StagePanel;
	import src.controls.ComponentControls;
	import src.controls.KeyControl;
	import src.controls.MenuControls;
	import src.controls.ProjectControls; 
	import src.controls.SettingControls;
	import src.controls.StageControls;
	import src.controls.XMLControls;
	import src.models.ComponentModel;
	import src.models.MenuModel;
	import src.models.ProjectModel;
	import src.models.SettingModel;
	import src.models.StageModel;
	import src.models.XMLModel;

	public class MainEditor extends Canvas
	{
		//-------------------------全局属性---------------------
		
		private var isInto:Boolean = false;
		
		
		//-------------------------控制器与数据and界面------------------------
		/**
		 * 菜单栏 
		 */		
		private var menuPanel:MenuPanel;
		
		/**
		 *菜单栏控制器 
		 */
		private var menuControls:MenuControls;
		/**
		 * 菜单数据
		 */
		private var menuModel:MenuModel;
		
		
		
		/**
		 * 组件选择栏 
		 */		
		private var componentPanel:ComponentPanel; 
		/**
		 * 组件栏控制器 
		 */			
		private var componentControls:ComponentControls;
		/**
		 * 组件数据
		 */
		private var componentModel:ComponentModel;
		
		
		
		/**
		 * 主舞台 
		 */		
		private var stagePanel:StagePanel;
		/**
		 * 主舞台控制器 
		 */		
		private var stageControls:StageControls;
		/**
		 * 主舞台数据
		 */
		private var stageModel:StageModel;
		
		
		
		/**
		 *项目栏 
		 */
		private var projectPanel:ProjectPanel;		
		/**
		 * 项目栏控制器 
		 */		
		private var projectControls:ProjectControls;
		/**
		 * 项目栏数据
		 */
		private var projectModel:ProjectModel;
		
		
		
		/**
		 * 属性栏 
		 */		
		private var settingPanel:SettingPanel;
		/**
		 * 属性栏控制器 
		 */		
		private var settingControls:SettingControls;
		/**
		 * 属性栏数据
		 */
		private var settingModel:SettingModel;
		
		
		//-----------------------一些链接外部的控制器，如键盘输入控制------------
		private var xmlControls:XMLControls;
		private var xmlModel:XMLModel;
		private var keyControl:KeyControl;
		
		public function MainEditor()
		{
			LoaderManager.getInstance().getModualSwf("res/tanxian.swf",SWFonComplete);
		}
		
		private function SWFonComplete():void
		{
			
			LoaderManager.getInstance().getXml("res/ComponentsAttributes.xml",XMLonComplete);
			
			//----------------------初始化舞台---------------------------
			stagePanel = new StagePanel();
			addChild(stagePanel);
			stagePanel.x = 180;
			stagePanel.y = 50;
			stageModel = new StageModel();
			stageControls = new StageControls(stagePanel,stageModel);
			
			//------------------------初始化组件栏----------------------------
			componentPanel = new ComponentPanel();
			addChild(componentPanel);
			componentPanel.y = 50;
			componentModel = new ComponentModel();
			componentControls = new ComponentControls(componentPanel,componentModel);
			
			//-------------------------初始化菜单栏---------------------------
			menuPanel = new MenuPanel();
			addChild(menuPanel);
			menuPanel.x = 25;
			menuModel = new MenuModel();
			menuControls = new MenuControls(menuPanel,menuModel);
				
			//-------------------------初始化其它控制器---------------------------
			xmlModel = new XMLModel();
			xmlControls = new XMLControls(xmlModel);
			keyControl = new KeyControl();
			
		}
		
		protected function XMLonComplete(xml:XML):void
		{
			//-------------------------初始化属性栏---------------------------
			settingPanel = new SettingPanel();
			addChild(settingPanel);
			settingPanel.y = 50;
			settingPanel.x = EditorConfig.stagePanelWidth+230;
			settingModel = new SettingModel();
			settingControls = new SettingControls(settingPanel,settingModel,xml);
			
			//------------------------初始化项目栏----------------------------
			projectPanel = new ProjectPanel();
			addChild(projectPanel);
			projectPanel.x = settingPanel.x + 200;
			projectPanel.y = 50;
			projectModel = new ProjectModel();
			projectControls = new ProjectControls(projectPanel,projectModel);
		}
	}
}