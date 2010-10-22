package game {
	import flash.events.Event;
	
	import game.Wave;
	import game.ScriptedTimeline
	import utilities.DualLinkedList;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import utilities.DualNode;
	
	public class WaveManager {
		
		private var framecount:int = 0;
		private var dataXml:String;
		private var waveList:Vector.<Wave>;
		private var activeWaves:Vector.<Wave>;
		
		private var names:Vector.<String>;
		private var startTimes:Vector.<int>;
		private var fps:Vector.<int>;
		
		private var lastWave:Boolean = false;
		private var wavesLoaded:Boolean = false;
		
		public function WaveManager() {			
			dataXml = "waves.xml";
			
			waveList = new Vector.<Wave>(0, false);
			activeWaves = new Vector.<Wave>(0, false);
			
			names = new Vector.<String>(0, false);
			startTimes = new Vector.<int>(0, false);
			fps = new Vector.<int>(0, false);
			
			loadXml();
		}
		
		public function updateWaves(enemyList:DualLinkedList, time:int):void{
			if(wavesLoaded == false){return;}
			for(var i:int=0;i<waveList.length;i++) {
				if(time >= waveList[i].msStartTime) {
					activeWaves.push(waveList.splice(i,1)[0]);
				}
			}
			
			for(var j:int=0;j<activeWaves.length;j++) {
				if(activeWaves[j].enemyList.length > 0) {
					for(var k:int=0;k<activeWaves[j].enemyList.length;k++) {
						activeWaves[j].enemyList[k].msStartTime = time;
						enemyList.push(new DualNode(activeWaves[j].enemyList.splice(k,1)[0]));
					}
				} else {
					activeWaves.splice(j,1);
				}
			}
		}
		
		private function loadXml() {
			var xmlLoader:URLLoader  = new  URLLoader();
			var xmlData:XML = new XML(); 
			
			xmlLoader.addEventListener(Event.COMPLETE, loadData);
 
			xmlLoader.load(new URLRequest("../gameData/waves/" + dataXml)); 
		}
		
		private function loadData(e:Event) {
			
			var xmlData =  new XML(e.target.data); 
			
			//read in wave names
			var nameList:XMLList  = xmlData.wave.waveName; 
			for each  (var  nameElement:XML  in nameList)  {
				names.push(nameElement);
			}
			
			//read in startTimes
			var startTimeList:XMLList  = xmlData.wave.startTime; 
			for each  (var  timeElement:XML  in startTimeList)  {
				startTimes.push(timeElement);
			}
			
			//read in fps's
			var fpsList:XMLList  = xmlData.wave.fps; 
			for each  (var  fpsElement:XML  in fpsList)  {
				fps.push(fpsElement);
			}
			
			createWaves();
		}
		
		private function createWaves() {
			//for each xml wave file, populate these variables, create a new wave, and put the wave to a list.
			//waveIndex is the number of the wave
			for (var i:int=0; i<names.length; i++){
				var xmlFile:String = names[i];
				var xmlLoader:URLLoader  = new  URLLoader();
				var xmlData:XML = new XML(); 
			
				xmlLoader.addEventListener(Event.COMPLETE, loadTimelines);
				xmlLoader.load(new URLRequest("../gameData/waves/xml/" + xmlFile)); 
				
				if(i == names.length - 1) {
					lastWave = true;
				}
			}
		}
		
		private function loadTimelines(e:Event) {
			var xmlData =  new XML(e.target.data); 
			
			var scriptedEnemies:Vector.<ScriptedEnemy> = new Vector.<ScriptedEnemy>(0,false);
			var enemyList:XMLList = xmlData.enemy;
			
			for each(var enemyElement:XML in enemyList) {
				//trace("new enemy element");
				var scriptedTimeline:ScriptedTimeline;
				var startFrame:int = enemyElement.startframe;
				var xList:XMLList = enemyElement.frames.xLoc;
				var yList:XMLList = enemyElement.frames.yLoc;
				var tList:XMLList = enemyElement.frames.types;
				
				var xCoords:Vector.<int> = new Vector.<int>(0, false);
				for each  (var  xElement:XML  in xList)  {
					xCoords.push(xElement);
				}
				
				var yCoords:Vector.<int> = new Vector.<int>(0, false);
				for each  (var  yElement:XML  in yList)  {
					yCoords.push(yElement);
				}
				
				var types:Vector.<int> = new Vector.<int>(0, false);
				for each  (var  tElement:XML  in tList)  {
					types.push(tElement);
				}
				
				scriptedTimeline = new ScriptedTimeline(startFrame, xCoords, yCoords, types, fps[waveList.length]);
				
				//for(var i=0; i<xCoords.length;i++) {
				scriptedEnemies.push(new ScriptedEnemy(xCoords[0], yCoords[0], 100, types[0], 0, 0, 1000, 0, scriptedTimeline));
				//}
			}
			waveList.push(new Wave(scriptedEnemies, startTimes[waveList.length], fps[waveList.length]));
			
			if(lastWave == true) { wavesLoaded = true; }
		}
		
		private function traceData():void {
			trace("traceData waveListLength: " + waveList.length);
			
			for(var i=0;i<waveList.length;i++){
				for(var j:int=0;j<waveList[i].enemyList.length;j++) {
					var enemy:ScriptedEnemy = waveList[i].enemyList[j];
					trace("Enemy [" + j + "] ----- START");
					trace("Enemy [" + j + "] Start frame: " + enemy.scriptedTimeline.startFrame);
					for(var k:int=0;k<enemy.scriptedTimeline.posX.length;k++) {
						trace("---FRAME[" + k + "]---");
						trace("xPos: " + enemy.scriptedTimeline.posX[k]);
						trace("yPos: " + enemy.scriptedTimeline.posY[k]);
						trace("types: " + enemy.scriptedTimeline.types[k]);
						trace("---END FRAME---");
					}
					trace("----END ENEMY----");
				}
				
				trace("----END WAVE----");
			}
		}
	}
}
