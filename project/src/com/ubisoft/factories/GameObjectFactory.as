package com.ubisoft.factories 
{
	import com.ubisoft.components.display.IsometricDisplayComponent;
	import com.ubisoft.components.world.GameObject;
	import com.ubisoft.utils.MathUtil;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class GameObjectFactory 
	{
		
		public static function createIsometricGameObject(name:String):GameObject
		{
			var image:Image = ShopFactory.getInstance().getImage(name);
			var sprite:Sprite = new Sprite();
			image.y = - image.height + (MathUtil.TILE_HEIGHT);
			
			
			if (name == "Hangar")
				image.y = - image.height + (MathUtil.TILE_HEIGHT / 0.8);
				
			if (name == "Temple")
				image.y = - image.height + (MathUtil.TILE_HEIGHT / 0.9);
			
			sprite.addChild(image);
			
			var component:IsometricDisplayComponent = new IsometricDisplayComponent(sprite);
			return new GameObject(component);
		}
	}

}