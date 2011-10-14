package
{
     /**
     * ...
     * @author Jason Seip
     */
     import org.flixel.*;
	
     public class Backdrop extends FlxSprite
     {
          public function Backdrop(x:Number, y:Number, ImgBackdrop:Class, BackdropScroll:Number)
          {
               super(x, y);
               loadGraphic(ImgBackdrop, false);					//False parameteer means this is not a sprite sheet
			   this.blend = "multiply";
               scrollFactor.x = scrollFactor.y = BackdropScroll;
               solid = false;  //Just to make sure no collisions with the backdrop ever take place
          }
     }
}