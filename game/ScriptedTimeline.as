package game {
	
	public class ScriptedTimeline {
		
		public var startFrame:int;
		public var msPerSample:Number;
		public var sampleRate:Number;
		public var posX:Vector.<int>;
		public var posY:Vector.<int>;
		public var types:Vector.<int>;

		public function ScriptedTimeline(_startFrame:int, _posX:Vector.<int>, _posY:Vector.<int>, _types:Vector.<int>, _fps:int = 24) {
			startFrame = _startFrame;
			posX = _posX;
			posY = _posY;
			types = _types;
			msPerSample = 1000/_fps;
			sampleRate = 1/msPerSample;
		}

	}
	
}
