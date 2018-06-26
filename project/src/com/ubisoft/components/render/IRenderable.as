/**
 * ...
 * >author		Tiago Schmitt
 */

package com.ubisoft.components.render
{
	import com.ubisoft.components.display.IDisplayable;
	import starling.display.Sprite;
	
	public interface IRenderable 
	{
		
		function getCanvas():Sprite;
		function getObjects():Vector.<IDisplayable>;
	}
}