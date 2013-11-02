/**
 * Visualize: Superformula from Form+Code in Design, Art, and Architecture 
 * implemented in ActionScript 3 by Ben Rubin <http://blog.benjaminrubin.com>
 * 
 * Run from the command line with: mxmlc Visualize_Superformula.as
 * Mxmlc is available free as part of the Flex SDK: http://opensource.adobe.com/wiki/display/flexsdk/Flex+SDK
 *	
 * For more information about Form+Code visit http://formandcode.com
 */
package 
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import rubin.ui.Slider;

	[SWF( backgroundColor='0xFFFFFF', frameRate='30', width='800', height='600')]

	public class Visualize_Superformula extends Sprite 
	{
		
		public function Visualize_Superformula():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var scaler:Number = 200;
		private var m:int = 2;
		private var n1:Number = 18;
		private var n2:Number = 4;
		private var n3:Number = 2;
		
		private static const TWO_PI:Number = Math.PI * 2;
		
		private var shape:Shape;
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			shape = new Shape();
			shape.x = stage.stageWidth / 2;
			shape.y = stage.stageHeight / 2;
			stage.addChild(shape);
			
			var scalerTitle:TextField = new TextField();
			scalerTitle.text = "Scaler";
			scalerTitle.textColor = 0xFF80C0;
			scalerTitle.x = 10;
			scalerTitle.y = 10;
			this.addChild(scalerTitle);
			
			var scalerSlider:Slider = new Slider();
			scalerSlider.min = 150;
			scalerSlider.max = 300;
			scalerSlider.minRange = 150;
			scalerSlider.maxRange = 300;
			scalerSlider.value = scaler;
			scalerSlider.x = 80;
			scalerSlider.y = 10;
			this.addChild(scalerSlider);
			scalerSlider.addEventListener(Event.CHANGE, scalerChange);
			
			var mTitle:TextField = new TextField();
			mTitle.text = "M";
			mTitle.textColor = 0xFF80C0;
			mTitle.x = 10;
			mTitle.y = 30;
			this.addChild(mTitle);
			
			var mSlider:Slider = new Slider();
			mSlider.min = -20;
			mSlider.max = 50;
			mSlider.minRange = -20;
			mSlider.maxRange = 50;
			mSlider.value = m;
			mSlider.x = 80;
			mSlider.y = 30;
			this.addChild(mSlider);
			mSlider.addEventListener(Event.CHANGE, mChange);
			
			var n1Title:TextField = new TextField();
			n1Title.text = "N1";
			n1Title.textColor = 0xFF80C0;
			n1Title.x = 10;
			n1Title.y = 50;
			this.addChild(n1Title);
			
			var n1Slider:Slider = new Slider();
			n1Slider.min = -10;
			n1Slider.max = 100;
			n1Slider.minRange = -10;
			n1Slider.maxRange = 100;
			n1Slider.value = n1;
			n1Slider.x = 80;
			n1Slider.y = 50;
			this.addChild(n1Slider);
			n1Slider.addEventListener(Event.CHANGE, n1Change);
			
			var n2Title:TextField = new TextField();
			n2Title.text = "N2";
			n2Title.textColor = 0xFF80C0;
			n2Title.x = 10;
			n2Title.y = 70;
			this.addChild(n2Title);
			
			var n2Slider:Slider = new Slider();
			n2Slider.min = -10;
			n2Slider.max = 100;
			n2Slider.minRange = -10;
			n2Slider.maxRange = 100;
			n2Slider.value = n2;
			n2Slider.x = 80;
			n2Slider.y = 70;
			this.addChild(n2Slider);
			n2Slider.addEventListener(Event.CHANGE, n2Change);
			
			var n3Title:TextField = new TextField();
			n3Title.text = "N3";
			n3Title.textColor = 0xFF80C0;
			n3Title.x = 10;
			n3Title.y = 90;
			this.addChild(n3Title);
			
			var n3Slider:Slider = new Slider();
			n3Slider.min = -10;
			n3Slider.max = 200;
			n3Slider.minRange = -10;
			n3Slider.maxRange = 200;
			n3Slider.value = n3;
			n3Slider.x = 80;
			n3Slider.y = 90;
			this.addChild(n3Slider);
			n3Slider.addEventListener(Event.CHANGE, n3Change);
			
			draw();
		}
		
		private function draw():void {
			shape.graphics.clear();
			shape.graphics.lineStyle(1, 0xFF80C0, 1);
			
			var newscaler:Number = scaler;
			var i:int;
			for (i = 16; i > 0; i--) {
				var mm:Number = m + i;
				var nn1:Number = n1 + i;
				var nn2:Number = n2 + 1;
				var nn3:Number = n3 + i;
				newscaler *= 0.98;
				var sscaler:Number = newscaler;
				
				var graphicsData:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
				
				var points:Vector.<Point> = superFormula(mm, nn1, nn2, nn3);
				
				var commands:Vector.<int> = new Vector.<int>();
				commands.push(1);
				var data:Vector.<Number> = new Vector.<Number>();
				data.push(points[points.length - 1].x * sscaler, points[points.length - 1].y * sscaler);
				
				var point:Point;
				for each(point in points) {
					commands.push(2);
					data.push(point.x * sscaler, point.y * sscaler);
				}
				
				graphicsData.push(new GraphicsPath(commands, data));
				shape.graphics.drawGraphicsData(graphicsData);
			}
		}
		
		private function superFormula(_m:Number, _n1:Number, _n2:Number, _n3:Number):Vector.<Point> {
			var numPoints:int = 360;
			var phi:Number = TWO_PI / numPoints;
			var points:Vector.<Point> = new Vector.<Point>();
			var i:int;
			for (i = 0; i < numPoints; i++) {
				points[i] = superformulaPoint(_m, _n1, _n2, _n3, phi * i);
			}
			
			return points;
		}
		
		private function superformulaPoint(_m:Number, _n1:Number, _n2:Number, _n3:Number, _phi:Number):Point {
			var r:Number;
			var t1:Number;
			var t2:Number;
			var a:Number = 1;
			var b:Number = 1;
			var x:Number = 0;
			var y:Number = 0;
			
			t1 = Math.cos(_m * _phi / 4) / a;
			t1 = t1 < 0 ? -t1:t1;
			t1 = Math.pow(t1, n2);
			
			t2 = Math.sin(_m * _phi / 4) / b;
			t2 = t2 < 0 ? -t2:t2;
			t2 = Math.pow(t2, _n3);
			
			r = Math.pow((t1 + t2), (1 / _n1));
			if (Math.abs(r) == 0) {
				x = 0;
				y = 0;
			}else {
				r = 1 / r;
				x = r * Math.cos(_phi);
				y = r * Math.sin(_phi);
			}
			
			return new Point(x, y);
		}
		
		private function scalerChange(e:Event):void {
			scaler = e.target.value;
			draw();
		}
		
		private function mChange(e:Event):void {
			m = e.target.value;
			draw();
		}
		
		private function n1Change(e:Event):void {
			n1 = e.target.value;
			draw();
		}
		
		private function n2Change(e:Event):void {
			n2 = e.target.value;
			draw();
		}
		
		private function n3Change(e:Event):void {
			n3 = e.target.value;
			draw();
		}
	}	
}