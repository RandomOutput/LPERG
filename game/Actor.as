package game {
	
	public class Actor {
		
		public var posX:Number;
		public var posY:Number;
		public var lastPosX:Number;
		public var lastPosY:Number;
		public var forwardVecX:Number;
		public var forwardVecY:Number;
		public var health:Number;
		public var type:int;

		public function Actor(_posX:Number, _posY:Number, _health:Number,_type:int, _forwardVecX:Number = 0, _forwardVecY:Number = 1) {
			lastPosX = _posX;
			lastPosY = _posY;
			posX = _posX;
			posY = _posY;
			health = _health;
			type = _type;
			forwardVecX = _forwardVecX;
			forwardVecY = _forwardVecY;
		}
	}
}
