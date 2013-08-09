package
{
	import flash.utils.getTimer;
	
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		private var titleText:FlxText;
		private var startText:FlxText;		
		
		private var beatRate:Number = 1000;
		private var lastBeat:Number = 0;
		override public function create():void {
			FlxG.bgColor = 0xff000000;

			titleText = new FlxText(FlxG.width / 2 - 125, FlxG.height / 2 - 40, 250, "Beat Flight");
			titleText.size = 32;
			
			startText = new FlxText(FlxG.width / 2 - 70, FlxG.height / 2 + 40, 140, "Press X + C to start");
			startText.size = 8;
			
			add(titleText);
			add(startText);
		}
		
		override public function update():void {
			
			if (getTimer() > lastBeat + beatRate) {
				lastBeat = getTimer();
				titleText.size = 16;
			}
			
			if (getTimer() > lastBeat + 200) {
				titleText.size = 32;
			}
			
			if (FlxG.keys.X && FlxG.keys.C)
				FlxG.switchState(new PlayState());
		}
	}
}