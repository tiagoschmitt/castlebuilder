package com.ubisoft.components {
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public interface IPositionable 
	{
		function get x():int;
		function get y():int;
		
		function set x(x:int):void;
		function set y(y:int):void;
		
		function position(x:int, y:int):void;
	}
}