package src.containers
{
	import flash.display.Sprite;
	
	import mx.containers.Canvas;
	import mx.controls.ToggleButtonBar;
	
	import src.EditorConfig;

	/**
	 * 主舞台 
	 * @author yurs
	 * 
	 */	
	public class StagePanel extends Canvas
	{
		public var bgLayer:Sprite;
		public var uiLayer:Sprite;
		public var toggleButtonBar:ToggleButtonBar;
		
		public function StagePanel()
		{
			name = "EditPanel";
			
			bgLayer = new Sprite();
			uiLayer = new Sprite();
			toggleButtonBar = new ToggleButtonBar();
			
			var data_arr:Array = new Array();
			data_arr.push("主舞台");
			
			toggleButtonBar.dataProvider = data_arr;
			toggleButtonBar.width = EditorConfig.stagePanelWidth;
			toggleButtonBar.height = 30;
			
			bgLayer.y = toggleButtonBar.height+10;
			uiLayer.y = toggleButtonBar.height+10;
			
			this.rawChildren.addChild(bgLayer);
			this.rawChildren.addChild(uiLayer);
			this.rawChildren.addChild(toggleButtonBar);
			
			bgLayer.graphics.beginFill(0x999999,1);
			bgLayer.graphics.drawRect(0,0,EditorConfig.stagePanelWidth,EditorConfig.stagePanelHeight);
			bgLayer.graphics.endFill();
		}
	}
}