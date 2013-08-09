package
{
	import org.flixel.*;
	
	public class RateChanger extends FlxSprite
	{
		[Embed(source="../assets/ratechanger.png")] private var imgChanger:Class;

		public var changerType:String;
		
		public function RateChanger()
		{
			super();
			loadGraphic(imgChanger, true);
			width = 8;
			height = 8;
			
			addAnimation("plus", [1]);
			addAnimation("minus", [2]);
		}
		
		override public function update():void
		{
			if(!alive)
			{
				if(finished)
					exists = false;
			}
			else if(touching)
				kill();
		}
		
		override public function kill():void
		{
			if(!alive)
				return;
			velocity.y = 0;
			//if(onScreen())
			//	FlxG.play(SndHit);
			alive = false;
			solid = false;
			//play("poof");
		}
		
		public function spawn(location:FlxPoint, speed:Number, type:String):void {
			solid = true;
			changerType = type;
			super.reset(location.x-width/2, location.y-height/2);

			play(type);
			velocity.x = -speed;
		}
		
		public function updateSpeed(speed:Number):void {
			velocity.x = -speed;
		}
	}
} 