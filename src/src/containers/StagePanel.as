package src.containers
{
	import flash.display.Shape;
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
		public var bgLayerin:Sprite;
		public var uiLayer:Sprite;
		private var uiLayerMask:Shape;
		public var toggleButtonBar:ToggleButtonBar;
		
		public function StagePanel()
		{
			name = "EditPanel";
			
			bgLayer = new Sprite();
			bgLayerin = new Sprite();
			uiLayer = new Sprite();
			uiLayerMask = new Shape();
			toggleButtonBar = new ToggleButtonBar();
			
			var data_arr:Array = new Array();
			data_arr.push("主舞台");
			
			toggleButtonBar.dataProvider = data_arr;
			toggleButtonBar.width = EditorConfig.stagePanelWidth;
			toggleButtonBar.height = 30;
			
			bgLayer.y = 40;
			bgLayerin.x = 50; bgLayerin.y = 90;
			uiLayerMask.x = 50; uiLayerMask.y = 90;
			uiLayer.x = 50;   uiLayer.y = 90;
			
			bgLayer.graphics.beginFill(0x999999,1);
			bgLayer.graphics.drawRect(0,0,EditorConfig.stagePanelWidth,EditorConfig.stagePanelHeight);
			bgLayer.graphics.endFill();
			
			bgLayerin.graphics.beginFill(0xffffff,1);
			bgLayerin.graphics.drawRect(0,0,650,450);
			bgLayerin.graphics.endFill();
			
			uiLayerMask.graphics.beginFill(0xffffff,1);
			uiLayerMask.graphics.drawRect(0,0,650,450);
			uiLayerMask.graphics.endFill();
			uiLayer.mask = uiLayerMask;
			
			this.rawChildren.addChild(bgLayer);
			this.rawChildren.addChild(bgLayerin);
			this.rawChildren.addChild(uiLayer);
			this.rawChildren.addChild(uiLayerMask);
			this.rawChildren.addChild(toggleButtonBar);
		}
	}
}