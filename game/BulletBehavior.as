package game {
	
	public class BulletBehavior {
		
		import utilities.DualLinkedList;
		import utilities.DualNode;
		import game.Bullet;

		public function BulletBehavior() {
			// constructor code
		}
		
		public function updateBullets(playerWeaponList:DualLinkedList, deltaT:int):void{
			playerWeaponList.moveToHead();
				while(playerWeaponList.currentNode != null){
					var currentBullet:Bullet = playerWeaponList.currentNode.object;
					currentBullet.posX += currentBullet.forwardVecX * currentBullet.velocity;
					currentBullet.posY += currentBullet.forwardVecY * currentBullet.velocity;
					playerWeaponList.advanceNode();
				}
		}
	}
}