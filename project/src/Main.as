package 
{
	import com.ubisoft.factories.ShopFactory;
	import com.ubisoft.screens.main.MainController;
	import com.ubisoft.screens.main.MainView;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			stage.addEventListener("resize", resizeHandler);
			resizeHandler(null);
		}
		
		private function resizeHandler(e:*):void 
		{
			var viewport:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			if (_starling == null)
			{
				_starling = new Starling(MainView, stage, viewport);
				_starling.start();
				_starling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
			}
			
			_starling.viewPort = viewport;
			_starling.stage.stageWidth = 960;
			_starling.stage.stageHeight = 640;
		}
		
		private function rootCreatedHandler(e:Event):void 
		{
			var view:MainView = (_starling.root as MainView);
			var controlller:MainController = new MainController();
			view.controller = controlller;
			
			ShopFactory.getInstance().addEventListener("complete", loadCompleteHandler);
		}
		
		private function loadCompleteHandler(e:*):void 
		{
			var view:MainView = (_starling.root as MainView);
			view.show();
		}
	}
}