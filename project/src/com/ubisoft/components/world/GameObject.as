package com.ubisoft.components.world {
	import com.ubisoft.components.display.IDisplayable;
	import com.ubisoft.components.IPositionable;
	import com.ubisoft.components.world.ITileable;
	import flash.events.TouchEvent;
	
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	public class GameObject implements ITileable
	{
		protected var _display:IDisplayable;
		
		public function GameObject(display:IDisplayable) 
		{
			_display = display;
		}
		
		public function get display():IDisplayable 
		{
			return _display;
		}
	}
}