package com.ubisoft.events 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.screens.shop.ShopModel;
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		public static var ITEM_SELECTED:String = "itemSelected";
		
		private var _shopModel:ShopModel;
		
		public function GameEvent(type:String, shopModel:ShopModel) 
		{
			super(type);
			
			_shopModel = shopModel;
		}
		
		public function get shopModel():ShopModel 
		{
			return _shopModel;
		}
		
	}

}