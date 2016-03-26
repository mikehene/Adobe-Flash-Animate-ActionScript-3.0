package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class Main extends MovieClip {
		public var player: Player;
		public var bulletList: Array = new Array(); //new array for the bullets
		public var enemies: Array = new Array(); // new array for enemies
		public var enemyTimer: Timer = new Timer(1700); // add timer for enemies (1.7secs)

		public function Main(): void {
			player = new Player(stage, 0, 240);
			stage.addChild(player);

			stage.addEventListener(MouseEvent.CLICK, shootBullet, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, enterShoot);
			stage.addEventListener(Event.ENTER_FRAME, loop, false, 0, true); //add an EventListener for the loop

			enemyTimer.addEventListener(TimerEvent.TIMER, addAnEnemy); // add an EventListener for enemies 
			enemyTimer.start(); // start the timer for set up new enemies to be added to the stage
		}

		function enterShoot(keyEvent: KeyboardEvent): void { // Add function to handle shooting bullet using enter button on keyboard

			if (keyEvent.keyCode == 13) {
				keyboardShootBullet();
			}

		}

		function addAnEnemy(event: TimerEvent): void {

			var badguys: Enemy = new Enemy(); // create a new enemy
			badguys.x = stage.stageWidth + 30; // place enemy at the end of the stage 
			badguys.y = Math.floor(Math.random() * (470 - 20) + 20); // create a random co-ordinate for the enemy to enter the screen 
			// - 470 being the lowest coordinate and 20 the highest
			addChild(badguys); // add enemy to stage
			enemies.push(badguys); // push the badguy into the array
		}

		public function loop(e: Event): void //create the loop function
		{
			if (bulletList.length > 0) //if there are any bullets in the bullet list
			{
				for (var i: int = bulletList.length - 1; i >= 0; i--) //for each one
				{
					bulletList[i].loop(); //call its loop() function
				}
			}
			moveBadGuys(); // call the move enemy function in the loop to continuously add enemies to the stage
			kill(); // continuously check if a bullet has touched an enemy
		}



		public function keyboardShootBullet(): void // Function to shoot bullet upon pressing enter on the keyboard
		{
			var bullet: Bullet = new Bullet(stage, player.x, player.y, player.rotation);
			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true); //triggers the "bulletRemoved()" function whenever this bullet is removed from the stage
			bulletList.push(bullet); //add this bullet to the bulletList array
			stage.addChild(bullet);
		}

		public function shootBullet(e: MouseEvent): void // Function to shoot bullet upon pressing left key on mouse
		{
			var bullet: Bullet = new Bullet(stage, player.x, player.y, player.rotation);
			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true); //triggers the "bulletRemoved()" function whenever this bullet is removed from the stage
			bulletList.push(bullet); //add this bullet to the bulletList array
			stage.addChild(bullet);
		}

		public function bulletRemoved(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved); //remove the event listener so we don't get any errors
			bulletList.splice(bulletList.indexOf(e.currentTarget), 1); //remove this bullet from the bulletList array
		}

		public function moveBadGuys(): void {

			for (var move: int = 0; move < enemies.length; move++) {

				enemies[move].x -= 3; // move enemy 3 pixels to the left for each frame


				if (enemies[move].x < 0) { // if enemies moved off screen

					removeChild(enemies[move]); // call function to remove enemy element from array
					enemies[move] = null; // sets the variable to null ie deleted
					enemies.splice(move, 1); // removes the enemy from the array

				}

			}

		}

		public function kill(): void {

			for (var bul = bulletList.length - 1; bul >= 0; bul--) { // nested for look to check each bullet against each enemy on the stage. Starting at end of array list and stopping when reaching the beggining
				for (var bg = enemies.length - 1; bg >= 0; bg--) {

					if (bulletList[bul].hitTestObject(enemies[bg])) { // preset function to check if bullet touches an enemy

						this.parent.removeChild(bulletList[bul]); // if the bullet touches enemy remove bullet - Not sure why but when use just removeChild it doesn't work
						removeChild(enemies[bg]); // if the bullet touches enemy remove enemy
						bulletList[bul] = null;
						enemies[bg] = null;
						bulletList.splice(bul, 1); // remove bullet from  bullet array
						enemies.splice(bg, 1); // remove enemy from enemy array
						break; // break out of loop and check next bullet
					}


				}
			}

		}
	}
}