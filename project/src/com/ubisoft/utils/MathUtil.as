package com.ubisoft.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class MathUtil 
	{
		public static var TILE_WIDTH:int = 128;
		public static var TILE_HEIGHT:int = 64;
		
		
		public static function isometricToScreen(point:Point):Point
		{
			var screen:Point = new Point();
			
			screen.x = (point.y - point.x) * (TILE_WIDTH / 2);
			screen.y = (point.y + point.x) * (TILE_HEIGHT / 2);
			
			return screen;
		}
		
		public static function screenToIsometric(point:Point):Point
		{
			var iso:Point = new Point();
			
			iso.x = (point.x / (TILE_WIDTH / 2) + point.y / (TILE_HEIGHT / 2)) / 2;
			iso.y = (point.y / (TILE_HEIGHT / 2) - (point.x / (TILE_WIDTH / 2))) / 2;
			
			return iso;
		}
		
	}

}