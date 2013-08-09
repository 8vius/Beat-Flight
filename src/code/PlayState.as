package
{
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = '../assets/starfield.png')] private var starfield:Class;
		
		private var background:FlxSprite;
		private var player:Player;
		private var rateChangers:FlxGroup;
		
		private var heartRate:Number;
		private var heartRateText:FlxText;
		private var dropRate:Number = 500;
		private var lastDrop:Number = 0;
		
		private var changerCounter:Number;
		
		private var changerType:String;
		private var changerSpeed:Number;
		private var spawnRate:Number = 1000;
		private var lastSpawn:Number = 0;
		
		private var backgroundSpeed:Number;
		
		private var elapsedTime:Number;
		private var elapsedTimeText:FlxText;
		
		//private var timerText:FlxText;
		//private var spawnText:FlxText;
				
		override public function create():void {
			FlxG.bgColor = 0xffaaaaaa;
			
			if (FlxG.getPlugin(FlxScrollZone) == null)
			{
				FlxG.addPlugin(new FlxScrollZone);
			}
		
			//	Create a sprite from a 320x200 PNG
			background = new FlxSprite(0, 0, starfield);
			
			//	This will scroll the whole image to the left by 2 pixels every frame
			backgroundSpeed = -3;
			FlxScrollZone.add(background, new Rectangle(0, 0, background.width, background.height), backgroundSpeed, 0, true);
			
			player = new Player();
			rateChangers = new FlxGroup();
			
			heartRate = 120;
			heartRateText = new FlxText(0, 130, 160, heartRate.toString() + "BPM");
			
			elapsedTime = 0;
			elapsedTimeText = new FlxText(690, 0, 50, elapsedTime.toString());
			
			//timerText = new FlxText(0, 0, 50, getTimer().toString());
			//spawnText = new FlxText(0, 60, 50, spawnRate.toString());
			
			changerSpeed = 120;
			changerCounter = 0;
			
			add(background);
			add(player);
			add(player.boostFlame);
			add(rateChangers);
			add(heartRateText);
			add(elapsedTimeText);
			//add(timerText);
			//add(spawnText);
		}
		
		override public function update():void {
			super.update();
			
			FlxG.overlap(player, rateChangers, overlapped);
			if (getTimer() > lastSpawn + spawnRate) {
				lastSpawn = getTimer();
				
				if (int(Math.random() * 100) < 30)
					changerType = "minus";
				else 
					changerType = "plus";
						
				(rateChangers.recycle(RateChanger) as RateChanger).spawn(new FlxPoint(720, int(Math.random() * FlxG.height)), changerSpeed, changerType);
			}
			
			changerCounter++;
			if (changerCounter % 500 == 0) {
				backgroundSpeed--;
				changerSpeed += 60;
				spawnRate -= 100;
				if (spawnRate == 0)
					spawnRate = 100;
				FlxScrollZone.updateX(background, backgroundSpeed);
				
				for each (var rateChanger:RateChanger in rateChangers.members) {
					if (rateChanger.alive)
						rateChanger.updateSpeed(changerSpeed);
				}
			} 
			
			elapsedTime += FlxG.elapsed;
			elapsedTimeText.text = (Math.round(elapsedTime * 10) / 10).toString();
			
			//timerText.text = getTimer().toString();
			//spawnText.text = spawnRate.toString();
			
			if (getTimer() > lastDrop + dropRate) {
				lastDrop = getTimer();
				heartRate--;
				heartRateText.text = "0 |---" + heartRate.toString() + "BPM---| 200";
			}
			
			if (heartRate <= 0 || heartRate >= 200) {				
				FlxG.fade(0xff000000, 3,onEnd);
			}
			
			if (heartRate < 0)
				heartRate = 0;
			if (heartRate > 200)
				heartRate = 200;
		}
		
		protected function overlapped(Sprite1:FlxSprite,Sprite2:FlxSprite):void
		{
			if((Sprite2 is RateChanger)) {
				Sprite2.kill();
				if ((Sprite2 as RateChanger).changerType == "plus")
					heartRate += 10;
				else 
					heartRate -= 30;
				
			}
		}
		
		protected function onEnd():void {
			FlxG.score = elapsedTime;
			FlxG.switchState(new EndState());
		}
	}
}