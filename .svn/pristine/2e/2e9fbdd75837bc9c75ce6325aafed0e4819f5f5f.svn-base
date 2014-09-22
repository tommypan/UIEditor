package src.containers
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import mx.containers.Box;
	import mx.containers.VBox;
	import mx.controls.CheckBox;
	import mx.controls.Label;

	/**
	 * 属性设置容器 
	 * @author yurs
	 * 
	 */	
	public class SettingPanel extends VBox
	{
		
		
		private var settingLabel:Label = new Label();
		/**
		 * 预览模式 和改变皮肤模式
		 * 通过改变这个模式，你可以选择改变皮肤和进行九宫格缩放
		 */		
		public var editStateCheck:CheckBox = new CheckBox();
		public var editSkinCheck:CheckBox = new CheckBox();
		
		/**
		 * 共用属性 
		 */		
		public var commonBox:VBox = new VBox();
		
		/**
		 *皮肤属性 
		 */
		public var skinsBox:VBox = new VBox();
		
		public function SettingPanel()
		{
			settingLabel.text = "属性设置";
			editStateCheck.label = "编辑状态";
			editSkinCheck.label = "编辑皮肤";
			
			this.addChild(settingLabel);
			this.addChild(editStateCheck);
			this.addChild(editSkinCheck);
			this.addChild(commonBox);
			this.addChild(skinsBox);
			this.setStyle("fontSize",12);
			
		}
	}
}