package src.managers
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.net.getClassByAlias;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import morn.core.components.Label;
	import morn.core.components.SimpleButton;
	import morn.core.components.SimpleImage;
	import morn.core.utils.BitmapUtils;
	
	import qmang2d.utils.ClassManager;
	
	
	public class UIFactory
	{
		
		private static var labelNumber:int;
		private static var simpleButtonNumber:int;
		private static var simpleImageNumber:int;
		public static var uiSkin:Dictionary = new Dictionary();
		/**
		 * 创建UI 
		 */		
		public static function createUI(type:String,name:String = ""):Sprite
		{
			var object:Object;
			switch(type)
			{
				case "Label":
					var label:Label = new Label("标签");
					if(labelNumber != 0) {
						label.name = "label" + labelNumber;
					} else {
						label.name = "label";
					}
					labelNumber++;
					return label;
					break;
				case "SimpleButton":
					var simpleButton:SimpleButton = new SimpleButton();
					if(simpleButtonNumber != 0) {
						simpleButton.name = "simpleButton" + simpleButtonNumber;
					} else {
						simpleButton.name = "simpleButton";
						
						var buttonBitmapclips:Vector.<BitmapData> = BitmapUtils.createClips(ClassManager.createBitmapDataInstance("button"),1,3);
						object = new Object();
						object["upState"] = new Bitmap(buttonBitmapclips[0]);
						object["overState"] = new Bitmap(buttonBitmapclips[1]);
						object["downState"] = new Bitmap(buttonBitmapclips[2]);
						uiSkin[getQualifiedClassName(simpleButton)] = object;
					}
					simpleButton.upState = uiSkin[getQualifiedClassName(simpleButton)]["upState"];
					simpleButton.overState = uiSkin[getQualifiedClassName(simpleButton)]["overState"];
					simpleButton.downState = uiSkin[getQualifiedClassName(simpleButton)]["downState"];
					simpleButtonNumber++;
					return simpleButton;
					break;
				case "SimpleImage":
					var image:SimpleImage = new SimpleImage();
					image.image = new Bitmap(ClassManager.createBitmapDataInstance("tab"));
					if(simpleImageNumber != 0) {
						image.name = "simpleImage" + simpleImageNumber;
					} else {
						image.name = "simpleImage";
						object = new Object();
						object["image"] = new Bitmap(ClassManager.createBitmapDataInstance("tab"));
						uiSkin[getQualifiedClassName(image)] = object; 
					}
					image.image = uiSkin[getQualifiedClassName(image)]["image"];
					simpleImageNumber++;
					return image;
					break;
				
				default:
					return null;
			}
		}
	}
}