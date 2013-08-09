package
{
	import org.flixel.*;
	
	public class HeartGame extends FlxGame
	{
		public function HeartGame()
		{
			super(750, 150, MenuState, 2);
			forceDebugger = true;
		}
	}
}