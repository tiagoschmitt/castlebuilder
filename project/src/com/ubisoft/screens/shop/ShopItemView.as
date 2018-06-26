package com.ubisoft.screens.shop 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.factories.ImageFactory;
	import com.ubisoft.factories.ShopFactory;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class ShopItemView extends DisplayComponent
	{
		private var _model:ShopModel;
		
		public function ShopItemView(model:ShopModel) 
		{
			_model = model;
			
			var content:Sprite = new Sprite();
			
			var background:Image = createBackground();
			content.addChild(background);
			
			var itemImage:Image = ShopFactory.getInstance().getImage(_model.name);
			itemImage.width = content.width - 20;
			itemImage.scaleY = content.scaleX;
			itemImage.x = 10;
			itemImage.y = 20;
			content.addChild(itemImage);
			
			var nameTextField:TextField = new TextField(content.width - 5, 20, _model.name);
			nameTextField.x = 5;
			nameTextField.y = 5;
			content.addChild(nameTextField);
			
			var coin:Image = ImageFactory.getImage(ImageFactory.COIN);
			coin.x = 10;
			coin.y = content.height - coin.height - 5;
			content.addChild(coin);
			
			var priceTextField:TextField = new TextField(content.width, 20, _model.price.toString());
			priceTextField.y = background.height - priceTextField.height - 15;
			content.addChild(priceTextField);
			
			super(content);
		}
		
		private function createBackground():Image 
		{
			var width:int = Starling.current.stage.stageWidth / 6;
			var height:int = 190;
			
			var background:Shape = new Shape();
			background.graphics.lineStyle(0x000000, 1);
			background.graphics.beginFill(0xFFFFFF, 1);
			background.graphics.drawRect(0, 0, width, height);
			background.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(background.width + 1, background.height + 1);
			bmd.draw(background);
			
			return new Image(Texture.fromBitmapData(bmd));
		}
		
		public function get model():ShopModel 
		{
			return _model;
		}
	}
}