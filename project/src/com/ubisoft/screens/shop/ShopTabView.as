package com.ubisoft.screens.shop 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.components.display.DisplayComponent;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class ShopTabView extends DisplayComponent
	{
		private var _selected:Boolean;
		private var _selectedBG:Image;
		private var _unselectedBG:Image;
		
		public function ShopTabView(text:String, selected:Boolean) 
		{
			_selectedBG = createBG(0xFFFFFF);
			_unselectedBG = createBG(0xCCCCCC);
			
			var content:Sprite = new Sprite();
			content.addChild(_selectedBG);
			content.addChild(_unselectedBG);
			
			var textField:TextField = new TextField(content.width, 17, text);
			textField.y = 2;
			content.addChild(textField);
			
			this.selected = selected;
			
			super(content)
		}
		
		private function createBG(color:int):Image
		{
			var background:Shape = new Shape();
			background.graphics.beginFill(color, 1);
			background.graphics.drawRect(0, 0, 100, 25);
			background.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(background.width + 1, background.height + 1);
			bmd.draw(background);
			
			return new Image(Texture.fromBitmapData(bmd));
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			
			if (_selected)
			{
				_selectedBG.visible = true;
				_unselectedBG.visible = false;
			}
			else
			{
				_selectedBG.visible = false;
				_unselectedBG.visible = true;
			}
		}
		
	}

}