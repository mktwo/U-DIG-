package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author mktwo
	 */
	public class Enemy extends FlxSprite
	{
		
		public function Enemy(X:uint, Y:uint)
		{
			x = X * 8;
			y = Y * 8;
			makeGraphic(8, 8, 0xaaaa2222, false);
			velocity.x = -30;
			facing = FlxObject.LEFT;
		}
		
		public override function update():void
		{
			if (isTouching(FlxObject.FLOOR) == true)
			{
			    if (facing == FlxObject.WALL) {                 
			        velocity.x = 30;
			    } else {
			        velocity.x = -30;
			    }
			}
			
			super.update();
		}

	}
}