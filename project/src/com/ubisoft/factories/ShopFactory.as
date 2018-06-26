package com.ubisoft.factories {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.screens.shop.ShopModel;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class ShopFactory extends EventDispatcher
	{
		private static var _instance:ShopFactory;
		
		private var _models:Vector.<Object>;
		private var _activeIndex:int = -1;
		
		private var _images:Dictionary;
		
		public function ShopFactory(singleton:SingletonObligate)
		{
		}
		
		public static function getInstance():ShopFactory
		{
			if (!ShopFactory._instance)
				ShopFactory._instance = new ShopFactory(new SingletonObligate());
			
			return ShopFactory(ShopFactory._instance);
		}
		
		public function init(models:Vector.<Object>):void
		{
			_models = models;
			_images = new Dictionary();
			
			loadNext();
		}
		
		public function getImage(name:String):Image
		{
			return new Image(Texture.fromTexture((_images[name] as Image).texture));;
		}
		
		private function loadNext():void
		{
			if (_activeIndex < _models.length -1)
			{
				_activeIndex++;
				
				var model:ShopModel = _models[_activeIndex] as ShopModel;
				loadImage(model.src, model.name);
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function loadImage(src:String, name:String):void
		{
			ImageFactory.loadImage(src, function(image:Image):void {
				_images[name] = image;
				loadNext();
			});
		}
	}
}

class SingletonObligate {}
