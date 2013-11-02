/**
 * Repeat: Embedded Iteration from Form+Code in Design, Art, and Architecture 
 * implemented in ActionScript 3 by João Goncalves <http://joaogoncalves.net/>
 * 
 * Run from the command line with: mxmlc Repeat_Embedded.as
 * Mxmlc is available free as part of the Flex SDK: http://opensource.adobe.com/wiki/display/flexsdk/Flex+SDK
 *	
 * For more information about Form+Code visit http://formandcode.com
 */
package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	[SWF(width='400', height='300', backgroundColor='#000000')]
	 
	public class Repeat_Embedded extends Sprite 
	{
		
		private var option:int = 1;
		private var text:TextField;
		
		public function Repeat_Embedded():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			text = new TextField();
			text.textColor = 0xffffff;
			text.text = "Click to change...";
			addChild(text);
			
			stage.addEventListener(MouseEvent.CLICK, changeExample);

			drawSomething();
			
			
		}
		
		private function drawSomething():void 
		{
			graphics.clear();
			
			switch (option) 
			{
				case 1 : repeat1();	break;//call option 1
				case 2 : repeat2();	break;//call option 2
				case 3 : repeat3();	break;//call option 3
				case 4 : repeat4();	break;//call option 4
				case 5 : repeat5();	break;//call option 5
			}
		}
		
		private function changeExample(e:MouseEvent):void 
		{
			option < 5 ? option++ : option = 1;
			drawSomething();
		}
		
		// option 1
		private function repeat1():void 
		{
			
			for (var xpos:int = 50; xpos < stage.stageWidth - 50; xpos += 20) 
			{
				for (var ypos:int = 50; ypos < stage.stageHeight - 50; ypos += 20) 
				{
					with (graphics) 
					{
						lineStyle(1, 0xff0000);
						moveTo(xpos - 5, ypos - 5);
						lineTo(xpos + 5, ypos +5);
						moveTo(xpos + 5, ypos - 5);
						lineTo(xpos - 5, ypos +5);
					}					
					
				}
				
			}
		}
		
		// option 2
		private function repeat2():void 
		{
			for (var xpos:int = 50; xpos < stage.stageWidth - 50; xpos += 20) 
			{
				for (var ypos:int = 50; ypos < stage.stageHeight - 50; ypos += 20) 
				{
					with (graphics) 
					{
						lineStyle(1, 0xff0000);
						moveTo(xpos, ypos );
						lineTo(stage.stageWidth/2, stage.stageHeight/2);
					}							
				}				
			}
		}
		
		// option 3
		private function repeat3():void 
		{
			for (var xpos:int = 50; xpos < stage.stageWidth - 50; xpos += 20) 
			{
				for (var ypos:int = 50; ypos < stage.stageHeight - 50; ypos += 20) 
				{
					with (graphics) 
					{
						lineStyle(1, 0xff0000);
						graphics.drawCircle(xpos, ypos, 40 );
					}							
				}				
			}
			
		}
		
		// option 4
		private function repeat4():void 
		{
			var i:int = 10;
			this.graphics.lineStyle(1, 0xff0000);
			
			for (var xpos:int = 50; xpos < stage.stageWidth - 50; xpos += 20) 
			{
				for (var ypos:int = 50; ypos < stage.stageHeight - 50; ypos += 20) 
				{
					
					DrawingShapes.drawArc( this.graphics, xpos, ypos, 7, 200,i);
					
				}	
				i += 30;
			}
			
		}
		
		// option 5
		private function repeat5():void 
		{
			for (var xpos:int = 50; xpos < stage.stageWidth - 50; xpos += 20) 
			{
				for (var ypos:int = 50; ypos < stage.stageHeight - 50; ypos += 20) 
				{
					
					for (var i:int = 0; i < 16; i+=4) 
					{
						with (graphics) 
						{
							lineStyle(1, 0xff0000);
							moveTo(xpos+i, ypos );
							lineTo(xpos+i, ypos+12);
						}						
					}					
					graphics.moveTo(xpos, ypos );
					graphics.lineTo(xpos + 12, ypos + 12);												
				}				
			}
		}
		
		
		private function map(value:Number, inMin:Number, inMax:Number, outMin:Number, outMax:Number):Number
        {
            return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
        }
		
		
	}
	
}