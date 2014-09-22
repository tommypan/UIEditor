package src.controls
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.getClassByAlias;
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.Canvas;
	import mx.containers.VBox;
	
	import src.EditorConfig;
	import src.MainEditor;
	import src.containers.StagePanel;
	import src.events.EditorEvents;

	/**
	 * 编辑状态控制器 
	 * @author yurs
	 * 
	 */	
	public class TensileControls
	{
		private var editUI:Sprite;
		
		private var leftup:Sprite;
		private var up:Sprite;
		private var rightup:Sprite;
		private var right:Sprite;
		private var rightdown:Sprite;
		private var down:Sprite;
		private var leftdown:Sprite;
		private var left:Sprite;
		
		private var tempSp:Sprite;
		
		private var tempX:Number;
		private var tempY:Number;
		
		private var lastRect:Sprite;
		private var isRecord:Boolean = false;
		
		public function TensileControls()
		{
			leftup = drawRect("leftup");
			up = drawRect("up");
			rightup = drawRect("rightup");
			right = drawRect("right");
			rightdown = drawRect("rightdown");
			down = drawRect("down");
			leftdown = drawRect("leftdown");
			left = drawRect("left");
			tempSp = drawRect("temp");
			
			leftup.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			up.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			rightup.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			right.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			rightdown.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			down.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			leftdown.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			left.addEventListener(MouseEvent.MOUSE_DOWN,editDragDown);
			tempSp.addEventListener(MouseEvent.MOUSE_UP,editDragUp);
			
//			EditorEvents.dispathcer.addEventListener(EditorEvents.EDITUI,editStateUI);
			EditorEvents.dispathcer.addEventListener(EditorEvents.EDIT_STATE,editStateUI);
		}
		
		/**
		 * 点击组件出现8个按钮 
		 * @param e
		 * 
		 */		
		private function editStateUI(e:EditorEvents):void
		{
			editUI = e.data;
			if(!editUI)return;
			if(!MainEditor.isEditState){
				if(!leftup.parent)return;
				leftup.parent.removeChild(leftup);
				up.parent.removeChild(up);
				rightup.parent.removeChild(rightup);
				right.parent.removeChild(right);
				rightdown.parent.removeChild(rightdown);
				down.parent.removeChild(down);
				leftdown.parent.removeChild(leftdown);
				left.parent.removeChild(left);
				tempSp.parent.removeChild(tempSp);
				if(EditorEvents.dispathcer.hasEventListener(EditorEvents.UPDATE_SETTING))
					EditorEvents.dispathcer.removeEventListener(EditorEvents.UPDATE_SETTING,rectPosition);
				return;
			}else{
				editUI.parent.addChild(leftup);
				editUI.parent.addChild(up);
				editUI.parent.addChild(rightup);
				editUI.parent.addChild(right);
				editUI.parent.addChild(rightdown);
				editUI.parent.addChild(down);
				editUI.parent.addChild(leftdown);
				editUI.parent.addChild(left);
				editUI.parent.addChild(tempSp);
				tempSp.mouseEnabled = false;
				tempSp.alpha = 0;
				EditorEvents.dispathcer.addEventListener(EditorEvents.UPDATE_SETTING,rectPosition);
				EditorEvents.dispathcer.addEventListener(EditorEvents.UPDATE_STAGE,rectPosition);
			}
			rectPosition();
		}
		
		/**
		 * 更新按钮位置 
		 * @param e
		 * 
		 */		
		private function rectPosition(e:EditorEvents = null):void
		{
			leftup.x = editUI.x-leftup.width/2;
			leftup.y = editUI.y-leftup.height/2;
			
			up.x = leftup.x+editUI.width/2;
			up.y = leftup.y;
			
			rightup.x = up.x+editUI.width/2;
			rightup.y = leftup.y;
			
			right.x = rightup.x;
			right.y = rightup.y+editUI.height/2;
			
			rightdown.x = rightup.x;
			rightdown.y = right.y+editUI.height/2;
			
			down.x = up.x;
			down.y = up.y+editUI.height;
			
			leftdown.x = leftup.x;
			leftdown.y = leftup.y+editUI.height;
			
			left.x = leftup.x;
			left.y = leftup.y+editUI.height/2;
			
			tempSp.x = editUI.parent.mouseX-tempSp.width/3;
			tempSp.y = editUI.parent.mouseY-tempSp.height/3;
		}
		
		/**
		 * 当有按钮按下 
		 * @param e
		 * 
		 */		
		private function editDragDown(e:MouseEvent):void
		{
			editDragUp();
			lastRect = e.target as Sprite;
			tempSp.mouseEnabled = true;
			e.stopImmediatePropagation();
			switch(e.target.name)
			{
				case "leftup":
					tempX = editUI.x+editUI.width
					tempY = editUI.y+editUI.height;
					e.target.startDrag(false,new Rectangle(0,0,tempX,tempY));
					break;
				case "up":
					tempX = editUI.x+editUI.width/2
					tempY = editUI.y+editUI.height;
					e.target.startDrag(false,new Rectangle(e.target.x,0,0,tempY));
					break;
				case "rightup":
					tempX = editUI.x
					tempY = editUI.y+editUI.height;
					e.target.startDrag(false,new Rectangle(editUI.x,0,EditorConfig.stagePanelWidth-tempX,tempY));
					break;
				case "right":
					tempX = editUI.x
					tempY = editUI.y+editUI.height/2;
					e.target.startDrag(false,new Rectangle(editUI.x,e.target.y,EditorConfig.stagePanelWidth-tempX,0));
					break;
				case "rightdown":
					tempX = editUI.x
					tempY = editUI.y;
					e.target.startDrag(false,new Rectangle(tempX,tempY,EditorConfig.stagePanelWidth-tempX,EditorConfig.stagePanelHeight-tempY));
					break;
				case "down":
					tempX = editUI.x+editUI.width/2
					tempY = editUI.y;
					e.target.startDrag(false,new Rectangle(tempX-e.target.width/2,tempY,0,EditorConfig.stagePanelHeight-tempY));
					break;
				case "leftdown":
					tempX = editUI.x+editUI.width
					tempY = editUI.y;
					e.target.startDrag(false,new Rectangle(0,editUI.y,tempX,EditorConfig.stagePanelHeight-tempY));
					break;
				case "left":
					tempX = editUI.x+editUI.width
					tempY = editUI.y+editUI.height/2;
					e.target.startDrag(false,new Rectangle(0,tempY-e.target.height/2,tempX,0));
					break;
			}
			e.currentTarget.addEventListener(Event.ENTER_FRAME,editDragMove);
			e.currentTarget.addEventListener(MouseEvent.MOUSE_UP,editDragUp);
		}
		
		/**
		 * 按下按钮开始拖动 
		 * @param e
		 * 
		 */		
		private function editDragMove(e:Event):void
		{
			if(!isRecord){
				EditControls.addStartEdit(editUI,{x:editUI.x,y:editUI.y,width:editUI.width,height:editUI.height});
				isRecord = true;
			}
				
			switch(e.target.name)
			{
				case "leftup":
					editUI.x = e.target.x+e.target.width/2;
					editUI.y = e.target.y+e.target.height/2;
					editUI.width = tempX-editUI.x
					editUI.height = tempY-editUI.y
					break;
				case "up":
					editUI.y = e.target.y+e.target.height/2;
					editUI.height = tempY-editUI.y
					break;
				case "rightup":
					editUI.y = e.target.y+e.target.height/2;
					editUI.width = e.target.x+e.target.width/2-tempX
					editUI.height = tempY-e.target.y-e.target.height/2;
					break;
				case "right":
					editUI.x = tempX;
					editUI.width = e.target.x+e.target.width/2-tempX;
					break;
				case "rightdown":
					editUI.width = e.target.x+e.target.width/2-tempX
					editUI.height = e.target.y+e.target.height/2-tempY;
					break;
				case "down":
					editUI.height = e.target.y+e.target.height/2-tempY;
					break;
				case "leftdown":
					editUI.x = e.target.x+e.target.width/2;
					editUI.width = tempX-e.target.x-e.target.width/2;
					editUI.height = e.target.y+e.target.height/2-tempY;
					break;
				case "left":
					editUI.x = e.target.x+e.target.width/2;
					editUI.width = tempX-e.target.x-e.target.width/2;
					break;
			}
			rectPosition();
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_SETTING,editUI));
		}
		
		/**
		 * 从按钮上抬起 
		 * @param e
		 * 
		 */
		private function editDragUp(e:MouseEvent = null):void
		{
			if(!lastRect)return;
			lastRect.removeEventListener(Event.ENTER_FRAME,editDragMove);
			rectPosition();
			lastRect.stopDrag();
			tempSp.mouseEnabled = false;
			isRecord = true;
			EditControls.addEndEdit(editUI,{x:editUI.x,y:editUI.y,width:editUI.width,height:editUI.height});
		}
		
		/**
		 * 绘制按钮 
		 * @param name
		 * @return 
		 * 
		 */
		private function drawRect(name:String):Sprite
		{
			var rect:Sprite = new Sprite();
			rect.name = name;
			rect.graphics.beginFill(0x41415D);
			rect.graphics.lineStyle(5,0x412E56);
			rect.graphics.drawRect(0,0,10,10);
			rect.graphics.endFill();
			return rect
		}
	}
}