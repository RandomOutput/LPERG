package engine {
	
	import flash.utils.getTimer;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	//IR Backend Package
	import backend.totemInputController;
	import backend.Gesture;
	import backend.IRPoint;
	import engine.GameHandler;
	
	public class Main extends Sprite{

		private const STAGE_WIDTH:int = 1280;
		private const STAGE_HEIGHT:int = 800;
		private var time:int;
		private var deltaT:int;
		private var frameNumber:int;
		private var framebuffer:BitmapData;
		private var frameDisplay:Bitmap;
		private var irStream:totemInputController;
		private var irPoints:Vector.<IRPoint>;
		private var gestures:Vector.<Gesture>;
		private var gameHandler:GameHandler;

		public function Main(){
			//time
			time = 0;
			frameNumber = 0;
			
			//ir data
			irStream = new totemInputController();
			stage.addChild(irStream);
			irPoints = new Vector.<IRPoint>(0,false);
			gestures = new Vector.<Gesture>(0,false);
			
			//render surface
			framebuffer = new BitmapData(STAGE_WIDTH,STAGE_HEIGHT,false,0);
			frameDisplay = new Bitmap(framebuffer,"auto",false);
			this.addChild(frameDisplay);
			
			//game logic engine
			gameHandler = new GameHandler(framebuffer, time);
			
			this.addEventListener(Event.ENTER_FRAME,tick);
		}
		
		public function tick(e:Event):void{
			var currTime = getTimer();
			
			//update time delta
			deltaT = currTime - time;
			time = currTime;
			
			//update frame number
			frameNumber++;
			
			//update ir data
			irPoints = irStream.totemData();
			gestures = irStream.gestureData();
			
			//update game
			gameHandler.tick(time, deltaT, frameNumber, irPoints, gestures);
		}
	}
}
