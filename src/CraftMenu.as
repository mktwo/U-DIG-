package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author mktwo
	 */
	public class CraftMenu extends FlxState
	{
		[Embed(source='../content/menus/craftMenu_bg.png')]
		private var bgImg:Class;
		[Embed(source='../content/menus/menu_itemBlock.png')]
		private var blockImg:Class;
		public var open:Boolean = false;
		public var craftBlocks:FlxGroup;
		public var craftArray:Array;
		public var resultBlock:FlxSprite;
		public var invObjects:FlxGroup;
		
		public override function create():void
		{
			var title:FlxText;
			title = new FlxText(12, 20, 128, "Craft!");
			title.setFormat(null, 16, 0xffffff, "left", 0x444444);
			add(title);
			
			var bg:FlxSprite;
			bg = new FlxSprite(10, 40);
			bg.loadGraphic(bgImg,false,false,FlxG.width - 20, FlxG.height - 96,false);
			add(bg);
			
			craftBlocks = new FlxGroup();
			createBlock(72, 64);
			createBlock(105, 64);
			createBlock(138, 64);
			createBlock(72, 97);
			createBlock(105, 97);
			createBlock(138, 97);
			createBlock(72, 130);
			createBlock(105, 130);
			createBlock(138, 130);
			add(craftBlocks);
			
			craftArray = new Array();
						
			resultBlock = new FlxSprite(212, 97, blockImg);
			add(resultBlock);
			
			invObjects = new FlxGroup();
			createInv(invObjects, 72, 155);
			createInv(invObjects, 105, 155);
			createInv(invObjects, 138, 155);
			createInv(invObjects, 171, 155);
			createInv(invObjects, 204, 155);
			add(invObjects);
			
			title.scrollFactor.x = title.scrollFactor.y = 0;
			bg.scrollFactor.x = bg.scrollFactor.y = 0;
			resultBlock.scrollFactor.x = resultBlock.scrollFactor.y = 0;
			
			open = true;
		}
		
		public function createBlock(X:uint, Y:uint):void
		{
			var Block:DropTarget = new DropTarget(X, Y, blockImg);
			craftBlocks.add(Block);
			Block.scrollFactor.x = Block.scrollFactor.y = 0;
		}
		
		public override function update():void
		{
			super.update();
			FlxG.overlap(invObjects, craftBlocks, DropObjToTarg);
		}
		
		public function DropObjToTarg(object:DraggableSprite, target:DropTarget):void
		{
			//Smoothly drop it on the nearest target!
			if (object.x > target.x)
				object.x--;
			if (object.x < target.x)
				object.x++;
			if (object.y > target.y)
				object.y--;
			if (object.y < target.y)
				object.y++;
			
			if(object.x == target.x && object.y == target.y)
				target.hasSomething = true;
				
			if (target != null)
				craftArray[0] = target;
			
			
			MakeResult();
		}
		
		public function MakeResult():void
		{
			var Block:DropTarget = craftArray[0];
				if (Block.hasSomething == true)
					{
						
					}
		}
		
		public function createInv(Group:FlxGroup, X:uint, Y:uint):void
		{
			var invObj:DraggableSprite = new DraggableSprite(X, Y);
			invObj.makeGraphic(32, 32, 0xffff0000);
			invObj.scrollFactor.x = invObj.scrollFactor.y = 0;
			Group.add(invObj);
		}
		
		public function CraftMenu()
		{
			create();
		} 
		
		public function ExitMenu(State:PlayState):void
		{
			if (this.exists)
			{
			open = false;
			kill();
			destroy();
			State.blockInput = false;
			}
		}
	}

}