package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author mktwo
	 */
	public class Toast extends FlxBasic
	{
		private var toastie:FlxText;
		
		public function Toast(X:uint, Y:uint, Width:uint, Text:String):void
		{
			toastie = new FlxText(X, Y, Width, Text, true);
			toastie.color = 0xffffee33;
			toastie.alpha = 1;
			toastie.alignment = "center";
		}
		
		public override function update():void
		{
			toastie.y -= 0.5;
			toastie.alpha -= 0.1;
			if (toastie.alpha <= 0)
			{
				kill();
			}
		}
		
		public override function draw():void
		{
			toastie.draw();
		}
		
		public override function kill():void 
		{
			super.kill();
			toastie.kill();
		}
	}
}