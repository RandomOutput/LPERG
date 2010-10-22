package utilities {
	
	import utilities.DualNode;
	
	public class DualLinkedList {
		private var head:DualNode;
		private var tail:DualNode;
		public var currentNode:DualNode;		

		public function DualLinkedList() {
			head = new DualNode();
			currentNode = head;
			tail = head;
		}
		
		public function killThisNode():void{
			var isNotTail:Boolean = node != Tail;
			var isNotHead:Boolean = node != Head;
			if(isNotTail && isNotHead){
				currentNode.nextNode.prevNode = currentNode.prevNode;
				currentNode.prevNode.nextNode = currentNode.nextNode;
			} else if(isNotHead == false && isNotTail == false){
				currentNode.object = null;
			} else if(isNotTail == false){
				tail = node.prevNode;
				currentNode.prevNode.nextNode = null;
			} else if(isNotHead == false){
				head = head.nextNode;
				head.prevNode = null;
			} 
		}
		
		public function advanceNode():void{
			currentNode = currentNode.nextNode;
		}
		
		public function moveToHead():void{
			currentNode = head;
		}
		
		public function moveToHead():void{
			currentNode = tail;
		}
		
		public function reverseNode():void{
			currentNode = currentNode.prevNode;
		}
		
		public function push(node:DualNode):void{
			if(head.object == null){
				head.object = node;
			} else {
				tail.nextNode = node;
				tail = node;
			}
		}
	}
}
