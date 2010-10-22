package game {
	import flash.events.Event;
	
	import game.Wave;
	import game.ScriptedTimeline
	import utilities.DualLinkedList;
	
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
		
		private function createWaves(names:Vector.<String>, startTimes:Vector.<int>, fps:Vector.<int>) {
			//for each xml wave file, populate these variables, create a new wave, and put the wave to a list.
			//waveIndex is the number of the wave
			for each(xmlFile in names) {
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
			
			for each(enemyElement:XML in enemyList) {
				
				var xList:XMLList = enemyElement.xloc;
				var yList:XMLList = enemyElement.yloc;
				var tList:XMLList = enemyElement.types;
				
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
				
				for(var i=0; i<xCoords.length;i++) {
					scriptedTimelines.push(new ScriptedTimeline(xCoords, yCoords, types));
				}
			}
			
			waveList.push(new Wave(scriptedTimelines, startTimes[waveList.length], fps[waveList.length]));
		}
	}
}
