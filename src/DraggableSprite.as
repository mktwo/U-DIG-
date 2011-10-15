/*
 * A drag and drop class for flixel. All you have to do is implement
 * DraggableFlxSprite instead of FlxSprite and voila, it's draggable.
 * 
 * Drag&drop done easy for flixel 2
 * */
package  
{
	import flash.events.MouseEvent;
	
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class DraggableSprite extends FlxSprite
	{
		public var dragging:Boolean;
		public var onTarget:Boolean;
		
		public function DraggableSprite(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
			FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);			
		}
		
		public override function update():void
		{
			if (this.dragging) {
				this.x = FlxG.mouse.screenX - this.width / 2;
				this.y = FlxG.mouse.screenY - this.height / 2;
			}
			
			super.update();
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			// I don't know if this check is important - copied it from FlxButton
			if (!exists || !visible || !active) {
				return;
			}
			if (overlapsPoint(FlxG.mouse,true,null)) {
				this.dragging = true;
			}
		}
	
		protected function onMouseUp(event:MouseEvent):void
		{
			// I don't know if this check is important - copied it from FlxButton
			if (!exists || !visible || !active || !FlxG.mouse.justReleased()) {
				return;
			}
			
			this.dragging = false;
		}
	}
}