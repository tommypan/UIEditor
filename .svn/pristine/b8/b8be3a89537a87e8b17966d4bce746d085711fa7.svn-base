package src.containers
{
	import mx.containers.VBox;
	import mx.controls.Label;
	
	import spark.components.Button;
	import spark.components.VGroup;

	/**
	 * 项目库，里面包括Ui组件和一些图片
	 * @author tanshiyu
	 * 
	 */
	public class ProjectPanel extends mx.containers.VBox
	{
		//项目库标签
		public var projectLabel:Label = new Label();
		//组件库标签
		public var componetnsLabel:Label = new Label();
		//组件库容器
		public var componentsBox:VBox = new VBox();
		//资源库标签
		public var resLabel:Label = new Label();
		//打开资源，添加资源的按钮
		public var openbutton:Button = new Button();
		//资源库容器
		public var resBox:VBox = new VBox();
		public function ProjectPanel()
		{
			projectLabel.text = "项目库";
			this.addChild(projectLabel);
			componetnsLabel.text = "组件库";
			this.addChild(componetnsLabel);
			this.addChild(componentsBox);
			resLabel.text = "资源库";
			this.addChild(resLabel);
			openbutton.label = "打开";
			this.addChild(openbutton);
			this.addChild(resBox);
		}
	}
}