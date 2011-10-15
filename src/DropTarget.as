package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author mktwo
	 */
	public class DropTarget extends FlxSprite
	{
		public var hasSomething:Boolean = false;
		
		public function DropTarget(X:uint,Y:uint,SimpleGraphic:Class=null):void
		{
			super(X, Y, SimpleGraphic);
		}
		
		public override function update():void
		{
			hasSomething = false;
		}
	}

}