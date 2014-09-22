package src.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.Request;
	
	import src.events.CodeEvent;
	import src.events.EditorEvents;
	import src.events.ProjectEvents;
	import src.events.SettingEvents;
	import src.managers.UIFactory;
	import src.models.XMLModel;
	
	/**
	 * 导出成XML 
	 * @author yurs
	 * 
	 */	
	public class XMLControls
	{
		private var xmlModle:XMLModel;
		
		/**
		 * 当前界面的代码
		 */
		private var CodeStr:String;
		/**
		 * 当前界面的XML
		 */		
		private var XMLStr:String;
		
		/**
		 * 导入的XML
		 */		
		private var importFileByteArray:ByteArray;
		
		private var mainWin:Sprite;
		
		public function XMLControls(_xmlModel:XMLModel)
		{
			xmlModle = _xmlModel;
			addListener();
		}
		
		private function addListener():void
		{
			EditorEvents.dispathcer.addEventListener(CodeEvent.CREAT_CODE,exportCode);
			EditorEvents.dispathcer.addEventListener(CodeEvent.CREATE_FILE,exportFile);
			EditorEvents.dispathcer.addEventListener(CodeEvent.IMPORT_FILE,imporTFILE);
			EditorEvents.dispathcer.addEventListener(EditorEvents.GET_SKINATTRIBUTES,getSkinUrl);
			EditorEvents.dispathcer.addEventListener(EditorEvents.GET_COMPONENTSATTRIBUTES,getComponetnesAttributes);
		}
		
		protected function getComponetnesAttributes(event:EditorEvents):void
		{
			xmlModle.componentsAtrributes = event.data[0];
			xmlModle.componentsSkins = event.data[1];
		}
		
		protected function getSkinUrl(event:EditorEvents):void
		{
			xmlModle.skinUrl = event.data;
		}		
		
		protected function exportCode(event:CodeEvent):void
		{
			var importStr:String = "import morn.core.components.";
			//判断是否已经导入了加载管理器，如果导入就不用再次导入，如果还没导入那么就导入
			var importloaderManger:Boolean = false;
			//判断是否已经有获取图片的bitmap了，如果有就申明一个，如果没有那么就不用再次申明
			var loadermangerBitmap:Boolean = false;
			//判断全局变量是否已经导入，里面装载的是一些判断
			var importVariableObject:Object = new Object();
			
			var CodeXML:XML = new XML(creatXMLString(event));
			CodeStr = "";
			CodeStr += "package { " + "\n";
			//导入类的代码段
			var importString:String = "import flash.display.Sprite;" + "\n";
			//类里面全局变量的代码段，即构造函数上面定义的那些变量
			var variableString:String = "";
			//构造函数里面创建组件的代码段
			var componentsString:String = ""; 
			//单例代码段
			var Instance:String = "";
			
			//判断是否创造单例模式
			if(event.data[3]){
				importString += "import flash.errors.IllegalOperationError;\n";
				variableString+="\n public static var _instance:"+event.data[2] +"\n\n";
				Instance +=	"\n/**\n* \n* @return 单例\n*\n */\n	"+
					"public static function getInstance():" + event.data[2]+"{\n"+
					"_instance ||= new "+event.data[2] +"(new SingltonEnforcer)"+"\n" +"return _instance\n}\n\n";
			}
			
			trace(CodeXML.children().length());
			for(var i:int =0; i<CodeXML.children().length();i++) {
				
				//单个组件的属性XML
				var componentXML:XML = CodeXML.children()[i];
				if(importVariableObject[componentXML.name().localName] == null) {
					importString += importStr  + componentXML.name().localName + ";" + "\n";
					importVariableObject[componentXML.name().localName] = true;
				}
				variableString += "public var " + componentXML.@name + ":" +
					componentXML.name().localName + " = " +	"new "  +
					componentXML.name().localName + "()" + ";" +"\n";
				//遍历单个组件的属性
				var attNamesList:XMLList = componentXML.@*;
				for (var j:int = 0; j < attNamesList.length(); j++)
				{ 
					if(attNamesList[j].name() == "text" || attNamesList[j].name() == "name") {
						componentsString += componentXML.@name+ "."+ attNamesList[j].name() + "=" + '"' + attNamesList[j] + '"' + ";" + "\n";
					} else {
						componentsString += componentXML.@name+ "."+ attNamesList[j].name() + "=" + attNamesList[j] + ";" + "\n";
					}
				}
				
				//遍历单个组件的皮肤属性
				var xml:XML = componentXML.children()[0];
				var skinList:XMLList = xml.@*;
				for(var k:int=0; k<skinList.length(); k++) {
					if(!loadermangerBitmap) {
						importString +="import flash.display.Bitmap;\n";
						variableString += "public var bitmap:Bitmap;\n";
						loadermangerBitmap = true;
					}
					if(!importloaderManger) {
						importString +="import qmang2d.loader.LoaderManager;\n";
						importloaderManger = true;
					} 
					componentsString += "bitmap = new Bitmap();\n";
					componentsString += "LoaderManager.getInstance().getBitmap("+'"' + skinList[k] +'"'+ ",bitmap);\n";
					componentsString += componentXML.@name + "."+ skinList[k].name() + "=" + "bitmap;\n";
				}
				componentsString += "this.addChild(" + componentXML.@name + ")" + ";" + "\n\n";
			}
			
			CodeStr += importString;
			CodeStr += "public class " + event.data[2] + " extends Sprite { " + "\n" ;
			CodeStr += variableString;
			if(event.data[3]) {
				CodeStr	+= "public function " + event.data[2] + "(singltonEnforcer:SingltonEnforcer) {" + "\n";
				CodeStr += "if(singltonEnforcer == null) throw new IllegalOperationError("+'"'+"真各应，要用getInstance方法获取单例"+'"'+");\n";
				CodeStr += "else {\n"
			} else {
				CodeStr	+= "public function " + event.data[2] + "() {" + "\n";
			}
			CodeStr += componentsString;
			if(event.data[3]) {
				CodeStr += "}\n";
			}
			CodeStr += "}\n" ;
			CodeStr += Instance;
			CodeStr += "}" + "\n" + "}";
			if(event.data[3]) {
				CodeStr += "\ninternal class SingltonEnforcer{}";
			}
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CREATE_CODE_COMPLETE,CodeStr));
		}
		
		
		/**
		 * 生成自定义文件
		 * @param e
		 * 
		 */		
		public function exportFile(e:CodeEvent):void
		{
			//创建各种自定义文件里面具有的各种变量
			var byteArray:ByteArray = new ByteArray();
			var xmlLength:uint;
			var objectLength:uint;
			var pictureLength:uint;
			var pictureByte:ByteArray = new ByteArray();
			var skinObject:Object = new Object();
			var XMLString:String = creatXMLString(e);
			
			//开始简析xml文件，生成自定义文件
			var urlarr:Array = new Array();
			var arr:Array = new Array();
			var index:uint = 0;
			var loaderNumber:int;
			var currentLoaderNumber:int;
			var fileXML:XML = new XML(XMLString);
			for(var i:int=0; i<fileXML.children().length(); i++) {
				var skinXML:XML = fileXML.children()[i].children()[0];
				var skinList:XMLList = skinXML.@*;
				for(var j:int=0; j<skinList.length(); j++){
					var loader:URLLoader = new URLLoader();
					loader.dataFormat = URLLoaderDataFormat.BINARY;
					urlarr.push(skinList[j]);
					loader.load(new URLRequest(skinList[j]));
					loaderNumber++;
					loader.addEventListener(Event.COMPLETE,loaderComplete);
					
					function loaderComplete(e:Event):void {
						var byte:ByteArray = e.target.data as ByteArray;
						pictureByte.writeBytes(byte);
						var array:Array = new Array();
						array.push(index,byte.length);
						index+=byte.length;
						arr.push(array);
						currentLoaderNumber++;
					}
				}
			}
			
			//监听图片是否已经全部加在完成
			var sprite:Sprite = new Sprite();
			sprite.addEventListener(Event.ENTER_FRAME,onEnterframe);
			
			function onEnterframe(e:Event):void {
				if(loaderNumber == currentLoaderNumber) {
					sprite.removeEventListener(Event.ENTER_FRAME,onEnterframe);
					for(var k:int=0; k<urlarr.length; k++) {
						skinObject[urlarr[k]] = arr[k];
					}
					byteArray.position = 12;
					byteArray.writeUTFBytes(XMLString);
					xmlLength = byteArray.length - 12;
					trace(xmlLength);
					//					byteArray.position = byteArray.length;
					byteArray.writeObject(skinObject);
					objectLength = byteArray.length - 12 - xmlLength;
					trace(objectLength);
					//					byteArray.position = byteArray.length;
					byteArray.writeBytes(pictureByte);
					pictureLength = byteArray.length - 12 - objectLength - xmlLength;
					trace(pictureLength);
					byteArray.position = 8;
					byteArray.writeInt(pictureLength);
					byteArray.position = 4;
					byteArray.writeInt(objectLength);
					byteArray.position = 0;
					byteArray.writeInt(xmlLength);
					
				}
				//自定义文件完成，派发事件
				EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CREATE_FILE_COMPLETE,[byteArray,XMLString]));
			}
		}
		
		
		/**
		 *导入自定义文件 
		 * @param e
		 * 
		 */
		public function imporTFILE(e:CodeEvent):void
		{
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CLEAR_STAGE));
			
			
			//在file文件中读取各种数据
			importFileByteArray = e.data;
			var xmlLength:int = importFileByteArray.readInt();
			trace(xmlLength);
			//			importFileByteArray.position = 4;
			var objectLength:int = importFileByteArray.readInt();
			trace(objectLength);
			//			importFileByteArray.position = 8;
			var pictureLength:int = importFileByteArray.readInt();
			trace(pictureLength);
			
			var xmlString:String = importFileByteArray.readUTFBytes(xmlLength);
			var importXML:XML = new XML(xmlString);
			var skinObject:Object = importFileByteArray.readObject();
			
			trace(skinObject.toString());
			for (var ar:String in skinObject) {
				trace(ar,skinObject[ar][0],skinObject[ar][1]);
			}
			var pictureArray:ByteArray = new ByteArray();
			importFileByteArray.readBytes(pictureArray,0,pictureLength);
			
			//解析xml文件
			for(var i:int=0; i<importXML.children().length(); i++){
				var componentXML:XML = importXML.children()[i];
				var ui:Sprite = UIFactory.createUI(componentXML.name().localName);
				//派发事件给stagecontrol，创建一个新组件
				EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CREAT_UI,ui));
				//简析组件的属性
				var attNamesList:XMLList = componentXML.@*;
				for (var j:int = 0; j < attNamesList.length(); j++)
				{
					var str:String = attNamesList[j].name();
					ui[str] = attNamesList[j];
				}
				
				trace(importXML.toString());
				var skinList:XMLList = componentXML.children()[0].@*;
				for(var k:int=0; k<skinList.length(); k++) {
					var byte:ByteArray = new ByteArray();
					trace(skinList[k]);
					var array:Array = skinObject[skinList[k]];
					trace(array[0],array[1]);
					pictureArray.position = array[0];
					pictureArray.readBytes(byte,0,array[1]);
					trace(skinList[k].name(),ui,skinList[k]);
					skinLoader(byte,skinList[k].name(),ui,skinList[k]);
				}
			}
		}
		
		private function skinLoader(byte:ByteArray,skin:String,ui:Sprite,url:String):void {
			var _loader :Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onHadlePic);
			_loader.loadBytes(byte);
			
			var _urlStr :String= File.applicationDirectory.nativePath;
			_urlStr = _urlStr.replace(/\\/g, "/");
			var path :String = _urlStr+url;
			var fileStream1 :FileStream = new FileStream();
			fileStream1.open( new File(path),FileMode.WRITE);
			fileStream1.writeBytes(byte);
			fileStream1.close();
			
			function onHadlePic(event:Event):void {
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onHadlePic);
				var bitmap :Bitmap = event.target.content as Bitmap;
				//改变在编辑器中的UI组件样式
				trace(skin);
				ui[skin] = bitmap;
				//复制bitmap，在编辑器的编辑框中显示组件样式
				var bitmapdata:BitmapData = new BitmapData(bitmap.width,bitmap.height);
				bitmapdata.draw(bitmap);
				var copybitmap:Bitmap = new Bitmap(bitmapdata);
				copybitmap.x = copybitmap.y = 1;
				copybitmap.width = copybitmap.height = 98;
				ProjectEvents.dispatcher.dispatchEvent(new ProjectEvents(ProjectEvents.UPDATA_PROJECT,[bitmap,url]));
				SettingEvents.dispatcher.dispatchEvent(new SettingEvents(SettingEvents.UPDATE_SKINS,[ui,skin,copybitmap,url]));
			}
		}
		
		/**
		 *创建xml文件 
		 * @param e
		 * @return 
		 * 
		 */
		private function creatXMLString(e:CodeEvent):String {
			XMLStr = "";
			xmlModle.IDIndex = e.data[0];
			xmlModle.IDUIObejct = e.data[1];
			
			XMLStr += "<UIEditor>\n";
			for each (var id:* in xmlModle.IDIndex){
				var skinString:String = "";
				
				XMLStr += "<"+getQualifiedClassName(xmlModle.IDUIObejct[id]).split("::")[1] + " ";
				
				skinString += "\n<skin ";
				for(var skin:String in xmlModle.skinUrl[id]) {
					
					skinString += skin + "=" +'"' + xmlModle.skinUrl[id][skin] + '" ' ;
				}
				skinString += ">\n</skin>\n";
				for each(var attributes:Array in xmlModle.componentsAtrributes[getQualifiedClassName(xmlModle.IDUIObejct[id])]) {
					XMLStr += attributes[0] + "=" +'"' + xmlModle.IDUIObejct[id][attributes[0]] + '"';
				}
				XMLStr += ">";
				XMLStr += skinString;
				XMLStr += "</"+getQualifiedClassName(xmlModle.IDUIObejct[id]).split("::")[1]+">\n";
			}
			XMLStr += "</UIEditor>"
			return XMLStr;
		}
	}
}