package com.ubisoft.screens.main {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.events.GameEvent;
	import com.ubisoft.factories.ImageFactory;
	import com.ubisoft.screens.map.MapController;
	import com.ubisoft.screens.map.MapView;
	import com.ubisoft.screens.PaginationController;
	import com.ubisoft.screens.friends.FriendListView;
	import com.ubisoft.screens.IView;
	import com.ubisoft.screens.PaginationController;
	import com.ubisoft.screens.shop.ShopView;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainView extends Sprite implements IView
	{
		private var _controller:MainController;
		private var _shopView:ShopView;
		
		private var _mapController:MapController;
		
		public function MainView() 
		{
			
		}
		
		public function show():void 
		{
			createMap();
			createFriendList();
			createShopIcon();
		}
		
		public function hide():void 
		{
			
		}
		
		private function createMap():void 
		{
			_mapController = new MapController(_controller.mapModel);
			var mapView:MapView = new MapView(_controller.mapModel, _mapController);
			addChild(mapView);
			
			mapView.show();
			
			_mapController.canvas = mapView.container;
		}
		
		private function createFriendList():void 
		{
			var friendListController:PaginationController = new PaginationController(_controller.paginationFriendModel);
			
			var friendListView:FriendListView = new FriendListView(_controller.paginationFriendModel, friendListController);
			addChild(friendListView);
			friendListView.show();
			
			friendListView.y = Starling.current.stage.stageHeight - friendListView.height;
		}
		
		private function createShopIcon():void 
		{
			var shop:DisplayComponent = new DisplayComponent(ImageFactory.getImage(ImageFactory.SHOP));
			shop.x = width * 0.95 - shop.content.width;
			shop.y = Starling.current.stage.stageHeight - shop.content.height - 5;
			shop.addEventListener(TouchEvent.TOUCH, touchShopHandler);
			addChild(shop.content);
		}
		
		private function createShop():void
		{
			if (_shopView == null)
			{
				_shopView = new ShopView(_controller.paginationWorkshopModel, _controller.paginationDecorationModel);
				addChild(_shopView);
				_shopView.show();
				_shopView.addEventListener(Event.CLOSE, closeShopHandler);
				
				_shopView.x = (Starling.current.stage.stageWidth - _shopView.width) / 2;
				_shopView.y = 30;
				_shopView.addEventListener(GameEvent.ITEM_SELECTED, itemSelectedHandler);
			}
		}
		
		private function itemSelectedHandler(e:GameEvent):void 
		{
			destroyShop();
			
			_mapController.itemSelectedHandler(e);
		}
		
		private function destroyShop():void
		{
			_shopView.removeEventListener(GameEvent.ITEM_SELECTED, itemSelectedHandler);
			_shopView.hide();
			removeChild(_shopView);
			_shopView = null;
		}
		
		private function closeShopHandler(e:Event):void 
		{
			destroyShop();
		}
		
		private function touchShopHandler(e:TouchEvent):void 
		{
			if (e.getTouch(e.target as DisplayObject).phase == TouchPhase.ENDED)
			{
				createShop();
			}
		}
		
		public function set controller(value:MainController):void 
		{
			_controller = value;
		}
	}
}