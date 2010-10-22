package game {
	
	public class ScriptedEnemy extends Actor{
		
		public var msShotDelay:int;
		public var msLastShot:int;
		public var scriptedTimeline:ScriptedTimeline;
		public var msStartTime:int;

		public function ScriptedEnemy(_posX:Number, _posY:Number, _health:Number,_type:int, _forwardVecX:Number = 0, _forwardVecY:Number = 1, _msShotDelay:int = 1000, _msLastShot:int = 0, _scriptedTimeline:ScriptedTimeline = null, _time:int = 0) {
			super(_posX, _posY, _health,_type, _forwardVecX, _forwardVecY);
			msStartTime = _time;
			msShotDelay = _msShotDelay;
			msLastShot = _msLastShot;
			scriptedTimeline = _scriptedTimeline;
		}

	}
	
}
