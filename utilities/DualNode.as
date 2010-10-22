package utilities {
		
	public class DualNode {
		
		public var object:*;
		public var nextNode:DualNode;
		public var prevNode:DualNode;

		public function DualNode(_object:* = null,_prevNode:DualNode = null,_nextNode:DualNode = null) {
			object = _object;
			prevNode = _prevNode;
			nextNode = _nextNode;
		}
	}
}