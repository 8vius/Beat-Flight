package
{
	import org.flixel.*;
	
	public class EndState extends FlxState
	{
		private var endText:FlxText;
		private var scorePresenterText:FlxText;
		private var scoreText:FlxText;
		private var creditsText:FlxText;

		
		public function EndState()
		{
			FlxG.bgColor = 0xff000000;
			
			endText = new FlxText(FlxG.width / 2 - 225, FlxG.height / 2 - 40, 450, "Your heart gave out");
			endText.size = 32;
			
			scorePresenterText = new FlxText(FlxG.width / 2 - 50, FlxG.height / 2, 100, "You lasted for:");
			scorePresenterText.size = 8;
			
			scoreText = new FlxText(FlxG.width /2 - 40, FlxG.height / 2 + 20, 80, (FlxG.score - 3).toString() + " seconds");
			scoreText.size = 8;
			
			creditsText = new FlxText(FlxG.width / 2 - 200, FlxG.height / 2 + 60, 400, "Programming: @8vius - Art: @weloveui - Design: @8vius | @JETeran | @Klind");
			creditsText.size = 8;
			creditsText.color = 0x00FFFF;
						
			add(endText);
			add(scorePresenterText);
			add(scoreText);
			add(creditsText);
		}
	}
}