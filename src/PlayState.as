package
{
	/**
	 * ...
	 * @author mktwo
	 **/
	
	import org.flixel.*;
	
	
	
	public class PlayState extends FlxState
	{
		[Embed(source = '../content/sprites/guy.png')]private var guy:Class;
		[Embed(source = '../content/sprites/door.png')]private var door:Class;
		[Embed(source = '../content/sprites/coin.png')]private var coinImg:Class;
		[Embed(source = '../content/sprites/mouse_pick.png')]private var mouseGfx:Class;
		[Embed(source = '../content/tiles/tiles.png')]private var tileGfx:Class;
		[Embed(source = '../content/bg/dirt.png')]private var bgImg:Class;
		public var level1:FlxTilemap;
		public var exit:FlxSprite;
		public var coins:FlxGroup;
		public var player:FlxSprite;
		public var enemy1:Enemy;
		public var score:FlxText;
		public var status:FlxText;
		public var toast:Toast;
		public var logo:FlxText;
		public var tileWidth:uint;
		public var tileHeight:uint;
		public var tileAtMouseX:uint;
		public var tileAtMouseY:uint;
		private var background:Backdrop;
		
		override public function create():void
		{
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xff756341;
			background = new Backdrop(0,0,bgImg,0);
			add(background);
			
			//Design your platformer level with 1s and 0s (at 40x30 to fill 320x240 screen)
				var data1:Array = new Array(
								1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
								1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1,
								1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
								1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1,
								1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
								1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1,
								1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1,
								1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1,
								1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1,
								1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1 );
		
								
			//Create a new tilemap using our level data
			level1 = new FlxTilemap();
			level1.loadMap(FlxTilemap.arrayToCSV(data1, 40), tileGfx, 8, 8, FlxTilemap.AUTO);
	
			add(level1);
			
			tileWidth = level1.width / level1.widthInTiles;
			tileHeight = level1.height / level1.heightInTiles;
			
			//Create the level exit, a dark gray box that is hidden at first
			exit = new FlxSprite(35 * 8 + 1, 25 * 8);
			exit.loadGraphic(door, false, false, 14, 16, false);
			exit.exists = false;
			add(exit);
			
			//Create coins to collect (see createCoin() function below for more info)
			coins = new FlxGroup();
			//Top left coins
			createCoin(18, 4);
			createCoin(12, 4);
			createCoin(9, 4);
			createCoin(8, 11);
			createCoin(1, 7);
			createCoin(3, 4);
			createCoin(5, 2);
			createCoin(15, 11);
			createCoin(16, 11);
			
			//Bottom left coins
			createCoin(3, 16);
			createCoin(4, 16);
			createCoin(1, 23);
			createCoin(2, 23);
			createCoin(3, 23);
			createCoin(4, 23);
			createCoin(5, 23);
			createCoin(12, 26);
			createCoin(13, 26);
			createCoin(17, 20);
			createCoin(18, 20);
			
			//Top right coins
			createCoin(21, 4);
			createCoin(26, 2);
			createCoin(29, 2);
			createCoin(31, 5);
			createCoin(34, 5);
			createCoin(33, 11);
			createCoin(31, 11);
			createCoin(29, 11);
			createCoin(27, 11);
			createCoin(25, 11);
			createCoin(36, 14);
			
			//Bottom right coins
			createCoin(38, 17);
			createCoin(33, 17);
			createCoin(28, 19);
			createCoin(25, 20);
			createCoin(18, 26);
			createCoin(22, 26);
			createCoin(26, 26);
			createCoin(30, 26);
			
			add(coins);
			
			//Create player
			player = new FlxSprite(FlxG.width / 2 - 5);
			player.loadGraphic(guy, true, true, 8, 12, false);
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 200;
			player.acceleration.y = 200;
			player.drag.x = player.maxVelocity.x * 4;
			player.addAnimation("idle", [0, 1, 2, 3], 10, true);
			player.addAnimation("walk", [4, 5, 6, 7], 10, true);
			player.addAnimation("jump", [8]);
			player.play("idle");
			player.facing = 1;
			add(player);
			
			enemy1 = new Enemy(38, 8);
			add(enemy1);
			
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			FlxG.mouse.show(mouseGfx);
						
			score = new FlxText(2, 2, 80);
			score.shadow = 0xffaa0000;
			score.text = "SCORE: " + (coins.countDead() * 100);
			score.scrollFactor.x = score.scrollFactor.y = 0;
			add(score);
			
			status = new FlxText(FlxG.width - 160 - 2, 2, 160);
			status.shadow = 0xffaa0000;
			status.alignment = "right";
			switch (FlxG.score)
			{
				case 0: 
					status.text = "Collect coins.";
					break;
				case 1: 
					status.text = "Ur ded!";
					break;
			}
			status.scrollFactor.x = status.scrollFactor.y = 0;
			add(status);
			
			logo = new FlxText(0, 96, 320, "U DIG?");
			logo.alignment = "center";
			logo.color = 0xffffcc33;
			logo.shadow = 0xffffaa22;
			logo.size = 48;
			logo.scrollFactor.x = logo.scrollFactor.y = 0;
			add(logo);
		}
		
		//creates a new coin located on the specified tile
		public function createCoin(X:uint, Y:uint):void
		{
			var coin:FlxSprite = new FlxSprite(X * 8 + 3, Y * 8 + 2);
			coin.loadGraphic(coinImg, true, false, 4, 4, false);
			coin.addAnimation("rotate", [0,1,2,3], 10, true);
			coin.play("rotate");
			coins.add(coin);
		}
		
		override public function update():void
		{	
			//Player movement and controls
			player.acceleration.x = 0;
			if (FlxG.keys.A) 
				player.acceleration.x = -player.maxVelocity.x * 4;
			if (FlxG.keys.D) 
				player.acceleration.x = player.maxVelocity.x * 4;
			if (FlxG.keys.justPressed("SPACE") && player.isTouching(FlxObject.FLOOR))
				player.velocity.y = -player.maxVelocity.y / 2;
			if (FlxG.keys.justPressed("G"))
				FlxG.timeScale = 0.35;
			if (FlxG.keys.justReleased("G"))
				FlxG.timeScale = 1;
				
			if (FlxG.mouse.pressed())
			{
				// FlxTilemaps can be manually edited at runtime as well.
				// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
				// If auto map is on, the map will automatically update all surrounding tiles.
				level1.setTile(FlxG.mouse.x / tileWidth, FlxG.mouse.y / tileHeight, FlxG.keys.CONTROL?1:0, true);
			}
			
			//Updates all the objects appropriately
			super.update();
			
			//Check if player collected a coin or coins this frame
			FlxG.overlap(coins, player, getCoin);
			
			//Check to see if the player touched the exit door this frame
			FlxG.overlap(exit, player, win);
			
			//Finally, bump the player up against the level
			FlxG.collide(level1, player);
			
			//Check for player lose conditions
			if (player.y >= FlxG.height-20)
			{
				FlxG.score = 1; //sets status.text to "Aww, you died!"
				FlxG.resetState();
			}
			
			if(logo.size <= 80)
				logo.size += 1;
			
			logo.alpha -= 0.003;
			
			if (player.velocity.x > 0)
			{
				player.facing = 0;
				player.play("walk");
			}
			if (player.velocity.x < 0)
			{
				player.facing = 1;
				player.play("walk");
			}
			if (player.velocity.x == 0)
			{
				player.play("idle");
			}
			if (player.velocity.y != 0)
			{
				player.play("jump");
			}
			
		}
		
		//Called whenever the player touches a coin
		public function getCoin(Coin:FlxSprite, Player:FlxSprite):void
		{
			Coin.kill();
			toast = new Toast(Player.x - 25, Player.y - 20, 50, "+++!");
			add(toast);

			score.text = "SCORE: " + (coins.countDead() * 100);
			if (coins.countLiving() == 0)
			{
				status.text = "Find the exit.";
				exit.exists = true;
			}
		}
		
		//Called whenever the player touches the exit
		public function win(Exit:FlxSprite, Player:FlxSprite):void
		{
			status.text = "A Winner Is YOU!";
			score.text = "SCORE: 9000+";
			Player.kill();
		}
	}
}

