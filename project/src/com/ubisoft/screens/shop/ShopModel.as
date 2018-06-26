package com.ubisoft.screens.shop 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import flash.events.EventDispatcher;
	
	public class ShopModel extends EventDispatcher
	{
		private var _src:String;
		private var _name:String;
		private var _type:String;
		private var _scale:int;
		private var _price:int;
		
		public function ShopModel() 
		{
		}
		
		public function deserialize(data:XML):void
		{
			_src = data.@src;
			_name = data.@name;
			_type = data.@type;
			_scale = data.@scale;
			_price = data.@price;
		}
		
		public function get scale():int 
		{
			return _scale;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get src():String 
		{
			return _src;
		}
		
		public function get price():int 
		{
			return _price;
		}
	}
}