package com.ubisoft.components.display {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import com.ubisoft.components.display.DisplayComponent;
	import com.ubisoft.components.IPositionable;
	import com.ubisoft.utils.MathUtil;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import starling.display.Sprite;
	
	public class IsometricDisplayComponent extends DisplayComponent
	{
		
		public function IsometricDisplayComponent(content:Sprite) 
		{
			super(content);
		}
		
		override public function position(x:int, y:int):void 
		{
			super.position(x, y);
			
			var point:Point =  MathUtil.isometricToScreen(new Point(x, y));
			
			_content.x = point.x;
			_content.y = point.y;
		}
	}
}