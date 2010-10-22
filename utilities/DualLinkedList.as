package utilities {
	
	import utilities.DualNode;
	
	public class DualLinkedList {
		private var head:DualNode;
		private var tail:DualNode;
		public var currentNode:DualNode;		

		public function DualLinkedList() {
		}
		
		public function killThisNode():void{
			var isNotTail:Boolean = (currentNode != tail);
			var isNotHead:Boolean = (currentNode != head);
			if(isNotTail && isNotHead){
				currentNode.nextNode.prevNode = currentNode.prevNode;
				currentNode.prevNode.nextNode = currentNode.nextNode;
			} else if(isNotHead == false && isNotTail == false){
				currentNode = null;
				head = null;
				tail = null;
			} else if(isNotTail == false){
				tail = currentNode.prevNode;
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
		
		public function moveToTail():void{
			currentNode = tail;
		}
		
		public function reverseNode():void{
			currentNode = currentNode.prevNode;
		}
		
		public function push(node:DualNode):void{
			if(head == null){
				head = node;
				currentNode = node;
				tail = node;
			} else {
				tail.nextNode = node;
				node.prevNode = tail;
				tail = node;
			}
		}
	}
}
