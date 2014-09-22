package src.utils
{
	import flash.display.Sprite;
	
	import type.ButtonLabelPlacement;

	/**
	 * 找出 Button不同的属性
	 * @author yurs
	 * 
	 */	
	public class ButtonProprityUtil
	{
		private static var label:String = "Label";
		private static var labelPlacement:String = ButtonLabelPlacement.RIGHT
		private static var fontSize:Number = 12;
		private static var fontFamily:String = "Times New Roman";
		private static var color:Number = 0x000000;
		private static var isBold:Boolean = false;
		private static var textPadding:Number = 5;
		
		public static function findNotSame(ui:Sprite,property:String):String
		{
			var propertyArr:Array = property.split(",");
			var propertyStr:String = "";
			var length:Number = propertyArr.length;
			for(var i:Number = 0;i < length;i++){
				if(ui[propertyArr[i]] != ButtonProprityUtil[propertyArr[i]]){
					propertyStr += propertyArr[i]+",";
				}
			}
			propertyStr = propertyStr.slice(0,propertyStr.length-1);
			if(propertyStr != ""){
				propertyStr = ","+propertyStr;
			}
			return propertyStr;
		}
	}
}