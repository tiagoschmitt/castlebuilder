package com.ubisoft.pool 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class Pool 
	{
		private static var _instance:Pool;
		
		protected var _reusablesFree:Vector.<IReusable>;
		protected var _reusablesUsed:Vector.<IReusable>;
		
		public function Pool (singleton:SingletonObligate)
		{
			_reusablesFree = new Vector.<IReusable>();
			_reusablesUsed = new Vector.<IReusable>();
		}
		
		public static function getInstance():Pool
		{
			if (!Pool._instance) 
				Pool._instance = new Pool(new SingletonObligate());
			
			return Pool(Pool._instance);
		}
		
		public function addReusable(reusable:IReusable):void
		{
			_reusablesFree.push(reusable);
		}
		
		public function acquire(id:String):IReusable
		{
			var length:int = _reusablesFree.length;
			
			var reusable:IReusable;
			
			for (var i:int = 0; i < length; i++)
			{
				if (_reusablesFree[i].id == id)
				{
					reusable = _reusablesFree.splice(i, 1)[0];
					_reusablesUsed.push(reusable);
					
					return reusable;
				}
			}
			
			return null;
		}
		
		public function release(reusable:IReusable):void
		{
			var length:int = _reusablesUsed.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (_reusablesUsed[i] == reusable)
				{
					_reusablesFree.push(_reusablesUsed.splice(i, 1)[0]);
					break;
				}
			}
		}
		
		public function releaseAll():void
		{
			var length:int = _reusablesUsed.length;
			
			for (var i:int = 0; i < length; i++)
				_reusablesFree.push(_reusablesUsed[i]);
			
			_reusablesUsed = new Vector.<IReusable>();
		}
	}
}

class SingletonObligate {}
