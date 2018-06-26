package com.ubisoft.factories {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class ImageFactory 
	{
		public static var CLOSE:String = "close";
		public static var COIN:String = "coin";
		public static var NEXT:String = "next";
		public static var PREVIOUS:String = "previous";
		public static var PROFILE:String = "profile";
		public static var SHOP:String = "shop";
		public static var SMILEY:String = "smiley";
		public static var ZOOMIN:String = "zoomin";
		public static var ZOOMOUT:String = "zoomout";
		
		[Embed(source="/../bin/img/close.png")]
		private static var _close:Class;
		
		[Embed(source="/../bin/img/coin.png")]
		private static var _coin:Class;
		
		[Embed(source="/../bin/img/next.png")]
		private static var _next:Class;
		
		[Embed(source="/../bin/img/previous.png")]
		private static var _previous:Class;
		
		[Embed(source="/../bin/img/profile.png")]
		private static var _profile:Class;
		
		[Embed(source="/../bin/img/shop.png")]
		private static var _shop:Class;
		
		[Embed(source="/../bin/img/Smiley.png")]
		private static var _smiley:Class;
		
		[Embed(source="/../bin/img/zoomin.png")]
		private static var _zoomin:Class;
		
		[Embed(source="/../bin/img/zoomout.png")]
		private static var _zoomout:Class;
		
		public static function getImage(name:String):Image
		{
			var scale:Number = 1;
			var bitmap:Bitmap;
			
			switch (name)
			{
				case CLOSE:
					bitmap = new _close();
					break;
				case COIN:
					bitmap = new _coin();
					scale = 1.5;
					break;
				case NEXT:
					bitmap = new _next();
					break;
				case PREVIOUS:
					bitmap = new _previous();
					break;
				case PROFILE:
					bitmap = new _profile();
					scale = 3;
					break;
				case SHOP:
					bitmap = new _shop();
					scale = 4.5;
					break;
				case SMILEY:
					bitmap = new _smiley();
					break;
				case ZOOMIN:
					bitmap = new _zoomin();
					break;
				case ZOOMOUT:
					bitmap = new _zoomout();
					break;
			}
			
			return new Image(Texture.fromBitmap(bitmap, false, false, scale));
		}
		
		public static function loadImage(src:String, callback:Function):void
		{
			var bytes:ByteArray = new ByteArray();
			var fileStream:FileStream = new FileStream();
			var file:File = File.applicationDirectory.resolvePath(src);
			fileStream.open(file, FileMode.READ);
			
			fileStream.readBytes(bytes);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				var image:Image = new Image(Texture.fromBitmap(Bitmap(loader.content)));
				fileStream.close();
				
				callback(image);
			});
			
			loader.loadBytes(bytes);
		}
	}

}