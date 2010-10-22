package game {
	
	public class Bullet extends Actor{
		
		public var velocity:Number;

		public function Bullet(_posX:Number, _posY:Number, _health:Number,_type:int, _forwardVecX:Number = 0, _forwardVecY:Number = 1, _velocity:Number = 0.1) {
			super(_posX, _posY, _health,_type, _forwardVecX, _forwardVecY);
			velocity = _velocity;			
		}
	}
}