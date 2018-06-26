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
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	public class ShopView extends Sprite implements IView
	{
		private var _workshopView:ShopTabContentView;
		private var _decorationView:ShopTabContentView;
		
		private var _workshopTab:ShopTabView;
		private var _decorationTab:ShopTabView;
		
		private var _workshopModel:PaginationShopModel;
		private var _decorationModel:PaginationShopModel;
		private var _closeButton:DisplayComponent;
		
		public function ShopView(workshopModel:PaginationShopModel, decorationModel:PaginationShopModel) 
		{
			_workshopModel = workshopModel;
			_decorationModel = decorationModel;
		}
		
		public function show():void 
		{
			createBackground();
			
			var workshopController:PaginationController = new PaginationController(_workshopModel);
			_workshopView = new ShopTabContentView(_workshopModel, workshopController);
			addChild(_workshopView);
			_workshopView.show();
			_workshopView.addEventListener(GameEvent.ITEM_SELECTED, itemSelectedHandler);
			
			var decorationController:PaginationController = new PaginationController(_decorationModel);
			_decorationView = new ShopTabContentView(_decorationModel, decorationController);
			addChild(_decorationView);
			_decorationView.visible = false;
			_decorationView.show();
			_decorationView.addEventListener(GameEvent.ITEM_SELECTED, itemSelectedHandler);
			
			createTabs();
			
			_closeButton = new DisplayComponent(ImageFactory.getImage(ImageFactory.CLOSE));
			_closeButton.x = this.width - _closeButton.content.width;
			addChild(_closeButton.content);
			
			_closeButton.addEventListener(TouchEvent.TOUCH, touchCloseHandler);
		}
		
		private function itemSelectedHandler(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		private function touchCloseHandler(e:TouchEvent):void 
		{
			dispatchEvent(new Event(Event.CLOSE));
		}
		
		public function hide():void 
		{
			_workshopView.removeEventListener(GameEvent.ITEM_SELECTED, itemSelectedHandler);
			_decorationView.removeEventListener(GameEvent.ITEM_SELECTED, itemSelectedHandler);
			
			_workshopView.hide();
			_workshopView = null;
			
			_decorationView.hide()
			_decorationView = null;
			
			_closeButton.removeEventListener(TouchEvent.TOUCH, touchCloseHandler);
			_workshopTab.removeEventListener(TouchEvent.TOUCH, touchWorkshopTabHandler);
			_decorationTab.removeEventListener(TouchEvent.TOUCH, touchDecorationTabHandler);
			
			
		}
		
		private function createTabs():void 
		{
			_workshopTab = new ShopTabView("Workshop", true);
			_workshopTab.x = 25;
			addChild(_workshopTab.content);
			_workshopTab.addEventListener(TouchEvent.TOUCH, touchWorkshopTabHandler);
			
			_decorationTab = new ShopTabView("Decoration", false);
			_decorationTab.x = _workshopTab.x + _workshopTab.content.width;
			addChild(_decorationTab.content);
			_decorationTab.addEventListener(TouchEvent.TOUCH, touchDecorationTabHandler);
		}
		
		private function createBackground():void 
		{
			var background:Shape = new Shape();
			background.graphics.beginFill(0xFEAA00, 1);
			background.graphics.drawRect(0, 0, Starling.current.stage.stageWidth - 100, Starling.current.stage.stageHeight - 150);
			background.graphics.endFill();
			
			background.graphics.beginFill(0xFFFFFF, 1);
			background.graphics.drawRect(25, 25, background.width - 50, background.height - 25);
			background.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(background.width, background.height);
			bmd.draw(background);
			
			addChild(new Image(Texture.fromBitmapData(bmd)));
		}
		
		private function touchWorkshopTabHandler(e:TouchEvent):void 
		{
			if (!_workshopTab.selected) 
			{
				_workshopTab.selected = true;
				_decorationTab.selected = false;
				
				_workshopView.visible = true;
				_decorationView.visible = false;
			}
		}
		
		private function touchDecorationTabHandler(e:TouchEvent):void 
		{
			if (!_decorationTab.selected) 
			{
				_decorationTab.selected = true;
				_workshopTab.selected = false;
				
				_decorationView.visible = true;
				_workshopView.visible = false;
			}
		}
	}
}