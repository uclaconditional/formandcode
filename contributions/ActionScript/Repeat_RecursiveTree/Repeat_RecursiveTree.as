/**
 * Repeat: Recursive Tree from Form+Code in Design, Art, and Architecture 
 * implemented in ActionScript 3 by João Goncalves <http://joaogoncalves.net/>
 * 
 * Run from the command line with: mxmlc Repeat_RecursiveTree.as
 * Mxmlc is available free as part of the Flex SDK: http://opensource.adobe.com/wiki/display/flexsdk/Flex+SDK
 *	
 * For more information about Form+Code visit http://formandcode.com
 */
package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Joao Gonçalves
	 * http://joaogoncalves.net
	 * joao@joaogoncalves.net
	 */
	
	[SWF(width='900', height='600', backgroundColor='#ffffff', framerate=1)]
	public class Repeat_RecursiveTree extends Sprite 
	{
		
		private var dotSize:Number = 9;
		private var angleOffsetA:Number;
		private var angleOffsetB:Number;
		
		private var instructions:TextField;
		
		
		public function Repeat_RecursiveTree():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			instructions = new TextField();
			instructions.text = "Click to generate a Tree, Double-Click to clear the stage.";
			instructions.autoSize = TextFieldAutoSize.LEFT;
			addChild(instructions);
			
			angleOffsetA = degToRad(1.5);
			angleOffsetB = degToRad(50);
			
			stage.doubleClickEnabled = true;
			stage.addEventListener(MouseEvent.CLICK, generateThree);
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, clearStage);			
			
		}
		
		private function clearStage(e:MouseEvent):void 
		{
			this.graphics.clear();
		}
		
		private function generateThree(e:MouseEvent):void 
		{
			this.graphics.beginFill(0x000000);
			seed1(dotSize, degToRad(270), mouseX, mouseY);
		}
		
		private function seed1(dotSize:Number, angle:Number, xpos:Number, ypos:Number):void
		{
			var newX:Number;
			var newY:Number;
			
			if (dotSize>1) 
			{
				// create random number between 0 and 1
				var r:Number = Math.random();
				
				// 98% chance this will happen
				if (r> 0.02) 
				{
					this.graphics.drawEllipse(xpos, ypos, dotSize, dotSize);
					newX = xpos + Math.cos(angle) * dotSize;
					newY = ypos + Math.sin(angle) * dotSize;
					seed1(dotSize * 0.99, angle- angleOffsetA, newX, newY);
				}
				// 2% chance this will happen
				else 
				{
					this.graphics.drawEllipse(xpos, ypos, dotSize, dotSize);
					newX = xpos + Math.cos(angle);
					newY = ypos + Math.sin(angle);
					seed2(dotSize * 0.99, angle + angleOffsetA, newX, newY);
					seed1(dotSize * 0.60, angle + angleOffsetB, newX, newY);
					seed2(dotSize * 0.50, angle-angleOffsetB, newX, newY);

				}
			}
		}
		
		private function seed2(dotSize:Number, angle:Number, xpos:Number, ypos:Number):void
		{
			var newX:Number;
			var newY:Number;

			if (dotSize>1) 
			{
				// create random number between 0 and 1
				var r:Number = Math.random();
				
				// 95% chances this will happen
				if (r> 0.05) 
				{
					this.graphics.drawEllipse(xpos, ypos, dotSize, dotSize);
					newX = xpos + Math.cos(angle) * dotSize;
					newY = ypos + Math.sin(angle) * dotSize;
					seed2(dotSize * 0.99, angle+ angleOffsetA, newX, newY);
				}
				// 5% chance this will happen
				else 
				{
					this.graphics.drawEllipse(xpos, ypos, dotSize, dotSize);
					newX = xpos + Math.cos(angle);
					newY = ypos + Math.sin(angle);
					seed1(dotSize * 0.99, angle + angleOffsetA, newX, newY);
					seed2(dotSize * 0.60, angle + angleOffsetB, newX, newY);
					seed1(dotSize * 0.50, angle-angleOffsetB, newX, newY);

				}
			}
		}
		
		
		private function degToRad(deg:Number):Number
		{
			return deg * (Math.PI / 180);
		}
		
	}
	
}