package game {
	
	public class ScriptedEnemy extends Actor{
		
		public var msShotDelay:int;
		public var msLastShot:int;
		public var posXTimeline:Vector.<int>;
		public var posYTimeline:Vector.<int>;
		public var typeTimeline:Vector.<int>;

		public function ScriptedEnemy(_posX:Number, _posY:Number, _health:Number,_type:int, _forwardVecX:Number = 0, _forwardVecY:Number = 1, _msShotDelay:int = 1000, _msLastShot:int = 0, _posXTimeline:Vector.<int> = null, _posYTimeline:Vector.<int> = null, _typeTimeline:Vector.<int> = null) {
			super(_posX, _posY, _health,_type, _forwardVecX, _forwardVecY);
			msShotDelay = _msShotDelay;
			msLastShot = _msLastShot;
			posXTimeline = _posXTimeline;
			posYTimeline = _posYTimeline;
			typeTimeline = _typeTimeline;
		}

	}
	
}
