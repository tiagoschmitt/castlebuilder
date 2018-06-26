package com.ubisoft.components.display {
	import com.ubisoft.components.IPositionable;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class DisplayComponent extends EventDispatcher implements IDisplayable
	{
		protected var _content:DisplayObject;
		protected var _x:int;
		protected var _y:int;
		
		public function DisplayComponent(content:DisplayObject) 
		{
			_content = content;
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			_content.addEventListener(type, listener);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			_content.removeEventListener(type, listener);
		}
		
		public function destroy():void
		{
			if (_content != null && _content.parent != null)
			{
				_content.parent.removeChild(_content);
				_content = null;
			}
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function set x(value:int):void 
		{
			_x = value;
			_content.x = value;
		}
		
		public function set y(value:int):void 
		{
			_y = value;
			_content.y = value;
		}
		
		public function position(x:int, y:int):void 
		{
			this.x = x;
			this.y = y;
		}
		
		public function get content():DisplayObject 
		{
			return _content;
		}
		
		public function set content(value:DisplayObject):void 
		{
			_content = value;
		}
	}
}