package com.ubisoft.screens.main 
{
	import com.ubisoft.factories.ShopFactory;
	import com.ubisoft.managers.FileManager;
	import com.ubisoft.screens.friends.PaginationFriendModel;
	import com.ubisoft.screens.map.MapModel;
	import com.ubisoft.screens.shop.PaginationShopModel;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class MainController
	{
		private var _paginationFriendModel:PaginationFriendModel;
		private var _paginationWorkshopModel:PaginationShopModel;
		private var _paginationDecorationModel:PaginationShopModel;
		private var _mapModel:MapModel;
		
		public function MainController() 
		{
			createPaginationFriendModel(FileManager.loadFriends());
			createMapModel(FileManager.loadMap());
			
			var shopData:XML = FileManager.loadShop();
			createPaginationWorkshopModel(shopData);
			createPaginationDecorationModel(shopData);
			
			ShopFactory.getInstance().init(_paginationWorkshopModel.list.concat(_paginationDecorationModel.list));
		}
		
		private function createMapModel(xml:XML):void 
		{
			_mapModel = new MapModel();
			_mapModel.deserialize(xml);
		}
		
		private function createPaginationFriendModel(xml:XML):void
		{
			_paginationFriendModel = new PaginationFriendModel();
			_paginationFriendModel.deserialize(xml);
		}
		
		private function createPaginationWorkshopModel(xml:XML):void
		{
			_paginationWorkshopModel = new PaginationShopModel();
			_paginationWorkshopModel.deserialize(xml, "workshop");
		}
		
		private function createPaginationDecorationModel(xml:XML):void
		{
			_paginationDecorationModel = new PaginationShopModel();
			_paginationDecorationModel.deserialize(xml, "decoration");
		}
		
		public function get paginationFriendModel():PaginationFriendModel 
		{
			return _paginationFriendModel;
		}
		
		public function get paginationWorkshopModel():PaginationShopModel 
		{
			return _paginationWorkshopModel;
		}
		
		public function get paginationDecorationModel():PaginationShopModel 
		{
			return _paginationDecorationModel;
		}
		
		public function get mapModel():MapModel 
		{
			return _mapModel;
		}
	}
}