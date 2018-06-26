package com.ubisoft.utils {
	/**
	 * ...
	 * @author Tiago Schmitt
	 */
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	public class GameLoop extends Observabler
	{
		private static var _instance	:GameLoop;
		
		private var _frameRate			:int;
		private var _period				:Number;
		private var _beforeTime			:int;
		private var _afterTime			:int;
		private var _timeDiff			:int;
		private var _sleepTime			:int;
		private var _overSleepTime		:int;
		private var _excess				:int;
		
		private var _gameTimer			:Timer;
		
		public function get frameRate():int { return _frameRate; }
		
		public function GameLoop(singleton:SingletonObligate) 
		{
		}
		
		public static function getInstance ():GameLoop
		{
			if (!GameLoop._instance) 
				GameLoop._instance = new GameLoop(new SingletonObligate());
			
			return GameLoop(GameLoop._instance);
		}
		
		public function init(frameRate:int):void
		{
			_frameRate = frameRate;
			
			_period = 1000 / _frameRate;
			
			_gameTimer = new Timer(_period, 1);
			
			_gameTimer.addEventListener(TimerEvent.TIMER, run);
			_gameTimer.start();
		}
		
		private function run(e:TimerEvent):void 
		{
			_beforeTime = getTimer();
			_overSleepTime = (_beforeTime - _afterTime) - _sleepTime;
			
			update();
			
			_afterTime = getTimer();
			_timeDiff = _afterTime - _beforeTime;
			_sleepTime = (_period - _timeDiff) - _overSleepTime;
			
			if (_sleepTime <= 0)
			{
				_excess -= _sleepTime;
				_sleepTime = 2;
			} 
			
			_gameTimer.reset();
			_gameTimer.delay = _sleepTime;
			_gameTimer.start();
			
			e.updateAfterEvent();
		}
		
		private function enterFrameHandler(event:Event):void
		{
			update();
		}
		
		private function update():void
		{
			notifyObservers();
		}
	}
}

class SingletonObligate {}