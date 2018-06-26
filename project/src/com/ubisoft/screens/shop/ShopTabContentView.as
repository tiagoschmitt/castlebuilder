package com.ubisoft.screens.shop 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.events.GameEvent;
	import com.ubisoft.factories.ImageFactory;
	import com.ubisoft.screens.IView;
	import com.ubisoft.screens.PaginationController;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class ShopTabContentView extends Sprite implements IView
	{
		private var _model:PaginationShopModel;
		private var _controller:PaginationController;
		
		private var _items:Vector.<DisplayComponent>;
		
		private var _prev:DisplayComponent;
		private var _next:DisplayComponent;
		
		public function ShopTabContentView(model:PaginationShopModel, controller:PaginationController) 
		{
			_model = model;
			_controller = controller;
			
			_items = new Vector.<DisplayComponent>();
		}
		
		public function show():void 
		{
			_prev = new DisplayComponent(ImageFactory.getImage(ImageFactory.PREVIOUS));
			_prev.x = 10;
			_prev.y = (parent.height - _prev.content.height) / 2;
			_prev.addEventListener(TouchEvent.TOUCH, touchPrevHandler);
			addChild(_prev.content);
			
			_next = new DisplayComponent(ImageFactory.getImage(ImageFactory.NEXT));
			_next.x = parent.width - _next.content.width - 10 ;
			_next.y = (parent.height - _next.content.height) / 2;
			_next.addEventListener(TouchEvent.TOUCH, touchNextHandler);
			addChild(_next.content);
			
			update();
			
			_model.addEventListener(Event.CHANGE, changeHandler, false, 0, true);
		}
		
		public function hide():void 
		{
			_prev.removeEventListener(TouchEvent.TOUCH, touchPrevHandler);
			_next.removeEventListener(TouchEvent.TOUCH, touchNextHandler);
			_model.removeEventListener(Event.CHANGE, changeHandler);
			removeItems();
		}
		
		public function update():void
		{
			removeItems();
			updateNavigator();
			
			_items = new Vector.<DisplayComponent>();
			
			var models:Vector.<Object> = _model.getPage();
			var length:int = models.length;
			var shopItemView:ShopItemView;
			
			for (var i:int = 0; i < length; i++)
			{
				shopItemView = new ShopItemView(models[i] as ShopModel);
				addChild(shopItemView.content);
				shopItemView.addEventListener(TouchEvent.TOUCH, touchItemHandler);
				
				shopItemView.x = 65 + ((i % 4) * (shopItemView.content.width + 30));
				shopItemView.y = 50 + (int(i / 4) *(shopItemView.content.height + 30));
				
				_items.push(shopItemView);
			}
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
		
		private function removeItems():void
		{
			var length:int = _items.length;
			
			for (var i:int = 0; i < length; i++)
			{
				_items[i].addEventListener(TouchEvent.TOUCH, touchItemHandler);
				_items[i].destroy();
			}
			
			_items = null;
		}
		
		private function touchItemHandler(e:TouchEvent):void 
		{
			if (e.getTouch(e.currentTarget as DisplayObject).phase == TouchPhase.ENDED)
			{
				for (var i:int = 0; i < _items.length; i++)
				{
					if (_items[i].content == e.currentTarget)
					{
						dispatchEvent(new GameEvent(GameEvent.ITEM_SELECTED, (_items[i] as ShopItemView).model));
						return;
					}
				}
			}
		}
		
		private function touchPrevHandler(e:TouchEvent):void 
		{
			if (e.getTouch(e.currentTarget as DisplayObject).phase == TouchPhase.ENDED)
			{
				_controller.prevPage();
			}
		}
		
		private function touchNextHandler(e:TouchEvent):void 
		{
			if (e.getTouch(e.currentTarget as DisplayObject).phase == TouchPhase.ENDED)
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