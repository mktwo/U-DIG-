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
		public var result:DraggableSprite;
		public var invObjects:FlxGroup;
		public var container:CraftContainer;
		public var properCraft:Boolean = false;
		
		public override function create():void
		{
			var title:FlxText;
			title = new FlxText(12, 20, 128, "Craft!");
			title.setFormat(null, 16, 0xffffff, "left", 0x444444);
			add(title);
			
			var bg:FlxSprite;
			bg = new FlxSprite(10, 40);
			bg.loadGraphic(bgImg, false, false, FlxG.width - 20, FlxG.height - 96, false);
			add(bg);
			
			craftArray = new Array();
			
			craftBlocks = new FlxGroup();
			createBlock(72, 64, 0);
			createBlock(105, 64, 1);
			createBlock(138, 64, 2);
			createBlock(72, 97, 3);
			createBlock(105, 97, 4);
			createBlock(138, 97, 5);
			createBlock(72, 130, 6);
			createBlock(105, 130, 7);
			createBlock(138, 130, 8);
			add(craftBlocks);
			
			resultBlock = new FlxSprite(212, 97, blockImg);
			add(resultBlock);
			
			result = new DraggableSprite(resultBlock.x, resultBlock.y);
			result.makeGraphic(28, 28, 0x6600ffff);
			result.visible = false;
			add(result);
			
			container = new CraftContainer(this);
			
			invObjects = new FlxGroup();
			createInv(invObjects, 72, 200);
			createInv(invObjects, 105, 200);
			createInv(invObjects, 138, 200);
			createInv(invObjects, 171, 200);
			createInv(invObjects, 204, 200);
			add(invObjects);
			
			title.scrollFactor.x = title.scrollFactor.y = 0;
			bg.scrollFactor.x = bg.scrollFactor.y = 0;
			resultBlock.scrollFactor.x = resultBlock.scrollFactor.y = 0;
			result.scrollFactor.x = result.scrollFactor.y = 0;
			
			open = true;
		}
		
		public function createBlock(X:uint, Y:uint, i:uint):void
		{
			var Block:DropTarget = new DropTarget(X, Y, blockImg);
			if (Block != null)
				craftArray[i] = Block;
			craftBlocks.add(Block);
			Block.scrollFactor.x = Block.scrollFactor.y = 0;
		}
		
		public override function update():void
		{
			super.update();
			FlxG.overlap(invObjects, craftBlocks, DropObjToTarg);
			FlxG.collide(invObjects, invObjects);
			
			if (!result.dragging && !result.onTarget)
			{
				result.x = resultBlock.x;
				result.y = resultBlock.y;
			}
			
			container.update();
			properCraft = container.isProper;
			
			if (properCraft)
				result.visible = true;
			else
				result.visible = false;
			
		}
		
		public function DropObjToTarg(object:DraggableSprite, target:DropTarget):void
		{
			var objCentX:uint = object.width / 2;
			var objCentY:uint = object.height / 2;
			var tarCentX:uint = target.width / 2;
			var tarCentY:uint = target.height / 2;
			if (!object.dragging)
			{
				//Smoothly drop it on the nearest target!
				if (objCentX > tarCentX)
					object.x--;
				if (objCentX < tarCentX)
					object.x++;
				if (objCentY > tarCentY)
					object.y--;
				if (objCentY < tarCentY)
					object.y++;
			}
			
			
			if (object.x == target.x && object.y == target.y)
			{
				object.onTarget = true;
			}
			else
			{
				object.onTarget = false;
			}
			
			if (object.onTarget == true)
			{
				target.hasSomething = true;
			}
			else
			{
				target.hasSomething = false;
			}
		}
		
		public function createInv(Group:FlxGroup, X:uint, Y:uint):void
		{
			var invObj:DraggableSprite = new DraggableSprite(X, Y);
			invObj.makeGraphic(28, 28, 0x66ff0000);
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