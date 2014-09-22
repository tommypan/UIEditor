package src.models
{
	import flash.utils.Dictionary;

	/**
	 *@author tanshiyu
	 *@date 2013-9-9
	 */
	public class XMLModel
	{
		/**
		 * 相应的ui的id对应的相应的层次
		 */
		public var IDIndex:Dictionary;
		/**
		 * 相应的ui的id对应着相应的ui
		 */
		public var IDUIObejct:Dictionary;
		
		/**
		 *在编辑器中每个组件的皮肤属性 ，当在生成代码的时候，这个属性很有用，
		 * 这个属性是由settingcontrol实时更新过来的
		 */		
		public var skinUrl:Dictionary = new Dictionary();
		
		public var componentsAtrributes:Object;
		
		public var componentsSkins:Object;
		public function XMLModel()
		{
		}
	}
}