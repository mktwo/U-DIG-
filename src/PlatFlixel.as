package  
{
	/**
	 * ...
	 * @author mktwo
	 */
	
	 import org.flixel.*;
	 [SWF(width = "640", height = "480", backgroundColor = "#000000")]
	 
	public class PlatFlixel extends FlxGame
	{
		public function PlatFlixel() 
		{
			super(320, 240, PlayState, 2, 120, 60, false);
		}
	}

}