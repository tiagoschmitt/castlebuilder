package com.ubisoft.screens.map {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.factories.ImageFactory;
	import com.ubisoft.screens.IView;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class MapView extends Sprite implements IView
	{
		private var _model:MapModel;
		private var _controller:MapController;
		
		private var _bg:Sprite;
		
		private var _container:Sprite;
		
		public function MapView(model:MapModel, controller:MapController) 
		{
			_model = model;
			_controller = controller;
		}
		
		public function show():void 
		{
			createBG();
			
			_container = new Sprite();
			addChild(_container);
		}
		
		public function hide():void 
		{
			
		}
		
		private function createBG():void
		{
			_bg = new Sprite();
			addChild(_bg);
			
			loadImage();
		}
		
		private function loadImage():void
		{
			ImageFactory.loadImage(_model.url, function(image:Image):void 
			{
				_bg.addChild(image);
				_bg.scaleX = 0.8;
				_bg.scaleY = 0.8;
				
				_container.x = 720;
				_container.y = 180;
				
				x = -300;
				y = -300;
			});
		}
		
		public function get container():Sprite 
		{
			return _container;
		}
	}
}