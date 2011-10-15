package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author mktwo
	 */
	public class CraftContainer extends FlxObject
	{
		
		public var isProper:Boolean;
		public var array:Array;
		public var owner:CraftMenu;
		
		public function CraftContainer(menu:CraftMenu):void
		{
			owner = menu;
			isProper = false;
			array = owner.craftArray;
		}
		
		public override function update():void
		{
			checkForProper();
			super.update();
		}
		
		public function checkForProper():void
		{
			var B0:DropTarget = array[0]; //upleft
			var B1:DropTarget = array[1]; //up
			var B2:DropTarget = array[2]; //upright
			var B3:DropTarget = array[3]; //centerleft
			var B4:DropTarget = array[4]; //center
			var B5:DropTarget = array[5]; //centerright
			var B6:DropTarget = array[6]; //downleft
			var B7:DropTarget = array[7]; //down
			var B8:DropTarget = array[8]; //downright
			
			if (B0.hasSomething && B1.hasSomething && B2.hasSomething && !B3.hasSomething && B4.hasSomething && !B5.hasSomething && !B6.hasSomething && B7.hasSomething && !B8.hasSomething)
			{
				isProper = true;
			} else {
				isProper = false;
			}
		}
		

	}

}