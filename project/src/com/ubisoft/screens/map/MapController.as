package com.ubisoft.screens.map 
{
	import com.ubisoft.components.world.GameObject;
	import com.ubisoft.components.world.World;
	import com.ubisoft.events.GameEvent;
	import com.ubisoft.factories.GameObjectFactory;
	import com.ubisoft.screens.shop.ShopModel;
	import com.ubisoft.utils.GameLoop;
	import com.ubisoft.utils.IObserver;
	import com.ubisoft.utils.MathUtil;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class MapController implements IObserver
	{
		private var _model:MapModel;
		private var _gameLoop:GameLoop;
		
		private var _world:World;
		
		public function MapController(model:MapModel)
		{
			_model = model;
		}
		
		public function update():void 
		{
			_world.update();
		}
		
		public function addGameObject(model:ShopModel):void
		{
			var gameObject:GameObject = GameObjectFactory.createIsometricGameObject(model.name);
			
			var point:Point = _world.getFreePositionNextTo(5, 5);
			gameObject.display.position(point.x, point.y);
			
			_world.add(gameObject);
		}
		
		public function set canvas(content:Sprite):void
		{
			if (_world == null)
			{
				_world = new World(new Rectangle(0, 0, MathUtil.TILE_WIDTH, MathUtil.TILE_HEIGHT), new Rectangle(0, 0, _model.width, _model.height), content);
				
				createGameLoop();
			}
		}
		
		private function createGameLoop():void 
		{
			GameLoop.getInstance().init(30);
			GameLoop.getInstance().addObserver(this);
		}
		
		public function itemSelectedHandler(e:GameEvent):void 
		{
			addGameObject(e.shopModel);
		}
	}
}