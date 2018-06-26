package com.ubisoft.screens.friends {
	import adobe.utils.CustomActions;
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.factories.ImageFactory;
	import com.ubisoft.screens.IView;
	import com.ubisoft.screens.PaginationController;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchMarker;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class FriendListView extends Sprite implements IView
	{
		private var _model:PaginationFriendModel;
		private var _controller:PaginationController;
		
		private var _friends:Vector.<DisplayComponent>;
		
		private var _prev:DisplayComponent;
		private var _next:DisplayComponent;
		
		public function FriendListView(model:PaginationFriendModel, controller:PaginationController) 
		{
			_model = model;
			_controller = controller;
			
			_friends = new Vector.<DisplayComponent>();
		}
		
		public function show():void 
		{
			var background:Shape = new Shape();
			
			background.graphics.beginFill(0xFEAA00, 1);
			background.graphics.drawRect(0, 0, Starling.current.stage.stageWidth, 120);
			background.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(background.width, background.height);
			bmd.draw(background);
			
			addChild(new Image(Texture.fromBitmapData(bmd)));
			
			_prev = new DisplayComponent(ImageFactory.getImage(ImageFactory.PREVIOUS));
			_prev.x = 20;
			_prev.y = (this.height - _prev.content.height) / 2;
			_prev.addEventListener(TouchEvent.TOUCH, touchPrevHandler);
			addChild(_prev.content);
			
			_next = new DisplayComponent(ImageFactory.getImage(ImageFactory.NEXT));
			_next.x = width * 0.70;
			_next.y = (this.height - _prev.content.height) / 2;
			_next.addEventListener(TouchEvent.TOUCH, touchNextHandler);
			addChild(_next.content);
			
			update();
			
			_model.addEventListener(Event.CHANGE, changeHandler);
		}
		
		public function update():void
		{
			removeFriends();
			updateNavigator();
			
			_friends = new Vector.<DisplayComponent>();
			
			var models:Vector.<Object> = _model.getPage();
			var length:int = models.length;
			var friendView:FriendView;
			
			for (var i:int = 0; i < length; i++)
			{
				friendView = new FriendView(models[i] as FriendModel);
				addChild(friendView.content);
				
				friendView.x = 70 + (i * (friendView.content.width + 30));
				friendView.y = (height - friendView.content.height) / 2;
				
				_friends.push(friendView);
			}
		}
		
		public function removeFriends():void
		{
			var length:int = _friends.length;
			
			for (var i:int = 0; i < length; i++)
			{
				_friends[i].destroy();
			}
		}
		
		public function hide():void 
		{
		}
		
		private function updateNavigator():void
		{
			_prev.content.visible = true;
			_next.content.visible = true;
			
			if (_controller.isFirstPage())
			{
				_prev.content.visible = false;
			}
			
			if (_controller.isLastPage())
			{
				_next.content.visible = false;
			}
		}
		
		private function touchPrevHandler(e:TouchEvent):void 
		{
			if (e.getTouch(e.target as DisplayObject).phase == TouchPhase.ENDED)
			{
				_controller.prevPage();
			}
		}
		
		private function touchNextHandler(e:TouchEvent):void 
		{
			if (e.getTouch(e.target as DisplayObject).phase == TouchPhase.ENDED)
			{
				_controller.nextPage();
			}
		}
		
		private function changeHandler(e:Event):void 
		{
			update();
		}
	}
}