package src.models
{
	import flash.utils.Dictionary;

	/**
	 *@author tanshiyu
	 *@date 2013-9-9
	 */
	public class StageModel
	{
		/**
		 *UI的ID数组，里面相应的ID对应着相应的UI 
		 */
		public var IDUIObject:Dictionary = new Dictionary();
		
		/**
		 *UI的ID字典，里面相应的UI对应着相应的ID，与上面的那个相辅相成 
		 */
		public var UIIDDictionary:Dictionary =new Dictionary();
		
		/**
		 *DIUIObject字典里面id对应的显示层次， 
		 */
		public  var IDindex:Dictionary = new Dictionary();
		public function StageModel()
		{
			
		}
	}
}