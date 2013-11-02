package 
{
        /*
         * This class is based on code written by Ric Ewing (www.ricewing.com).
         * See the details at http://www.adobe.com/devnet/flash/articles/adv_draw_methods.html.
         * I made several changes including the sending the target Sprite to the function.
         * Usage: Arc.draw(mySprite, 350, 200, 100, arcAngle);
        */
        
        import flash.display.*;
        
        public class Arc
        {
                public static function draw(t:Sprite, sx:Number, sy:Number, radius:Number, arc:Number, startAngle:Number=0):void
                {
                        var segAngle:Number;
                        var angle:Number;
                        var angleMid:Number;
                        var numOfSegs:Number;
                        var ax:Number;
                        var ay:Number;
                        var bx:Number;
                        var by:Number;
                        var cx:Number;
                        var cy:Number;
                        
                        // Move the pen
                        t.graphics.moveTo(sx, sy);
                
                        // No need to draw more than 360
                        if (Math.abs(arc) > 360) 
                        {
                                arc = 360;
                        }
                
                        numOfSegs = Math.ceil(Math.abs(arc) / 45);
                        segAngle = arc / numOfSegs;
                        segAngle = (segAngle / 180) * Math.PI;
                        angle = (startAngle / 180) * Math.PI;
                        
                        // Calculate the start point
                        ax = sx - Math.cos(angle) * radius;
                        ay = sy - Math.sin(angle) * radius;
                
                        for(var i:int=0; i<numOfSegs; i++) 
                        {
                                // Increment the angle
                                angle += segAngle;
                                
                                // The angle halfway between the last and the new
                                angleMid = angle - (segAngle / 2);
                                
                                // Calculate the end point
                                bx = ax + Math.cos(angle) * radius;
                                by = ay + Math.sin(angle) * radius;
                                
                                // Calculate the control point
                                cx = ax + Math.cos(angleMid) * (radius / Math.cos(segAngle / 2));
                                cy = ay + Math.sin(angleMid) * (radius / Math.cos(segAngle / 2));

                                // Draw out the segment
                                t.graphics.curveTo(cx, cy, bx, by);
                        }
                }
        }
}