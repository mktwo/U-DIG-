package
{
	import flash.utils.*;
	import flash.xml.*;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author mktwo
	 */
	public class CraftContainer extends FlxObject
	{
		
		[Embed(source = "../content/xml/craftables.xml", mimeType = "application/octet-stream")] private var craftXML:Class;
		[Embed(source='../content/icons/wp_pickaxe_wood.png')] public var wp_pickaxe_wood:Class;
		public var isProper:Boolean;
		public var array:Array;
		public var owner:CraftMenu;
		public var byteArray:ByteArray = new craftXML() as ByteArray;
		public var xml:XML = new XML(byteArray.readUTFBytes(byteArray.length));
		public var dataArray:Array = new Array();
		public var data:String;
		public var img:String;
		public var i:uint = 0;
		public var stopChecking:Boolean = false;
		
		public function CraftContainer(menu:CraftMenu):void
		{
			owner = menu;
			isProper = false;
			array = owner.craftArray;
			
			for each (var item:XML in xml.*)
			{
				if (item.name() == "item")
				{
					data = item.@data;
					dataArray[i] += data;
					img = item.@img;
					//trace(img);
					i += 1;
				}
			}
			
			//trace(dataArray.length);
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
			
			
			//imgC = getDefinitionByName(img) as Class;
			//var foo:ar_pants_wood = new ar_pants_wood();
			
			var craftData:String = "undefined" + B0.hasSomething + " " + B1.hasSomething + " " + B2.hasSomething + " " + B3.hasSomething + " " + B4.hasSomething + " " + B5.hasSomething + " " + B6.hasSomething + " " + B7.hasSomething + " " + B8.hasSomething;
			
			for each (var datStr:String in dataArray)
			{
				if (craftData == datStr)
				{
					isProper = true;
					stopChecking = true;
					owner.result.loadGraphic(wp_pickaxe_wood, false, false);
					owner.result.visible = true;
				}
				else
				{
					if (!stopChecking)
					{
						isProper = false;
						owner.result.visible = false;
					}
				}
			}
			
			stopChecking = false;
		}
	}

}