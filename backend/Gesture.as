package backend {
	
	public class Gesture {
		public var type:int;
		public var associatedPlayers:Vector.<int>;
		public var amountCompleted:Number;

		public function Gesture(_type:int, _associatedPlayers:Vector.<int>, _amountCompleted:Number) {
			type = _type;
			associatedPlayers = _associatedPlayers;
			amountCompleted = _amountCompleted;
		}

	}
	
}
