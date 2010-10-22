package game {
	
	public class Wave {
		
		public var enemyList:Vector.<ScriptedEnemy>;
		public var msStartTime:int;
		public var msEndTime:int;
		public var msPerSample:Number;

		public function Wave(_enemyList:Vector.<ScriptedEnemy>, _msStartTime:int, _fps:int){
			enemyList = _enemyList;
			msStartTime = _msStartTime;
			msPerSample = 1000/_fps;
			msEndTime = _msStartTime + msPerSample * enemyList[0].scriptedTimeline.posX.length;
		}
	}
}
