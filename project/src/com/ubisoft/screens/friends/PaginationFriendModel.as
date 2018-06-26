package com.ubisoft.screens.friends 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.screens.PaginationModel;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class PaginationFriendModel extends PaginationModel
	{
		public function PaginationFriendModel() 
		{
			super(6);
		}
		
		override public function deserialize(data:XML, type:String = ""):void 
		{
			var friendModel:FriendModel;
			
			for (var i:String in data.friends.friend)
			{
				friendModel = new FriendModel();
				friendModel.deserialize(data.friends.friend[i]);
				
				_list.push(friendModel);
			}
		}
	}
}