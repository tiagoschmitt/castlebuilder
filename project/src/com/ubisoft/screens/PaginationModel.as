package com.ubisoft.screens {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class PaginationModel extends EventDispatcher
	{
		protected var _list:Vector.<Object>;
		protected var _totalPerPage:int;
		protected var _activeIndex:int;
		
		public function PaginationModel(totalPerPage:int) 
		{
			_totalPerPage = totalPerPage;
			_list = new Vector.<Object>();
		}
		
		public function deserialize(data:XML, type:String = ""):void
		{
			throw new Error("You need to override this method");
		}
		
		public function getPage():Vector.<Object>
		{
			var finalIndex:int = _activeIndex + _totalPerPage > _list.length - 1 ? _list.length - 1 : _activeIndex + _totalPerPage; 
			return _list.slice(_activeIndex,  _totalPerPage > _list.length ? _list.length : finalIndex);
		}
		
		public function get activeIndex():int 
		{
			return _activeIndex;
		}
		
		public function set activeIndex(value:int):void 
		{
			_activeIndex = value;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get totalPerPage():int 
		{
			return _totalPerPage;
		}
		
		public function get list():Vector.<Object> 
		{
			return _list;
		}

	}
}