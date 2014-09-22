package src.models
{
	import flash.utils.Dictionary;

	/**
	 *@author tanshiyu
	 *@date 2013-9-9
	 */
	public class SettingModel
	{
		/**
		 * 组件的属性，包括 x坐标，y坐标，高度，宽度，但是不包括皮肤这个特殊属性
		 */	
		public var componentsAttributes:Object = new Object();
		/**
		 *  组件的皮肤属性，只是在编辑组件时有用，里面只是介绍组件有哪些皮肤，但是相应的皮肤样式没告诉
		 */	
		public var componentsskins:Object = new Object();
		
		
		
		/**
		 *UI的ID数组，里面相应的ID对应着相应的UI 
		 */
		public var IDUIObject:Dictionary = new Dictionary();
		
		/**
		 *UI的ID字典，里面相应的UI对应着相应的ID，与上面的那个相辅相成 
		 */
		public var UIIDDictionary:Dictionary =new Dictionary();
		
		
		
		/**
		 * 装着各个组件的皮肤信息，包括皮肤的样式和状态（比如simpleButton的upstate皮肤是一个sprite）
		 */
		public var skinboxArr:Dictionary = new Dictionary;
		/**
		 *  组件的皮肤属性，只是在生成xml和代码时有用，里面装的是组件皮肤的相应URL地址，里卖直接告诉组件的那些皮肤具有那些样式
		 */	
		public var skinUrl:Dictionary = new Dictionary();
		
		public function SettingModel()
		{
		}
	}
}