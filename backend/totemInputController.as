﻿/*******

File: LPERG Backend IR Input Controller
Author: Daniel Plemmons (see LPERG site for contact information)

Description:
Main Controller and Interface for all IR Input.
 
Features:
	- Take in TUIO data from Bridge
	- Sanitize TUIO data for front-end constumption
	- Provide interface for front-end to access totem data
	- Track gestures [incomplete]
	- Dispatch gesture events to front-end [incomplete]
	
*******/


package backend {
	
	//needed for use of the Point object
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	
	import org.tuio.*;
	import org.tuio.TuioEvent;
	import org.tuio.connectors.*;
	import org.tuio.osc.*;
	import backend.IRPoint;
	
	public class totemInputController extends MovieClip{
		
		//If DUMMY_MODE is true, the controller will return only static testing data.
		private const DUMMY_MODE:Boolean = true;
		
		private var totems:Array = new Array(new lpergTotem(), new lpergTotem(), new lpergTotem(), new lpergTotem());
		
		//tuio controller vars
		private var tuio:TuioClient;
		private var tuioMngr:TuioManager;


		public function totemInputController() {
			//check to see if the stage is active.  If not, wait till the stage is active
			if (stage) { init(); }
			else { addEventListener(Event.ADDED_TO_STAGE, init); }
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/**
			 * set up the connection to the TUIO data bridge.  
			 * In this case we're using wiimoteWhiteboard which
			 * connects via a UDP connection.  Documentation can
			 * be found in the TUIO Flash Blog Documentation files.
			**/
			
			this.tuio = new TuioClient(new UDPConnector());
			
			//TUIO manager will watch for all incoming TUIO data
			this.tuioMngr = TuioManager.init(stage, this.tuio);
			
			//listeners to track for new, upadates, and removed TUIO data points.
			this.tuioMngr.addEventListener(TuioEvent.ADD, tuioAddHandler);
			this.tuioMngr.addEventListener(TuioEvent.UPDATE, tuioUpdateHandler);
			this.tuioMngr.addEventListener(TuioEvent.REMOVE, tuioRemoveHandler);
			
			//Listening to track for gestures and patterns in totems
			this.addEventListener(Event.ENTER_FRAME, gestureTracking);
		}
		
		//accessor for totem data
		public function totemData():Vector.<IRPoint> {
			
			var returnVector:Vector.<IRPoint> = new Vector.<IRPoint>(0,false);

			//check for dummy mode, if so input dummy data
			if(DUMMY_MODE) {
				//dummy locations
				returnVector.push(new IRPoint(20, 40));
				returnVector.push(new IRPoint(80, 20));
				returnVector.push(new IRPoint(120, 140));
				returnVector.push(new IRPoint(300, 400));
			}
			
			return returnVector;
		}
		
		//accessor for totem data
		public function gestureData():Vector.<Gesture> {
			var returnVector:Vector.<Gesture> = new Vector.<Gesture>(0,false);

			//check for dummy mode, if so input dummy data
			//if(DUMMY_MODE) {
			//}
			
			return returnVector;
		}
		
		/** Tuio Event Respone Functions **/
		
		private function tuioAddHandler(e:TuioEvent) { //solve for a new TUIO point
			//trace("Add TUIO Point [tuioInputController.as -> tuioAddHandler()]");
			
			var inactiveTotems:Array = new Array();
			
			var tuioPoint:Point = new Point(e.tuioContainer.x*stage.stageWidth, e.tuioContainer.y*stage.stageHeight); //get the x and y from the TuioEvent and add them to a point
			
			//current closest inactive totem to the new point and the associated totem
			var shortestDist:Number = -1;
			var closestTotem:lpergTotem = null;
			
			/**
			 * check for any inactive totems
			**/
			for(var i:int = 0; i < totems.length; i++) {
				if(totems[i].isActive() == false) { inactiveTotems.push(totems[i]);}
			}
			
			/**
			 * if there are no non-active totems we have an extra point and an error
			**/
			if(inactiveTotems.length == 0) {
				trace("ERROR: Extra Point [totemInput.as -> tuioAddHandler()]");
				return; //end function execution.  There is nothing to do with the new totem.
			}
			
			/**
			 * figure out which totem to give the controller to
			**/
			for(var j:int = 0; j < inactiveTotems.length; j++) {
				if( (closestTotem == null) || ( twoPointDist( tuioPoint.x, tuioPoint.y, inactiveTotems[j].getLoc().x, inactiveTotems[j].getLoc().y ) < shortestDist ) ) { //if this is the first check or if the distance to this totem is shortest yet.
					//set a new closestTotem and shortestDist
					closestTotem = inactiveTotems[j];
					shortestDist = twoPointDist( tuioPoint.x, tuioPoint.y, inactiveTotems[j].getLoc().x, inactiveTotems[j].getLoc().y );
				}
			}
			
			/**
			 * set the new totem data
			**/
		
			closestTotem.setController(e.tuioContainer.sessionID.toString()); //assign the new control point to the closest free totem
			closestTotem.setLoc(tuioPoint.x, tuioPoint.y, true); //set the new location.  IGNORING DELTA.
		}
		
		private function tuioUpdateHandler(e:TuioEvent) { // solve for an updated tuio point
			//trace("Update TUIO Point [tuioInputController.as -> tuioUpdateHandler()]");
			var tuioPoint:Point = new Point(e.tuioContainer.x*stage.stageWidth, e.tuioContainer.y*stage.stageHeight); //get the x and y from the TuioEvent and add them to a point
			tuioToTotem(e).setLoc(tuioPoint.x, tuioPoint.y); //update that point
		}
		
		private function tuioRemoveHandler(e:TuioEvent) {
			//trace("Remove TUIO Point [tuioInputController.as -> tuioRemoveHandler()]");
			
			tuioToTotem(e).deactivate();
		}
		
		private function tuioToTotem(e:TuioEvent):lpergTotem {
			var hugeSuccess:Boolean = false;
			
			for(var i:int = 0; i < totems.length; i++) {
				if(totems[i].getController() == e.tuioContainer.sessionID.toString()) { //if the current totem has the updating point as its controllerID
					
					/*
					at some point I'm probably going to need to write a check in here
					to make sure that an ID switch has not happened.  I just need to know
					the maximum px/second that a player is going to be moving.  If an action happens
					above this speed threshold i'll know an ID switch occured and can 
					account for it by switching the controllingIDs for the totems.
					*/
					hugeSuccess = true; //I'm making a note here huge success.
					return totems[i];
				}
			}		
			
			if(!hugeSuccess) {
				trace("ERROR: Active TUIO point updating with no associated totem [totemInput.as -> tuioToTotem()]"); //tuio point is a lie
				return null;
			}
			else{
				trace("ERROR: No way in hell should this line of code run [totemInput.as -> tuioToTotem()]"); //1011011010120010110...I think I saw a 2
				return null;
			}
			
		}
		
		/** Gesture Tracking **/
		private function gestureTracking(e:Event):void {
			/** TWO TOTEM ORIENTATION CHECKS **/
			
			/** 
			 * It is important to remember that the primary play orientation 
			 * of the game is 90 degrees counter-clockwise from the standard flash grid.  
			 * 
			 * X = Up and Down
			 * Y = Side to Side
			 * 
			 *    ------------------------------
			 * p |  +x-->						|
			 * l |+y							|
			 * y ||		Primary play dir.  		|
			 * a |V		---------------->		|
			 * e |			(verticle)			|
			 * r |								|
			 * s |								|
			 *    ------------------------------
			 *  
			 * When referencing Horizontal and Verticle, we assume the play space
			 * here, not the Flash grid.  I know this is a pain but thats how it is
			 * for now.
			 * 
			 * -Daniel
			**/
			var orientationGestureEvent:GestureEvent;
			
			for(var i:int = 0; i<totems.length; i++) { //totem to check
				for(var j:int = 0; j < totems.length; j++) { //totem to check against
					
					if(i != j) { //making sure that the checking totem and the checked totem are not the same
						
						/** HORIZONTAL ORIENTATION CHECK **/
						if(Math.abs(totems[i].getLoc().x - totems[j].getLoc().x) <= (totems[i].getRadius() / 2) && twoPointDist(totems[i].getLoc().x, totems[i].getLoc().y, totems[j].getLoc().x, totems[j].getLoc().y) < (2*totems[i].getRadius() + 15)) {
							//set the event type to dispatch
							orientationGestureEvent = new GestureEvent("02_horizontalALignment");
							
							//set the message to display
							orientationGestureEvent.customMessage = "02_horizontalALignment dispatched";
							
							//dispatch the event
							dispatchEvent(orientationGestureEvent);
						}
						/** END HORIZONTAL ORIENTATION CHECK **/
						
						/** VERTICLE ORIENTATION CHECK **/
						if(Math.abs(totems[i].getLoc().y - totems[j].getLoc().y) <= (totems[i].getRadius() / 2) && twoPointDist(totems[i].getLoc().x, totems[i].getLoc().y, totems[j].getLoc().x, totems[j].getLoc().y) < (2*totems[i].getRadius() + 15)) {
							//set the event type to dispatch
							orientationGestureEvent = new GestureEvent("02_horizontalALignment");
							
							//set the message to display
							orientationGestureEvent.customMessage = "02_horizontalALignment dispatched";
							
							//dispatch the event
							dispatchEvent(orientationGestureEvent);
						}
						/** END VERTICLE ORIENTATION CHECK **/
					}
					
				}
			}
			/** END TWO TOTEM ORIENTATION CHECKS **/
		}
		
		/** Relative Location and Angle Finding **/
		private function twoPointDist(x1:Number, y1:Number, x2:Number, y2:Number) { //solve for the distance between two points
			return Math.sqrt(((x1-x2) * (x1-x2)) + ((y1 - y2) * (y1 - y2)));
		}
	}
}
