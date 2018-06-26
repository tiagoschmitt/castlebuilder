package com.ubisoft.components.world {
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.components.display.IDisplayable;
	import com.ubisoft.components.render.IRenderable;
	import com.ubisoft.components.render.RenderComponent;
	import com.ubisoft.components.world.ITileable;
	import com.ubisoft.utils.IObserver;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * >author		Tiago Schmitt
	 */

	public class World extends EventDispatcher implements IObserver, IRenderable
	{
		protected var _tileSize:Rectangle;
		protected var _canvas:Sprite;
		protected var _mapSize:Rectangle;
		
		protected var _render:RenderComponent;
		
		protected var _tiles:Vector.<Tile>;
		protected var _mapChanged:Boolean = false;
		
		protected var _objectList:Vector.<IDisplayable>;
		
		protected var _showFloor:Boolean = true;
		
		public function World(tileSize:Rectangle, mapSize:Rectangle, canvas:Sprite)
		{
			_tileSize = tileSize;
			_mapSize = mapSize;
			_canvas = canvas;
			
			createTiles();
			createObjectList();
			createRender();
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.T)
			{
				showFloor = !showFloor;
			}
		}
		
		public function add(object:ITileable):void
		{
			_mapChanged = true;
			
			var index:int = object.display.y * _mapSize.width + object.display.x;
			
			if (index <= _tiles.length -1)
			{
				var tile:Tile = _tiles[index];
				
				if (!tile.isBusy())
				{
					tile.object = object;
					return;
				}
			}
		}
		
		public function remove(element:ITileable, tile:Tile):void
		{
			_mapChanged = true;
			
			var length:int = _tiles.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (_tiles[i].object == element)
				{
					_tiles[i].clear();
					return;
				}
			}
		}
		
		public function update():void 
		{
			if (_mapChanged)
			{
				createObjectList();
				
				_mapChanged = false;
			}
			
			_render.update();
		}
		
		public function clearTiles():void
		{
			var length:int = _tiles.length;
			
			for (var i:int = 0; i < length; i++)
				_tiles[i].clear();
		}
		
		public function getCanvas():Sprite 
		{
			return _canvas;
		}
		
		public function getObjects():Vector.<IDisplayable> 
		{
			return _objectList;
		}
		
		public function getFreePositionNextTo(x:Number, y:Number):Point 
		{
			var freeTiles:Vector.<Tile> = new Vector.<Tile>();
			var length:int = _tiles.length;
			var i:int = 0;
			
			for (i = 0; i < length; i++)
			{
				if (!_tiles[i].isBusy())
				{
					freeTiles.push(_tiles[i]);
				}
				else
				{
					
				}
			}
			
			length = freeTiles.length;
			
			var minorDistance:int;
			var distance:int;
			var targetPoint:Point = new Point(x, y);
			var temp:Point;
			var resultPoint:Point;
			
			for (i = 0; i < length; i++)
			{
				temp = new Point(freeTiles[i].x, freeTiles[i].y);
				
				distance = Point.distance(targetPoint, temp);
				
				if (distance < minorDistance || minorDistance == 0)
				{
					minorDistance = distance;
					resultPoint = temp.clone();
				}
			}
			
			return resultPoint;
		}
		
		protected function createTiles():void
		{
			var width:int = _mapSize.width;
			var height:int = _mapSize.height;
			
			_tiles = new Vector.<Tile>();
			
			for (var i:int = 0; i < height; i++)
				for (var j:int = 0; j < width; j++)
					_tiles.push(new Tile(j, i, _tileSize));
		}
		
		protected function createObjectList():void
		{
			_objectList = new Vector.<IDisplayable>();
			
			var length:int = _tiles.length;
			var i:int = 0;
			
			for (i = 0; i < length; i++) {
				if (_showFloor) {
					_objectList.push(_tiles[i].floor);
				}
			}
			
			for (i = 0; i < length; i++) {
				if (_tiles[i].object != null) {
					_objectList.push(_tiles[i].object.display);
				}
			}
		}
		
		protected function createRender():void
		{
			_render = new RenderComponent(this);
		}
		
		public function get showFloor():Boolean 
		{
			return _showFloor;
		}
		
		public function set showFloor(value:Boolean):void 
		{
			_mapChanged = true;
			_showFloor = value;
		}
	}
}