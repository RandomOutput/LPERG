package game {
	
	public class ScriptedTimeline {
		
		public var startFrame:int;
		public var posX:Vector.<int>;
		public var posY:Vector.<int>;
		public var types:Vector.<int>;

		public function ScriptedTimeline(_startFrame:int, _posX:Vector.<int>, _posY:Vector.<int>, _types:Vector.<int>) {
			startFrame = _startFrame;
			posX = _posX;
			posY = _posY;
			types = _types;
		}

	}
	
}
