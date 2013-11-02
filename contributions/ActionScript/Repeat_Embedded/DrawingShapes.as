package  {
	import flash.display.*;

	/**
	 * based on source code found at:
	 * http://www.macromedia.com/devnet/mx/flash/articles/adv_draw_methods.html
	 * 
	 * @author Ric Ewing - version 1.4 - 4.7.2002
	 * @author Kevin Williams - version 2.0 - 4.7.2005
	 * @author Aden Forshaw - Version AS3 - 19.4.2010
	 * @author Sidney de Koning - Version AS3 - 20.4.2010 - errors/correct datatypes/optimized math operations
	 * 
	 * Usage:
	 * var s : Shape = new Shape( ); // Or Sprite of MovieClip or any other Class that makes use of the Graphics class
	 * 
	 * // Draw an ARC
	 * s.graphics.lineStyle( 4, 0xE16606 );
	 * DrawingShapes.drawArc( s.graphics, 50, 50, 10, 150, 60 );
	 * 
	 * // Draw an BURST	
	 * s.graphics.lineStyle( 3, 0x000000 );
	 * DrawingShapes.drawBurst( s.graphics, 80, 60, 3, 15, 6, 27 );
	 * 
	 * // Draw an DASHED-LINE like so - - - - 		
	 * s.graphics.lineStyle( 1, 0x3C3C39 );
	 * DrawingShapes.drawDash( s.graphics, 120, 60, 150, 80, 2, 2 );
	 * 
	 * // Draw an GEAR		
	 * s.graphics.lineStyle( 3, 0xE16606 );
	 * DrawingShapes.drawGear( s.graphics, 200, 60, 13, 31, 26, 0, 7, 13 );
	 * 
	 * // Draw a POLYGON		
	 * s.graphics.lineStyle( 3, 0x0074B9 );
	 * DrawingShapes.drawPolygon( s.graphics, 270, 60, 7, 30, 45 );
	 * 
	 * // Draw a STAR		
	 * s.graphics.lineStyle( 2, 0x000000 );
	 * DrawingShapes.drawStar( s.graphics, 340, 60, 18, 24, 19, 27 );
	 * 
	 * // Draw an WEDGE - good for pie charts or pacmans		
	 * s.graphics.lineStyle( 2, 0xFFCC00 );
	 * DrawingShapes.drawWedge( s.graphics, 400, 60, 30, 309, 209 );
	 * 
	 * // Draw a LINE	
	 * s.graphics.lineStyle( 2, 0x0074B9 );
	 * DrawingShapes.drawLine( s.graphics, 440, 85, 30, DrawingShapes.VERTICAL_LINE );
	 * 		
	 * addChild( s );
	 */
	public class DrawingShapes {

		public static const HORIZONTAL_LINE : String = "DrawingShapes.horizontal";
		public static const VERTICAL_LINE : String = "DrawingShapes.vertical";

		
		public function DrawingShapes() {
			throw new ArgumentError( "The DrawingShapes Class cannot be instanicated." );
		}

		/**
		 * drawDash
		 * Draws a dashed line from the point x1,y1 to the point x2,y2
		 * 
		 * @param target Graphics the Graphics Class on which the dashed line will be drawn.
		 * @param x1 Number starting position on x axis - <strong></strong>required</strong>
		 * @param y1 Number starting position on y axis - <strong></strong>required</strong>
		 * @param x2 Number finishing position on x axis - <strong></strong>required</strong>
		 * @param y2 Number finishing position on y axis - <strong></strong>required</strong>
		 * @param dashLength [optional] Number the number of pixels long each dash 
		 * will be.  Default = 5
		 * @param spaceLength [optional] Number the number of pixels between each 
		 * dash.  Default = 5
		 */
		public static function drawDash(target : Graphics, x1 : Number,y1 : Number,x2 : Number, y2 : Number, dashLength : Number = 5, spaceLength : Number = 5 ) : void {
			
			var x : Number = x2 - x1;
			var y : Number = y2 - y1;
			var hyp : Number = Math.sqrt( (x) * (x) + (y) * (y) );
			var units : Number = hyp / (dashLength + spaceLength);
			var dashSpaceRatio : Number = dashLength / (dashLength + spaceLength);
			var dashX : Number = (x / units) * dashSpaceRatio;
			var spaceX : Number = (x / units) - dashX;
			var dashY : Number = (y / units) * dashSpaceRatio;
			var spaceY : Number = (y / units) - dashY;
			
			target.moveTo( x1, y1 );
			while (hyp > 0) {
				x1 += dashX;
				y1 += dashY;
				hyp -= dashLength;
				if (hyp < 0) {
					x1 = x2;
					y1 = y2;
				}
				target.lineTo( x1, y1 );
				x1 += spaceX;
				y1 += spaceY;
				target.moveTo( x1, y1 );
				hyp -= spaceLength;
			}
			target.moveTo( x2, y2 );
		}

		/**
		 * Draws an arc from the starting position of x,y.
		 * 
		 * @param target the Graphics Class that the Arc is drawn on.
		 * @param x x coordinate of the starting pen position
		 * @param y y coordinate of the starting pen position 
		 * @param radius radius of Arc.
		 * @param arc = sweep of the arc. Negative values draw clockwise.
		 * @param startAngle = [optional] starting offset angle in degrees.
		 * @param yRadius = [optional] y radius of arc. if different than 
		 * radius, then the arc will draw as the arc of an oval.  
		 * default = radius.
		 *
		 * Based on mc.drawArc by Ric Ewing.
		 * the version by Ric assumes that the pen is at x:y before this
		 * method is called.  I explictily move the pen to x:y to be 
		 * consistent with the behaviour of the other methods.
		 */
		public static function drawArc(target : Graphics,  x : Number, y : Number, radius : Number, arc : Number, startAngle : Number = 0, yRadius : Number = 0) : void {
			
			if (arguments.length < 5) {
				throw new ArgumentError( "DrawingShapes.drawArc() - too few parameters, need atleast 5." );
				return;
			}
			
			// if startAngle is undefined, startAngle = 0
			if( startAngle == 0 ) {
				startAngle = 0;
			}
			// if yRadius is undefined, yRadius = radius
			if (yRadius == 0) {
				yRadius = radius;
			}
			
			// Init vars
			var segAngle : Number, theta : Number, angle : Number, angleMid : Number, segs : Number, ax : Number, ay : Number, bx : Number, by : Number, cx : Number, cy : Number;
			// no sense in drawing more than is needed :)
			if (DrawingShapes.abs( arc ) > 360) {
				arc = 360;
			}
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = DrawingShapes.ceil( DrawingShapes.abs( arc ) / 45 );
			// Now calculate the sweep of each segment
			segAngle = arc / segs;
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians. 
			theta = -(segAngle / 180) * Math.PI;
			// convert angle startAngle to radians
			angle = -(startAngle / 180) * Math.PI;
			// find our starting points (ax,ay) relative to the secified x,y
			ax = x - Math.cos( angle ) * radius;
			ay = y - Math.sin( angle ) * yRadius;
			// if our arc is larger than 45 degrees, draw as 45 degree segments
			// so that we match Flash's native circle routines.
			if (segs > 0) {
				target.moveTo( x, y );
				// Loop for drawing arc segments
				for (var i : int = 0; i < segs; ++i) {
					// increment our angle
					angle += theta;
					// find the angle halfway between the last angle and the new
					angleMid = angle - (theta / 2);
					// calculate our end point
					bx = ax + Math.cos( angle ) * radius;
					by = ay + Math.sin( angle ) * yRadius;
					// calculate our control point
					cx = ax + Math.cos( angleMid ) * (radius / Math.cos( theta / 2 ));
					cy = ay + Math.sin( angleMid ) * (yRadius / Math.cos( theta / 2 ));
					// draw the arc segment
					target.curveTo( cx, cy, bx, by );
				}
			}
		}

		/**
		 * draws pie shaped wedges.  Could be employeed to draw pie charts.
		 * 
		 * @param target the Graphics on which the wedge is to be drawn.
		 * @param x x coordinate of the center point of the wedge
		 * @param y y coordinate of the center point of the wedge
		 * @param radius the radius of the wedge 
		 * @param arc the sweep of the wedge. negative values draw clockwise
		 * @param startAngle the starting angle in degrees
		 * @param yRadius [optional] the y axis radius of the wedge. 
		 * If not defined, then yRadius = radius.
		 * 
		 * based on mc.drawWedge() - by Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 */
		public static function drawWedge(target : Graphics, x : Number, y : Number, radius : Number, arc : Number, startAngle : Number = 0,  yRadius : Number = 0) : void {
			
			// if yRadius is undefined, yRadius = radius
			if (yRadius == 0) {
				yRadius = radius;
			}
			
			// move to x,y position
			target.moveTo( x, y );
			// if yRadius is undefined, yRadius = radius
			if (yRadius == 0) {
				yRadius = radius;
			}
			// Init vars
			var segAngle : Number, theta : Number, angle : Number, angleMid : Number, segs : Number, ax : Number, ay : Number, bx : Number, by : Number, cx : Number, cy : Number;
			// limit sweep to reasonable numbers
			if (DrawingShapes.abs( arc ) > 360) {
				arc = 360;
			}
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = DrawingShapes.ceil( DrawingShapes.abs( arc ) / 45 );
			// Now calculate the sweep of each segment.
			segAngle = arc / segs;
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians.
			theta = -(segAngle / 180) * Math.PI;
			// convert angle startAngle to radians
			angle = -(startAngle / 180) * Math.PI;
			// draw the curve in segments no larger than 45 degrees.
			if (segs > 0) {
				// draw a line from the center to the start of the curve
				ax = x + Math.cos( startAngle / 180 * Math.PI ) * radius;
				ay = y + Math.sin( -startAngle / 180 * Math.PI ) * yRadius;
				target.lineTo( ax, ay );
				// Loop for drawing curve segments
				for (var i : int = 0; i < segs; ++i) {
					angle += theta;
					angleMid = angle - (theta / 2);
					bx = x + Math.cos( angle ) * radius;
					by = y + Math.sin( angle ) * yRadius;
					cx = x + Math.cos( angleMid ) * (radius / Math.cos( theta / 2 ));
					cy = y + Math.sin( angleMid ) * (yRadius / Math.cos( theta / 2 ));
					target.curveTo( cx, cy, bx, by );
				}
				// close the wedge by drawing a line to the center
				target.lineTo( x, y );
			}
		}

		/**
		 * start draws a star shaped polygon.
		 * 
		 * <blockquote>Note that the stars by default 'point' to
		 * the right. This is because the method starts drawing
		 * at 0 degrees by default, putting the first point to
		 * the right of center. Negative values for points
		 * draws the star in reverse direction, allowing for
		 * knock-outs when used as part of a mask.</blockquote>
		 *  
		 * @param target the Graphics that the star is drawn on
		 * @param x x coordinate of the center of the star
		 * @param y y coordinate of the center of the star
		 * @param points the number of points on the star
		 * @param innerRadius the radius of the inside angles of the star
		 * @param outerRadius the radius of the outside angles of the star
		 * @param angle [optional] the offet angle that the start is rotated
		 * 
		 * based on mc.drawStar() - by Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 */
		public static function drawStar(target : Graphics, x : Number, y : Number, points : uint, innerRadius : Number, outerRadius : Number, angle : Number = 0) : void {
			
			// check that points is sufficient to build polygon
			if(points <= 2) {
				throw ArgumentError( "DrawingShapes.drawStar() - parameter 'points' needs to be atleast 3" ); 
				return;
			}
			if (points > 2) {
				// init vars
				var step : Number, halfStep : Number, start : Number, n : Number, dx : Number, dy : Number;
				// calculate distance between points
				step = (Math.PI * 2) / points;
				halfStep = step / 2;
				// calculate starting angle in radians
				start = (angle / 180) * Math.PI;
				target.moveTo( x + (Math.cos( start ) * outerRadius), y - (Math.sin( start ) * outerRadius) );
				// draw lines
				for (n = 1; n <= points; ++n) {
					dx = x + Math.cos( start + (step * n) - halfStep ) * innerRadius;
					dy = y - Math.sin( start + (step * n) - halfStep ) * innerRadius;
					target.lineTo( dx, dy );
					dx = x + Math.cos( start + (step * n) ) * outerRadius;
					dy = y - Math.sin( start + (step * n) ) * outerRadius;
					target.lineTo( dx, dy );
				}
			}
		}

		/**
		 * a method for creating polygon shapes.  Negative values will draw 
		 * the polygon in reverse direction.  Negative drawing may be useful 
		 * for creating knock-outs in masks.
		 * 
		 * @param target the Graphics that the polygon is to be drawn on
		 * @param x x coordinate of the center of the polygon
		 * @param y y coordinate of the center of the polygon
		 * @param sides the number of sides (must be > 2)
		 * @param radius the radius from the center point to the points
		 * on the polygon
		 * @param angle [optional] the starting offset angle (degrees) from
		 * 0. Default = 0
		 * 
		 * based on mc.drawPoly() - by Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 */
		public static function drawPolygon(target : Graphics, x : Number, y : Number, sides : uint, radius : Number, angle : Number = 0) : void {
			
			// check that sides is sufficient to build
			if(sides <= 2) {
				throw ArgumentError( "DrawingShapes.drawPolygon() - parameter 'sides' needs to be atleast 3" ); 
				return;
			}
			if (sides > 2) {
				// init vars
				var step : Number, start : Number, n : Number, dx : Number, dy : Number;
				// calculate span of sides
				step = (Math.PI * 2) / sides;
				// calculate starting angle in radians
				start = (angle / 180) * Math.PI;
				target.moveTo( x + (Math.cos( start ) * radius), y - (Math.sin( start ) * radius) );
				// draw the polygon
				for (n = 1; n <= sides; ++n) {
					dx = x + Math.cos( start + (step * n) ) * radius;
					dy = y - Math.sin( start + (step * n) ) * radius;
					target.lineTo( dx, dy );
				}
			}
		}

		/**
		 * Burst is a method for drawing star bursts.  If you've ever worked
		 * with an advertising department, you know what they are ;-)
		 * Clients tend to want them, Developers tend to hate them...
		 *
		 * @param target Graphics where the Burst is to be drawn.
		 * @param x x coordinate of the center of the burst
		 * @param y y coordinate of the center of the burst
		 * @param sides number of sides or points
		 * @param innerRadius radius of the indent of the curves
		 * @param outerRadius radius of the outermost points
		 * @param angle [optional] starting angle in degrees. (defaults to 0)
		 * 
		 * based on mc.drawBurst() - by Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 */
		public static function drawBurst(target : Graphics, x : Number, y : Number, sides : uint, innerRadius : Number, outerRadius : Number, angle : Number = 0 ) : void {
			
			// check that sides is sufficient to build
			if(sides <= 2) {
				throw ArgumentError( "DrawingShapes.drawBurst() - parameter 'sides' needs to be atleast 3" ); 
				return;
			}
			if (sides > 2) {
				// init vars
				var step : Number, halfStep : Number, qtrStep : Number, start : Number, n : Number, dx : Number, dy : Number, cx : Number, cy : Number;
				// calculate length of sides
				step = (Math.PI * 2) / sides;
				halfStep = step / 2;
				qtrStep = step / 4;
				// calculate starting angle in radians
				start = (angle / 180) * Math.PI;
				target.moveTo( x + (Math.cos( start ) * outerRadius), y - (Math.sin( start ) * outerRadius) );
				// draw curves
				for (n = 1; n <= sides; ++n) {
					cx = x + Math.cos( start + (step * n) - (qtrStep * 3) ) * (innerRadius / Math.cos( qtrStep ));
					cy = y - Math.sin( start + (step * n) - (qtrStep * 3) ) * (innerRadius / Math.cos( qtrStep ));
					dx = x + Math.cos( start + (step * n) - halfStep ) * innerRadius;
					dy = y - Math.sin( start + (step * n) - halfStep ) * innerRadius;
					target.curveTo( cx, cy, dx, dy );
					cx = x + Math.cos( start + (step * n) - qtrStep ) * (innerRadius / Math.cos( qtrStep ));
					cy = y - Math.sin( start + (step * n) - qtrStep ) * (innerRadius / Math.cos( qtrStep ));
					dx = x + Math.cos( start + (step * n) ) * outerRadius;
					dy = y - Math.sin( start + (step * n) ) * outerRadius;
					target.curveTo( cx, cy, dx, dy );
				}
			}
		}

		/**
		 * draws a gear shape on the Graphics target.  The gear position 
		 * is indicated by the x and y arguments.
		 * 
		 * @param target Graphics on which the gear is to be drawn.
		 * @param x x coordinate of the center of the gear
		 * @param y y coordinate of the center of the gear
		 * @param sides number of teeth on gear. (must be > 2)
		 * @param innerRadius radius of the indent of the teeth.
		 * @param outerRadius outer radius of the teeth.
		 * @param angle = [optional] starting angle in degrees. Defaults to 0.
		 * @param holeSides [optional] draw a polygonal hole with this many sides (must be > 2)
		 * @param holeRadius [optional] size of hole. Default = innerRadius/3.
		 * 
		 * based on mc.drawGear() - by Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 */
		public static function drawGear(target : Graphics, x : Number, y : Number, sides : uint, innerRadius : Number = 80, outerRadius : Number = 4, angle : Number = 0, holeSides : Number = 2, holeRadius : Number = 0 ) : void {
			
			// check that sides is sufficient to build polygon
			if(sides <= 2) {
				throw ArgumentError( "DrawingShapes.drawGear() - parameter 'sides' needs to be atleast 3" ); 
				return;
			}
			if (sides > 2) {
				// init vars
				var step : Number, qtrStep : Number, start : Number, n : Number, dx : Number, dy : Number;
				// calculate length of sides
				step = (Math.PI * 2) / sides;
				qtrStep = step / 4;
				// calculate starting angle in radians
				start = (angle / 180) * Math.PI;
				target.moveTo( x + (Math.cos( start ) * outerRadius), y - (Math.sin( start ) * outerRadius) );
				// draw lines
				for (n = 1; n <= sides; ++n) {
					dx = x + Math.cos( start + (step * n) - (qtrStep * 3) ) * innerRadius;
					dy = y - Math.sin( start + (step * n) - (qtrStep * 3) ) * innerRadius;
					target.lineTo( dx, dy );
					dx = x + Math.cos( start + (step * n) - (qtrStep * 2) ) * innerRadius;
					dy = y - Math.sin( start + (step * n) - (qtrStep * 2) ) * innerRadius;
					target.lineTo( dx, dy );
					dx = x + Math.cos( start + (step * n) - qtrStep ) * outerRadius;
					dy = y - Math.sin( start + (step * n) - qtrStep ) * outerRadius;
					target.lineTo( dx, dy );
					dx = x + Math.cos( start + (step * n) ) * outerRadius;
					dy = y - Math.sin( start + (step * n) ) * outerRadius;
					target.lineTo( dx, dy );
				}
				// This is complete overkill... but I had it done already. :)
				if (holeSides > 2) {
					step = (Math.PI * 2) / holeSides;
					target.moveTo( x + (Math.cos( start ) * holeRadius), y - (Math.sin( start ) * holeRadius) );
					for (n = 1; n <= holeSides; ++n) {
						dx = x + Math.cos( start + (step * n) ) * holeRadius;
						dy = y - Math.sin( start + (step * n) ) * holeRadius;
						target.lineTo( dx, dy );
					}
				}
			}
		}

		/**
		 * draws a line between two points. Make it horizontal or vertical 
		 * 
		 * @param target Graphics on which the gear is to be drawn.
		 * @param x x coordinate of the center of the gear
		 * @param y y coordinate of the center of the gear
		 * @param sides number of teeth on gear. (must be > 2)
		 * 
		 * 
		 */
		public static function drawLine(target : Graphics, x : Number, y : Number, length : Number, direction : String = DrawingShapes.HORIZONTAL_LINE ) : void {
			target.moveTo( x, y );
			switch (direction) {
				case DrawingShapes.HORIZONTAL_LINE :
					target.lineTo( length, y );
					break;
				case DrawingShapes.VERTICAL_LINE :
					target.moveTo( x, y );
					target.lineTo( x, length );
					break;
			}
		}

		/*
		 * new abs function, about 25x faster than Math.abs
		 */
		private static function abs( value : Number ) : Number {
			return value < 0 ? -value : value;
		}

		/*
		 * new ceil function about 75% faster than Math.ceil. 
		 */
		private static function ceil( value : Number) : Number {
			return (value % 1) ? int( value ) + 1 : value;
		}
	}
}