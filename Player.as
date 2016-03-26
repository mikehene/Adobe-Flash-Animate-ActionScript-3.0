package  {
	
	import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
 
    public class Player extends MovieClip
    {
        public var stageRef:Stage; //create an instance variable for the stage reference
		public var key:KeyObject; //add this instance variable
		
		public var leftPressed:Boolean = false; //keeps track of whether the left arrow key is pressed
        public var rightPressed:Boolean = false; //same, but for right key pressed
        public var upPressed:Boolean = false; //...up key pressed
        public var downPressed:Boolean = false; //...down key pressed
		
		public var speed:Number = 6; //add this Number variable
 
        public function Player(stageRef:Stage, X:int, Y:int):void //modify the constructor
        {
            this.stageRef = stageRef; //assign the parameter to this instance's stageRef variable
            this.x = X;
            this.y = Y;
			
			key = new KeyObject(stageRef); //instantiate "key" by passing it a reference to the stage
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true); //add the EventListener
		}
	 
			public function loop(e:Event):void //create this (currently empty) function
			{
				checkKeypresses(); //call "checkKeypresses()" every frame
				
				if(leftPressed){
					x -= speed; // move to the left if leftPressed is true
				} 
				else if(rightPressed){
					x += speed; // move to the right if rightPressed is true
				}
				
 
				if(upPressed){ // move up if upPressed is true
					y -= speed;
					
				} else if(downPressed){
					y += speed; // move down if downPressed is true
				}
				
				if(x > stageRef.stageWidth || x < 0){ // If the player goes out of the right hand side of the stage
					// then we reset them back to the left hand side AND we stop the player leaving the stage from the left
					x=0;
				}
				if(y > stageRef.stageHeight){ // Set a barrier on the top so that the player can't leave the top of the stage
					y= stageRef.stageHeight;
				}
				if(y < 0){ // Set a barrier on the bottom so that the player can't leave the bottom of the stage
					y=0;
				}
			}
			
			public function checkKeypresses():void
        {
            // Use http://www.dakmm.com/?p=272 as a reference to get the keyCode numbers for each key
            if(key.isDown(37) || key.isDown(65)){ // if left arrow or A is pressed
                leftPressed = true;
            } else {
                leftPressed = false;
            }
 
            if(key.isDown(38) || key.isDown(87)){ // if up arrow or W is pressed
                upPressed = true;
            } else {
                upPressed = false;
            }
 
            if(key.isDown(39) || key.isDown(68)){ //if right arrow or D is pressed
                rightPressed = true;
            } else {
                rightPressed = false;
            }
 
            if(key.isDown(40) || key.isDown(83)){ //if down arrow or S is pressed
                downPressed = true;
            } else {
                downPressed = false;
            }
        }
    }
}