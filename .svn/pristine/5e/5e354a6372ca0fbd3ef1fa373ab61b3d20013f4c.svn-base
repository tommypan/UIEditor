package src.controls
{
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	import src.containers.ComponentPanel;
	import src.events.ComponentEvent;
	import src.events.EditorEvents;
	import src.models.ComponentModel;

	/**
	 * 组件栏控制器 
	 * @author yurs
	 * 
	 */	
	public class ComponentControls
	{
		private var componentPanel:ComponentPanel;
		private var componentModel:ComponentModel;
		
		
		public function ComponentControls(_componentPanel:ComponentPanel,_componentModel:ComponentModel)
		{
			componentPanel = _componentPanel;
			componentModel = _componentModel;
			createList(componentModel.uiName.split(","));
		}
		
		/**
		 * 创建组件列表 
		 * @param ary
		 * 
		 */
		private function createList(ary:Array):void
		{
			for(var i:int=0;i<ary.length;i++){
				var button:Button = new Button();
				button.label = ary[i];
				button.width = 100;
				button.height = 22;
				componentPanel.originalBox.addChild(button);
				button.x = 30;
				button.y = i*(button.height+5);
				button.addEventListener(MouseEvent.MOUSE_DOWN,originalDown);
			}
			componentPanel.newMyBox.y = ary.length*22+100;
		}
		
		/**
		 * 点击拖动组件 
		 * @param ary
		 * 
		 */
		private function originalDown(e:MouseEvent):void
		{
			EditorEvents.dispathcer.dispatchEvent(new ComponentEvent(ComponentEvent.DOWN_UI,e.target));
		}
	}
}