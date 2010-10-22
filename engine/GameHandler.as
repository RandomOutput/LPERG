package engine {
	
	import backend.IRPoint;
	import backend.Gesture;
	import flash.display.BitmapData;
	import utilities.DualLinkedList;
	
	public class GameHandler {
		
		private var time:int;
		private var deltaT:int;
		private var frameNumber:int;
		private var irPoints:Vector.<IRPoint>;
		private var gestures:Vector.<Gesture>;
		private var framebuffer:BitmapData;
		
		private var playerList:DualLinkedList;
		private var enemyList:DualLinkedList;
		private var playerWeaponList:DualLinkedList;
		private var enemyWeaponList:DualLinkedList;
		
		

		public function GameHandler(_framebuffer:BitmapData, _time:int) {
			time = _time;
			framebuffer = _framebuffer;
		}
		
		public function tick(_time:int, _deltaT:int, _frameNumber:int, _irPoints:Vector.<IRPoint>, _gestures:Vector.<Gesture>):void{
			//timekeeping
			time = _time;
			deltaT = _deltaT;
			frameNumber = _frameNumber;
			
			//input
			irPoints = _irPoints;
			gestures = _gestures;
			
			//To-do... collision
			
			//update players
			playerBehavior.updatePlayers(playerList, playerWeaponList, time, irPoints, gestures);
			
			//update enemy
			enemyBehavior.updateEnemies(enemyList, enemyWeaponList, time);
				
			//update bullets
			bulletBehavior.updateBullets(playerWeaponList, deltaT);
			bulletBehavior.updateBullets(enemyWeaponList, deltaT);
			
			//update wave
			waveManager.updateWaves(enemyList, time);
			
			//update connnecting beams
			
			//update fx
			
			//check for end game
			
			//to-do... sound
			
			//graphics
		}

	}
	
}
