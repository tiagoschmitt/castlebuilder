package com.ubisoft.screens.map 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class MapModel
	{
		private var _url:String;
		private var _width:int;
		private var _height:int;
		
		private var _items:Vector.<MapItemModel>;
		
		
		public function MapModel() 
		{
			_items = new Vector.<MapItemModel>();
		}
		
		public function deserialize(data:XML):void
		{
			_url = data.map.@url;
			_width = data.map.@width;
			_height = data.map.@height;
			
			var item:MapItemModel;
			
			for (var i:String in data.items.item)
			{
				item = new MapItemModel();
				item.deserialize(data.items.item[i]);
				
				_items.push(item);
			}
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
	}

}