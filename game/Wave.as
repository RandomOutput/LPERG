package game {
	
	public class Wave {
		
		public var timelineList:Vector.<ScriptedTimeline>;
		public var msStartTime:int;
		public var msEndTime:int;
		public var msPerSample:Number;

		public function Wave(_timelineList:Vector.<ScriptedTimeline>, _msStartTime:int, _fps:int){
			timelineList = _timelineList;
			msStartTime = _msStartTime;
			msPerSample = 1000/_fps;
			msEndTime = _msStartTime + msPerSample * timelineList[0].posX.length;
		}
	}
}
