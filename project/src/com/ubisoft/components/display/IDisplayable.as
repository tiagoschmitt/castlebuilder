package com.ubisoft.components.display {
	import com.ubisoft.components.IPositionable;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public interface IDisplayable extends IPositionable
	{
		function get content():DisplayObject
		function set content(content:DisplayObject):void
	}

}