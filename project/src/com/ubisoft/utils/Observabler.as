/**
 * ...
 * >author		Tiago Schmitt
 */

package com.ubisoft.utils {
	public class Observabler 
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		private var _observers												: Vector.<IObserver>;
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function Observabler()
		{
			_observers = new Vector.<IObserver>();
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public function addObserver(observer:IObserver):void
		{
			_observers.push(observer);
		}
		
		public function removeObserver(observer:IObserver):void
		{
			for (var i: int = 0; i < _observers.length; i++)
			{
				if (_observers[i] == observer)
				{
					_observers.splice(i, 1);
					
					return;
				}
			}
		}
		
		public function notifyObservers(): void
		{
			for (var i: int = 0; i < _observers.length; i++)
			{
				_observers[i].update();
			}
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		// ___________________________________________________________________ EVENTS
	}
}