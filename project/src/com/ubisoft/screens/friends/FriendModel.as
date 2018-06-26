package com.ubisoft.screens.friends 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import flash.events.EventDispatcher;
	
	public class FriendModel extends EventDispatcher
	{
		private var _name:String;
		private var _level:String;
		
		public function deserialize(data:XML):void 
		{
			_name = data.@name;
			_level = data.@level;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get level():String 
		{
			return _level;
		}
		
	}

}