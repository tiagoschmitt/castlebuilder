package com.ubisoft.screens {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.screens.PaginationModel;
	
	public class PaginationController 
	{
		private var _model:PaginationModel;
		
		public function PaginationController(model:PaginationModel) 
		{
			_model = model;
		}
		
		public function nextPage():void
		{
			var index:int = _model.activeIndex;
			var totalPage:int = _model.totalPerPage;
			var models:Vector.<Object> = _model.list;
			
			index = index + totalPage > models.length - totalPage -1 ? models.length - totalPage -1: index + totalPage;
			
			_model.activeIndex = index;
		}
		
		public function prevPage():void
		{
			var index:int = _model.activeIndex;
			var totalPage:int = _model.totalPerPage;
			var models:Vector.<Object> = _model.list;
			
			index = index - totalPage < 0 ? 0 : index - totalPage;
			
			_model.activeIndex = index;
		}
		
		public function isFirstPage():Boolean
		{
			return _model.activeIndex == 0;
		}
		
		public function isLastPage():Boolean
		{
			return _model.activeIndex >= _model.list.length - _model.totalPerPage - 1;
		}
	}
}