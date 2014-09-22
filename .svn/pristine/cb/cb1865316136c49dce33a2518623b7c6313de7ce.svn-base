package src.utils
{
	public class ColorUtil
	{
		/**
		 * 把颜色值转为字符串表示 
		 * @param color    0x00ff00
		 * @return    0x00ff00
		 * 
		 */		
		public static function transferToString(color:uint):String
		{
			var colorStr:String = color.toString(16);
			var len:int = 6-colorStr.length;
			var endStr:String = "0x";
			for(var i:int=0;i<len;i++){
				endStr += "0";
			}
			endStr+=colorStr;
			return endStr;
		}
		
		
		/**
		 * 把颜色值转为无整数型 
		 * @param color   #00ff00 或者 0x00ff00
		 * @return 
		 * 
		 */		
		public static function trasfetToUint(color:String):uint
		{
			var colorStr:String = color.replace("#","0x");
			var colorUint:uint = new uint(colorStr);
			return colorUint;
		}
	}
}