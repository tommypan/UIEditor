package src.controls
{
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.utils.Dictionary;
	
	import mx.containers.Canvas;
	
	import src.containers.StagePanel;
	import src.events.ComponentEvent;
	import src.events.EditorEvents;
	import src.events.KeyEvent;
	import src.managers.UIFactory;
	import src.models.StageModel;
	import src.events.MenuEvents;
	
	/**
	 * 主舞台控制器 
	 * @author yurs 
	 * 
	 */	
	public class StageControls
	{
		private var stagePanel:StagePanel;
		
		private var stageModel:StageModel;
		
		
		
		private var contextmenu:ContextMenu = new ContextMenu();
		private var removeConText:NativeMenuItem = new NativeMenuItem("移除");
		private var topContext:NativeMenuItem = new NativeMenuItem("置于顶层");
		private var upContext:NativeMenuItem = new NativeMenuItem("置于上一层");
		private var downContext:NativeMenuItem = new NativeMenuItem("置于下一层");
		private var minimumContext:NativeMenuItem = new NativeMenuItem("置于底层");
		/**
		 *当前创建UI组件的id，新创建一个UI组件后，id会自动+1； 
		 */
		private var creatUIID:int = 0;
		
		/**
		 *当前操作UI的id； 
		 */
		private var currentID:int;
		
		/**
		 * 当前从组件栏选中的组件 
		 */		
		private var tempFrame:Canvas;
		
		/**
		 *当前正在创建的UI 
		 */
		private var currentCreatUI:Sprite;
		
		/**
		 *黄色滤镜 
		 */
		private var glowfilters:GlowFilter = new GlowFilter(0xff0000);
		
		public function StageControls(_stagePanel:StagePanel,_stageModel:StageModel)
		{
			stagePanel = _stagePanel;
			stageModel = _stageModel;
			
			//初始化上下文菜单
			contextmenu.addItem(removeConText);
			contextmenu.addItem(topContext);
			contextmenu.addItem(upContext);
			contextmenu.addItem(downContext);
			contextmenu.addItem(minimumContext);
			
			addEvent();
		}
		
		/**
		 * 添加侦听 
		 * 
		 */		
		private function addEvent():void
		{
			//为上下文菜单添加监听
			removeConText.addEventListener(Event.SELECT,selectItem);
			topContext.addEventListener(Event.SELECT,selectItem);
			upContext.addEventListener(Event.SELECT,selectItem);
			downContext.addEventListener(Event.SELECT,selectItem);
			minimumContext.addEventListener(Event.SELECT,selectItem);
			
			//添加其它的监听
			EditorEvents.dispathcer.addEventListener(ComponentEvent.DOWN_UI,downUI);
			stagePanel.stage.addEventListener(MouseEvent.MOUSE_UP,tempFrameUp);
			EditorEvents.dispathcer.addEventListener(KeyEvent.CANCEL_UI,keyEscCancelUI);
			EditorEvents.dispathcer.addEventListener(EditorEvents.REMOVE_UI,function(e:EditorEvents):void{removeUI(e.data)});
			EditorEvents.dispathcer.addEventListener(EditorEvents.CREAT_UI,creatUIforImport);
			EditorEvents.dispathcer.addEventListener(EditorEvents.CLEAR_STAGE,clearStage);
		}
		
		/**
		 *当点击上下文菜单的时候触发该函数 
		 * @param event
		 * 
		 */
		protected function selectItem(event:Event):void
		{
			if(stageModel.IDUIObject[currentID] != null){
				switch(event.target){
					case removeConText:
						EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.REMOVE_UI,stageModel.IDUIObject[currentID]));
						break;
					case topContext:
						changeUILevel(stageModel.IDUIObject[currentID],"top");
						break;
					case upContext:
						changeUILevel(stageModel.IDUIObject[currentID],"up");
						break;
					case downContext:
						changeUILevel(stageModel.IDUIObject[currentID],"down");
						break;
					case minimumContext:
						changeUILevel(stageModel.IDUIObject[currentID],"minimum");
						break;
				}
			}
		}
		
		protected function creatUIforImport(event:EditorEvents):void
		{
			creatUI(event.data);
		}		
		
		/**
		 * 点击拖动组件 
		 * @param ary
		 * 
		 */
		private function downUI(e:ComponentEvent):void
		{
			var name:String = e.data.label;
			currentCreatUI = UIFactory.createUI(name);
			
			tempFrame = new Canvas();
			tempFrame.name = currentCreatUI.name;
			tempFrame.graphics.beginFill(0x41415D);
			tempFrame.graphics.lineStyle(5,0x412E56);
			tempFrame.graphics.drawRect(0,0,currentCreatUI.width,currentCreatUI.height);
			tempFrame.graphics.endFill();
			stagePanel.parent.addChild(tempFrame);
			tempFrame.alpha = 0.5;
			var point:Point = e.data.parent.localToGlobal(new Point(e.data.x,e.data.y));
			tempFrame.x = point.x;
			tempFrame.y = point.y;
			tempFrame.startDrag();
			tempFrame.mouseEnabled = false;
		}
		//		
		//		private function clone(source:Object):*
		//		{
		//			var myBA:ByteArray = new ByteArray();
		//			myBA.writeObject(source);
		//			myBA.position = 0;
		//			return(myBA.readObject());
		//		}
		
		
		
		/**
		 * 鼠标抬起 
		 * @param e
		 * 
		 */	
		private function tempFrameUp(e:MouseEvent):void
		{
			if(!tempFrame)return;
			tempFrame.stopDrag();
			stagePanel.parent.removeChild(tempFrame);
			var point:Point = stagePanel.uiLayer.globalToLocal(new Point(tempFrame.x,tempFrame.y));
			tempFrame = null;
			currentCreatUI.x = point.x;
			currentCreatUI.y = point.y;
			if(currentCreatUI.x >0 && currentCreatUI.x < stagePanel.uiLayer.mask.width && 
				currentCreatUI.y > 0 && currentCreatUI.y < stagePanel.uiLayer.mask.height) {
				creatUI(currentCreatUI);
			}
		}
		
		/**
		 * 点击某个组件 
		 */		
		private function downCurUI(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			if(stageModel.IDUIObject[currentID]){
				stageModel.IDUIObject[currentID].filters = [];
				stageModel.IDUIObject[currentID].contextMenu = null;
			}
			currentID = stageModel.UIIDDictionary[e.currentTarget];
			e.currentTarget.startDrag();
			e.currentTarget.addEventListener(MouseEvent.MOUSE_UP,upCurUI);				
			stagePanel.parent.addEventListener(Event.ENTER_FRAME,mouseMove);
			e.currentTarget.contextMenu = contextmenu;
			e.currentTarget.filters = [glowfilters];
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.EDITUI,e.currentTarget));
		}
		
		/**
		 * 按esc取消组件 
		 * @param e
		 * 
		 */		
		private function keyEscCancelUI(e:KeyEvent):void
		{
			if(currentID)stageModel.IDUIObject[currentID].filters = [];
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.CANCEL_CHOICE,currentID));
		}
		
		/**
		 * 从某个组件抬起  
		 * @param e
		 * 
		 */
		private function upCurUI(e:MouseEvent = null):void
		{
			e.stopPropagation();
			e.currentTarget.stopDrag();
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP,upCurUI);		
			stagePanel.parent.removeEventListener(Event.ENTER_FRAME,mouseMove);
		}
		
		/**
		 * 鼠标移动时时更新 
		 * @param e
		 * 
		 */		
		private function mouseMove(e:Event):void
		{
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_SETTING,stageModel.IDUIObject[currentID]));
		}
		
		/**
		 * 创建组件 
		 * @param e
		 * 
		 */		
		private function creatUI(ui:Sprite):void
		{
			stagePanel.uiLayer.addChild(ui);
			stageModel.IDindex[creatUIID] = creatUIID;
			stageModel.IDUIObject[creatUIID] = ui;
			stageModel.UIIDDictionary[ui] = creatUIID;
			creatUIID ++;
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UI,ui));
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
			MenuEvents.dispatcher.dispatchEvent(new MenuEvents(MenuEvents.IDINDEX_UPDATA,[stageModel.IDindex,stageModel.IDUIObject]));
			ui.addEventListener(MouseEvent.MOUSE_DOWN,downCurUI);
		}
		
		/**
		 * 移除UI 
		 */		
		private function removeUI(ui:Sprite):void
		{
			ui.parent.removeChild(ui);
			var currid:int = stageModel.UIIDDictionary[ui];
			delete stageModel.IDUIObject[currid];
			delete stageModel.UIIDDictionary[ui];
			
			for(var id:* in stageModel.IDindex) {
				delete stageModel.IDindex[id];
			}
			stageModel.IDindex = new Dictionary();
			for(var index:int=0; index<stagePanel.uiLayer.numChildren;index++) {
				stageModel.IDindex[index] = stageModel.UIIDDictionary[stagePanel.uiLayer.getChildAt(index)];
			}
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
			MenuEvents.dispatcher.dispatchEvent(new MenuEvents(MenuEvents.IDINDEX_UPDATA,[stageModel.IDindex,stageModel.IDUIObject]));
		
				
				//			//清空diui与uiid属性，
			//			for(var id:* in stageModel.IDUIObject) {
			//				delete stageModel.UIIDDictionary[stageModel.IDUIObject[id]];
			//				delete stageModel.IDUIObject[id];
			//			}
			//			//再次对idui与uiid赋值
			//			for(var index:int =0; index<stagePanel.uiLayer.numChildren; index++) {
			//				stageModel.IDUIObject[index] = stagePanel.uiLayer.getChildAt(index);
			//				stageModel.UIIDDictionary[stageModel.IDUIObject[index]] = index;
			//			}
			
			
			//该处理方法有待考究，暂时不使用
			//			var currid:int = stageModel.UIIDDictionary[ui];
			//			delete stageModel.IDUIObject[currid];
			//			delete stageModel.UIIDDictionary[ui];
			//			for(var id:* in stageModel.IDUIObject) {
			//				if(id>currid) {
			//					stageModel.IDUIObject[currid] = stageModel.IDUIObject[id];
			//					delete stageModel[id];
			//					currid = id;
			//				}
			//			}
		}
		
		/**
		 *改变显示对象的深度 
		 * @param ui
		 * @param type
		 * 
		 */
		private function changeUILevel(ui:Sprite,type:String):void
		{
			var currentIndex:int = ui.parent.getChildIndex(ui);
			var maxIndex:int = ui.parent.numChildren-1;
			switch(type){
				case "top":
					if(currentIndex != maxIndex) {
						ui.parent.setChildIndex(ui,ui.parent.numChildren-1);
						currentID = maxIndex;
						updataIDindex();
						
						/*for(var j:int=currentIndex; j<maxIndex-currentIndex+1;j++){
						stageModel.IDUIObject[j]=ui.parent.getChildAt(j);
						stageModel.UIIDDictionary[ui.parent.getChildAt(j)] = j;
						}
						EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
						*/
						break;
					}
				case "up":
					if(currentIndex != maxIndex) {
						ui.parent.swapChildrenAt(currentIndex+1,currentIndex);
						currentID = currentIndex +1;
						updataIDindex();
						
						/*stageModel.IDUIObject[currentIndex] = ui.parent.getChildAt(currentIndex);
						stageModel.UIIDDictionary[ui] = currentIndex+1;
						stageModel.IDUIObject[currentIndex+1] = ui;
						stageModel.UIIDDictionary[stageModel.IDUIObject[currentIndex]] = currentIndex;
						EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
						*/
						break;
					}
				case "down":
					if(currentIndex != 0) {
						ui.parent.swapChildrenAt(currentIndex-1,currentIndex);
						currentID = currentIndex -1;
						updataIDindex();
						
						/*stageModel.IDUIObject[currentIndex] = ui.parent.getChildAt(currentIndex);
						stageModel.UIIDDictionary[ui] = currentIndex-1;
						stageModel.IDUIObject[currentIndex-1] = ui;
						stageModel.UIIDDictionary[stageModel.IDUIObject[currentIndex]] = currentIndex;
						EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
						*/
						break;
					}
				case "minimum":
					if(currentIndex != 0) {
						ui.parent.setChildIndex(ui,0);
						currentID = 0;
						updataIDindex();
						
						/*				for(var i:int=0; i<currentIndex+1;i++){
						stageModel.IDUIObject[i]=ui.parent.getChildAt(i);
						stageModel.UIIDDictionary[ui.parent.getChildAt(i)] = i;
						}
						EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
						*/
						break;
					}
					
			}
		}
		
		private function updataIDindex():void {
			for(var id:* in stageModel.IDindex) {
				delete stageModel.IDindex[id];
			}
			stageModel.IDindex = new Dictionary();
			for(var index:int=0; index<stagePanel.uiLayer.numChildren;index++) {
				stageModel.IDindex[index] = stageModel.UIIDDictionary[stagePanel.uiLayer.getChildAt(index)];
			}
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_UIID,[stageModel.IDUIObject,stageModel.UIIDDictionary]));
			MenuEvents.dispatcher.dispatchEvent(new MenuEvents(MenuEvents.IDINDEX_UPDATA,[stageModel.IDindex,stageModel.IDUIObject]));
		}
		/**
		 * 清空舞台
		 * @param event
		 * 
		 */
		protected function clearStage(event:EditorEvents):void
		{
			creatUIID = 0;
			for(var id:* in stageModel.IDUIObject) {
				stagePanel.uiLayer.removeChild(stageModel.IDUIObject[id]);
				delete stageModel.IDUIObject[id];
			}
			stageModel.IDUIObject = new Dictionary();
			for(var index:* in stageModel.UIIDDictionary) {
				delete stageModel.UIIDDictionary[index];
			}
			stageModel.UIIDDictionary = new Dictionary();
			for(var idindex:* in stageModel.IDindex) {
				delete stageModel.IDindex[idindex];
			}
			stageModel.IDindex = new Dictionary();
		}
	}
}