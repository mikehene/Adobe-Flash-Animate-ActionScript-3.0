package
{
    import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
 
    public class Bullet extends MovieClip
    {
        private var stageRef:Stage; //we'll use this to check if the bullet leaves the screen borders
        private var speed:Number = 10; //speed that the bullet will travel at
        private var xVel:Number = 0; //current x velocity
        private var yVel:Number = 0; //current y velocity
        private var rotationInRadians = 0; //convenient to store our rotation in radians instead of degrees
 
        //our constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing
        public function Bullet(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number):void
        {
            this.stageRef = stageRef;
            this.x = X;
            this.y = Y;
            this.rotation = rotationInDegrees;
            this.rotationInRadians = rotationInDegrees * Math.PI / 180; //convert degrees to radians, for trigonometry
        }
		
		public function loop():void //we don't need to include the "e:Event" because we aren't using an EventListener
		{
			xVel = Math.cos(rotationInRadians) * speed; //uses the cosine to get the xVel from the speed and rotation
			yVel = Math.sin(rotationInRadians) * speed; //uses the sine to get the yVel
		 
			x += xVel; //updates the position horizontally
			y += yVel; //updates the position vertically
		 
			//if the bullet goes off the edge of the screen...
			if(x > stageRef.stageWidth || x < 0 || y > stageRef.stageHeight || y < 0)
			{
				this.parent.removeChild(this); //remove the bullet
			}
		}
    }
}