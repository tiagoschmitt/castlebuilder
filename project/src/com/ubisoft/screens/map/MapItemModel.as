package com.ubisoft.screens.map 
{
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	public class MapItemModel
	{
		private var _type:String;
		private var _name:String;
		private var _posX:String;
		private var _posY:String;
		
		public function deserialize(xml:XML):void
		{
			_type = xml.@type;
			_name = xml.@name;
			_posX = xml.@posx;
			_posY = xml.@posy;
		}
	}
}