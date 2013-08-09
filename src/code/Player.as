package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/player.png')] private var playerPNG:Class;
		[Embed(source = '../assets/boost.png')] private var boosterPNG:Class;


		private var xSpeed:uint = 0;
		private var ySpeed:uint = 200;
		
		public var boostFlame:FlxSprite;
		
		public function Player()
		{
			super(FlxG.width / 2 - 350, FlxG.height / 2);
			loadGraphic(playerPNG, true, false, 12, 17, true);
			solid = true;
			
			width = 12;
			height = 17;
			
			boostFlame = new FlxSprite(x - 12, y + 6);
			boostFlame.loadGraphic(boosterPNG, true, false, 12, 5, true);
			boostFlame.width = 12;
			boostFlame.height = 5;
			
			boostFlame.addAnimation("boost", [1, 2, 0], 30);
			
			addAnimation("up", [1], 1);
			addAnimation("down", [2], 1);
			addAnimation("idle", [0], 1);
		}
		
		override public function update():void {
			super.update();
			
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.keys.UP && y > 0) {
				velocity.y -= ySpeed;
				play("up");
			} else if (FlxG.keys.DOWN && y < 135) {
				velocity.y += ySpeed;
				play("down");
			} else {
				play("idle")
			}
			
			boostFlame.play("boost");
			boostFlame.x = x - boostFlame.width;
			boostFlame.y = y + 6;
		}
		
		override public function kill():void {
			if (!alive)
				return
			super.kill();
		}
	}
}