package com.ubisoft.screens.shop 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.screens.PaginationModel;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class PaginationShopModel extends PaginationModel
	{
		public function PaginationShopModel() 
		{
			super(8);
		}
		
		override public function deserialize(data:XML, type:String = ""):void 
		{
			var model:ShopModel;
			
			for (var i:String in data.items.item)
			{
				if (data.items.item[i].@type == type)
				{
					model = new ShopModel();
					model.deserialize(data.items.item[i]);
					
					_list.push(model);
				}
			}
		}
	}
}