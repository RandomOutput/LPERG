package engine {
	
	import backend.IRPoint;
	import backend.Gesture;
	import flash.display.BitmapData;
	import utilities.DualLinkedList;
	import game.WaveManager;
	import game.PlayerBehavior;
	import game.BulletBehavior;
	import game.ScriptedEnemy;
	import game.ScriptedEnemyBehavior;
	
	public class GameHandler {
		
		private var time:int;
		private var deltaT:int;
		private var frameNumber:int;
		private var irPoints:Vector.<IRPoint>;
		private var gestures:Vector.<Gesture>;
		private var framebuffer:BitmapData;
		
		private var playerList:DualLinkedList;
		//private var enemyList:DualLinkedList;
		private var scriptedEnemyList:DualLinkedList;
		private var playerWeaponList:DualLinkedList;
		private var enemyWeaponList:DualLinkedList;
		
		private var waveManager:WaveManager;
		
		private var playerBehavior:PlayerBehavior;
		private var bulletBehavior:BulletBehavior;
		private var scriptedEnemyBehavior:ScriptedEnemyBehavior;
		
		

		public function GameHandler(_framebuffer:BitmapData, _time:int) {
			time = _time;
			framebuffer = _framebuffer;
			waveManager = new WaveManager();
			
			playerList = new DualLinkedList();
			scriptedEnemyList = new DualLinkedList();
			playerWeaponList = new DualLinkedList();
			
			playerBehavior = new PlayerBehavior();
			playerBehavior.spawnPlayers(playerList,4,time);
			
			bulletBehavior = new BulletBehavior();
			scriptedEnemyBehavior = new ScriptedEnemyBehavior();
			
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
			scriptedEnemyBehavior.updateEnemies(scriptedEnemyList, enemyWeaponList, time);
				
			//update bullets
			bulletBehavior.updateBullets(playerWeaponList, deltaT);
			//bulletBehavior.updateBullets(enemyWeaponList, deltaT);
			
			//update wave
			waveManager.updateWaves(scriptedEnemyList, time);
			//update connnecting beams
			
			//update fx
			
			//check for end game
			
			//to-do... sound
			
			//graphics
		}

	}
	
}
