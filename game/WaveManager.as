package game {
	import flash.events.Event;
	
	import game.Wave;
	import game.ScriptedTimeline
	import utilities.DualLinkedList;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class WaveManager {
		
		private var dataXml:String;
		private var waveList:Vector.<Wave>;
		
		private var names:Vector.<String>;
		private var startTimes:Vector.<int>;
		private var fps:Vector.<int>;
		
		public function WaveManager() {			
			dataXml = "waves.xml";
			
			waveList = new Vector.<Wave>(0, false);
			
			names = new Vector.<String>(0, false);
			startTimes = new Vector.<int>(0, false);
			fps = new Vector.<int>(0, false);
			
			loadXml();
		}
		
		public function updateWaves(enemyList:DualLinkedList, time:int):void{
			//gets current time, checks lists and makes changes
			
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
			for each(var xmlFile in names) {
				var xmlLoader:URLLoader  = new  URLLoader();
				var xmlData:XML = new XML(); 
			
				xmlLoader.addEventListener(Event.COMPLETE, loadTimelines);
				xmlLoader.load(new URLRequest("../gameData/waves/xml/" + xmlFile)); 
			}
		}
		
		private function loadTimelines(e:Event) {
			var xmlData =  new XML(e.target.data); 
			
			var scriptedTimelines:Vector.<ScriptedTimeline> = new Vector.<ScriptedTimeline>(0,false);
			var enemyList:XMLList = xmlData.enemy;
			
			for each(var enemyElement:XML in enemyList) {
				//trace("new enemy element");
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
				
				//for(var i=0; i<xCoords.length;i++) {
				scriptedTimelines.push(new ScriptedTimeline(startFrame, xCoords, yCoords, types));
				//}
			}
			waveList.push(new Wave(scriptedTimelines, startTimes[waveList.length], fps[waveList.length]));
			//traceData();
		}
		
		private function traceData():void {
			trace("traceData waveListLength: " + waveList.length);
			
			for(var i=0;i<waveList.length;i++){
				for(var j:int=0;j<waveList[i].timelineList.length;j++) {
					var timeline:ScriptedTimeline = waveList[i].timelineList[j];
					trace("Enemy [" + j + "] ----- START");
					trace("Enemy [" + j + "] Start frame: " + timeline.startFrame);
					for(var k:int=0;k<timeline.posX.length;k++) {
						trace("---FRAME[" + k + "]---");
						trace("xPos: " + timeline.posX[k]);
						trace("yPos: " + timeline.posY[k]);
						trace("types: " + timeline.types[k]);
						trace("---END FRAME---");
					}
					trace("----END ENEMY----");
				}
				
				trace("----END WAVE----");
			}
		}
	}
}
