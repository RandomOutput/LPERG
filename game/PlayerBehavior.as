package game {
	
	import utilities.DualLinkedList;
	import backend.IRPoint;
	import backend.Gesture;
	
	public class PlayerBehavior{
		
		public function PlayerBehavior(){
			//to-do XML code read
		}
		
		public updatePlayers(playerList:DualLinkedList, playerWeaponList:DualLinkedList, time:int, irPoints:Vector.<IRPoint>, gestures:Vector.<Gesture>){
			var irPointIndex = 0;
			playerList.moveToHead();
				while(playerList.currentNode != null && irPointIndex < irPoints.length){
					var newPosX:Number = irPoints[irPointIndex].posX;
					var newPosY:Number = irPoints[irPointIndex].posY;
					
					//update player position
					playerList.currentNode.object.posX = newPosX;
					playerList.currentNode.object.posY = newPosY;
					
					//fire weapons
					if(time - playerList.currentNode.object.msLastShot > playerList.currentNode.object.msShotDelay){
						playerWeaponList.push(new Player(newPosX,newPosY,1,0));
						playerList.currentNode.object.msLastShot = time;
					}
					
					playerList.advanceNode();
					irPointIndex++;
				}
		}
		
		public spawnPlayers(playerList:DualLinkedList, numberOfPlayers:int = 4, time:int){
			for(var i:int = 0; i < numberOfPlayers; i++){
				//to-do these constructor values will be xml-driven
				playerList.push(new Player(0,0,100,0,0,1,1000,time));
			}
		}
	}
}
