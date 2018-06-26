package com.ubisoft.managers {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class FileManager 
	{
		public static function loadMap():XML
		{
			return load("xml/map.xml");
		}
		
		public static function loadFriends():XML
		{
			return load("xml/friends.xml");
		}
		
		public static function loadShop():XML
		{
			return load("xml/shop.xml");
		}
		
		private static function load(path:String):XML
		{
			var file:File = File.applicationDirectory.resolvePath(path);
			
			if (file.exists)
			{     
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				
				var str:String = stream.readUTFBytes(stream.bytesAvailable);
				
				stream.close();
				
				return new XML(str);
			}
			
			return null;
		}
	}
}