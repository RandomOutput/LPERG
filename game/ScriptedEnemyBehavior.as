package game {
	import utilities.DualLinkedList;
	
	public class ScriptedEnemyBehavior {

		public function ScriptedEnemyBehavior() {
			// constructor code
		}
		
		public function updateEnemies(_scriptedEnemyList:DualLinkedList, _enemyWeaponList:DualLinkedList, _time:int):void{
			var scriptedEnemy:DualLinkedList = _scriptedEnemyList;
			scriptedEnemy.moveToHead();
			var i:int = 0;
			while(scriptedEnemy.currentNode != null){
				var currentEnemy:ScriptedEnemy = scriptedEnemy.currentNode.object;
				var currentFloatFrame:Number = (_time - currentEnemy.msStartTime) * currentEnemy.scriptedTimeline.sampleRate;
				
				if(int(currentFloatFrame) >= currentEnemy.scriptedTimeline.posX.length){
					scriptedEnemy.killThisNode();
				} else {
					currentEnemy.posX = currentEnemy.scriptedTimeline.posX[12];
					if(i == 0){
						trace(currentEnemy.posX);
						trace(int(currentFloatFrame));
						i++;
					}
				}
				scriptedEnemy.advanceNode();
			}
		}

	}
	
}
