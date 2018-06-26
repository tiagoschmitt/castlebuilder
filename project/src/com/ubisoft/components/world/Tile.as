

package com.ubisoft.components.world {
	/**
	 * ...
	 * >author		Tiago Schmitt
	 */
	import com.ubisoft.components.display.IDisplayable;
	import com.ubisoft.components.display.IsometricDisplayComponent;
	import com.ubisoft.components.world.ITileable;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Tile 
	{
		private var _tileSize:Rectangle;
		private var _x:int;
		private var _y:int;
		private var _floor:IDisplayable;
		
		
		private var _object:ITileable;
		
		public function Tile (x:int, y:int, tileSize:Rectangle)
		{
			_x = x;
			_y = y;
			_tileSize = tileSize;
			
			createFloor();
		}
		
		private function createFloor():void 
		{
			var bg:flash.display.Sprite = new flash.display.Sprite();
			bg.graphics.beginFill(0xFFFFFF, 0);
			bg.graphics.lineStyle(1, 0x000000);
			bg.graphics.moveTo(0, _tileSize.height / 2); 
			bg.graphics.lineTo(_tileSize.width / 2 , 0); 
			bg.graphics.lineTo(_tileSize.width , _tileSize.height / 2); 
			bg.graphics.lineTo(_tileSize.width / 2 , _tileSize.height); 
			bg.graphics.lineTo(0, _tileSize.height / 2); 
			bg.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(bg.width, bg.height, true, 0xFFFFFF);
			bmd.draw(bg);
			
			var image:Image = new Image(Texture.fromBitmapData(bmd));
			
			var content:Sprite = new Sprite();
			content.addChild(image);
			
			_floor = new IsometricDisplayComponent(content);
			_floor.position(_x, _y);
		}
		
		public function clear():void
		{
			_object = null;
		}
		
		public function isBusy():Boolean
		{
			return _object != null;
		}
		
		public function get object():ITileable 
		{
			return _object;
		}
		
		public function get x():int
		{ 
			return _x; 
		}
		
		public function get y():int
		{
			return _y;
		}
		
		public function set object(value:ITileable):void 
		{
			_object = value;
		}
		
		public function get floor():IDisplayable 
		{
			return _floor;
		}
		
		public function toString():String
		{
			return x + " - " + y;
		}
	}
}

