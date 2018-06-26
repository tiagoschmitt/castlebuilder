package com.ubisoft.screens.friends 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.factories.ImageFactory;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class FriendView extends DisplayComponent
	{
		private var _model:FriendModel;
		
		public function FriendView(model:FriendModel) 
		{
			_model = model;
			
			var content:Sprite = new Sprite();
			content.addChild(ImageFactory.getImage(ImageFactory.PROFILE));
			
			var nameTextField:TextField = new TextField(content.width, 17, _model.name);
			nameTextField.y = content.height;
			content.addChild(nameTextField);
			
			var levelTextField:TextField = new TextField(content.width, 17, _model.level);
			levelTextField.y = nameTextField.y + nameTextField.height;
			content.addChild(levelTextField);
			
			super(content);
		}
	}
}