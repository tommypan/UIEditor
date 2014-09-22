package src.controls
{
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	import src.events.EditorEvents;
	import src.events.KeyEvent;
	import src.utils.KeyStateUtil;

	/**
	 * 键盘控制器 
	 * @author yurs
	 * 
	 */	
	public class KeyControl
	{
		private var currentUI:Sprite;
		
		public function KeyControl()
		{
			KeyStateUtil.setReturnFun(keyHandle);
			EditorEvents.dispathcer.addEventListener(EditorEvents.EDITUI,function(e:EditorEvents):void{currentUI = e.data});
		}
		
		/**
		 * 键盘事件处理 
		 * 
		 */		
		private function keyHandle():void
		{
			if(currentUI){
				if(KeyStateUtil.keyIsDown(Keyboard.DELETE))
					EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.REMOVE_UI,currentUI));
				
				if(KeyStateUtil.keyIsDown(Keyboard.UP))moveUI(currentUI.x,currentUI.y-1)
				if(KeyStateUtil.keyIsDown(Keyboard.DOWN))moveUI(currentUI.x,currentUI.y+1)
				if(KeyStateUtil.keyIsDown(Keyboard.LEFT))moveUI(currentUI.x-1,currentUI.y)
				if(KeyStateUtil.keyIsDown(Keyboard.RIGHT))moveUI(currentUI.x+1,currentUI.y)
				
				if(KeyStateUtil.keyIsDown(Keyboard.SHIFT) && KeyStateUtil.keyIsDown(Keyboard.UP))moveUI(currentUI.x,currentUI.y-10)
				if(KeyStateUtil.keyIsDown(Keyboard.SHIFT) && KeyStateUtil.keyIsDown(Keyboard.DOWN))moveUI(currentUI.x,currentUI.y+10)
				if(KeyStateUtil.keyIsDown(Keyboard.SHIFT) && KeyStateUtil.keyIsDown(Keyboard.LEFT))moveUI(currentUI.x-10,currentUI.y)
				if(KeyStateUtil.keyIsDown(Keyboard.SHIFT) && KeyStateUtil.keyIsDown(Keyboard.RIGHT))moveUI(currentUI.x+10,currentUI.y)
					
				if(KeyStateUtil.keyIsDown(Keyboard.ALTERNATE) && KeyStateUtil.keyIsDown(Keyboard.UP))
					modifyChildIndex(currentUI.parent.getChildIndex(currentUI)+1);
				if(KeyStateUtil.keyIsDown(Keyboard.ALTERNATE) && KeyStateUtil.keyIsDown(Keyboard.DOWN))
					modifyChildIndex(currentUI.parent.getChildIndex(currentUI)-1);
			}
			
			if(KeyStateUtil.keyIsDown(Keyboard.CONTROL) && KeyStateUtil.keyIsDown(Keyboard.S))
				EditorEvents.dispathcer.dispatchEvent(new KeyEvent(KeyEvent.SAVE_CODE,"export"));
			
			if(KeyStateUtil.keyIsDown(Keyboard.CONTROL) && KeyStateUtil.keyIsDown(Keyboard.Z))
				EditorEvents.dispathcer.dispatchEvent(new KeyEvent(KeyEvent.REVOKE));
			
			if(KeyStateUtil.keyIsDown(Keyboard.CONTROL) && KeyStateUtil.keyIsDown(Keyboard.Y))
				EditorEvents.dispathcer.dispatchEvent(new KeyEvent(KeyEvent.REDO));
			
			if(KeyStateUtil.keyIsDown(Keyboard.ESCAPE))
				EditorEvents.dispathcer.dispatchEvent(new KeyEvent(KeyEvent.CANCEL_UI,currentUI));currentUI = null;
		}
		
		/**
		 * 更改ui的子级深度关系
		 */		
		private function modifyChildIndex(index:int):void
		{
			if(currentUI == null) return;
			if(currentUI.parent == null) return;
			if(index<0 || index>currentUI.parent.numChildren-1) return;
			currentUI.parent.setChildIndex(currentUI,index);
		}
		
		/**
		 * 移动UI 
		 */		
		private function moveUI(x:int,y:int):void
		{
			currentUI.x = x;
			currentUI.y = y;
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_SETTING,currentUI));
		}
		
		/**
		 * 缩放UI 
		 */		
		private function scaleUI(width:int,height:int):void
		{
			currentUI.width = width;
			currentUI.height = height;
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_SETTING,currentUI));	
		}
	}
}