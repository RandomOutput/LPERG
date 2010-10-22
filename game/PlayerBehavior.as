package game {
	
	import utilities.DualLinkedList;
	import backend.IRPoint;
	import backend.Gesture;
	import utilities.DualNode;
	//import game.Bullet;
	
	public class PlayerBehavior{
		
		public function PlayerBehavior(){
		}
		
		public function updatePlayers(playerList:DualLinkedList, playerWeaponList:DualLinkedList, time:int, irPoints:Vector.<IRPoint>, gestures:Vector.<Gesture>):void{
			var irPointIndex = 0;
			playerList.moveToHead();
				while(playerList.currentNode != null && irPointIndex < irPoints.length){
					var currentPlayer:Player = playerList.currentNode.object;
					var newPosX:Number = irPoints[irPointIndex].posX;
					var newPosY:Number = irPoints[irPointIndex].posY;
					
					//update player position
					currentPlayer.posX = newPosX;
					currentPlayer.posY = newPosY;
					
					//fire weapons
					if(time - currentPlayer.msLastShot > currentPlayer.msShotDelay){
						playerWeaponList.push(new DualNode(new Bullet(newPosX,newPosY,1,1)));
						currentPlayer.msLastShot = time;
					}
					playerList.advanceNode();
					irPointIndex++;
				}
		}
		
		public function spawnPlayers(playerList:DualLinkedList, numberOfPlayers:int = 4, time:int = 0):void{
			for(var i:int = 0; i < numberOfPlayers; i++){
				//to-do these constructor values will be xml-driven
				playerList.push(new DualNode(new Player(0,0,100,1,0,1,1000,time)));
			}
		}
	}
}
