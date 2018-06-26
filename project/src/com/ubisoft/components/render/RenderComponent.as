package com.ubisoft.components.render 
{
	import com.ubisoft.components.display.IDisplayable;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class RenderComponent 
	{
		private var _renderable:IRenderable;
		private var _canvas:Sprite;
		
		public function RenderComponent(renderable:IRenderable) 
		{
			_renderable = renderable;
			_canvas = renderable.getCanvas();
		}
		
		public function update():void
		{
			if (_canvas.numChildren > 0)
			{
				_canvas.removeChildren(0, _canvas.numChildren - 1);
			}
			
			var objects:Vector.<IDisplayable> = _renderable.getObjects();
			var length:int = objects.length;
			
			for (var i:int = 0; i < length; i++)
			{
				_canvas.addChild(objects[i].content);
			}
		}
	}
}