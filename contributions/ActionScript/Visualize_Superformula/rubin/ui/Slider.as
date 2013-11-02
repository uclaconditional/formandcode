package rubin.ui
{
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Ben Rubin
	 */
	public class Slider extends Sprite
	{
		private var bar:Sprite;
		private var thumb:Sprite;
		private var thumbOffset:Number;
		private var thumbEnd:Number;
		private var field:TextField;
		
		private var _width:Number;
		override public function set width(value:Number):void {
			if (_width == value) return;
			_width = value;
			update();
		}
		
		private var _min:Number = 0;
		public function get min():Number { return _min; }
		public function set min(value:Number):void {
			if (_min == value) return;
			_min = value;
			
			setValue();
		}
		
		private var _max:Number = 100;
		public function get max():Number { return _max; }
		public function set max(value:Number):void {
			if (_max == value) return;
			_max = value;
			
			setValue();
		}
		
		private var _minRange:Number = 0;
		public function get minRange():Number { return _minRange; }
		public function set minRange(value:Number):void {
			if (_minRange == value) return;
			_minRange = value;
			
			setDisplay();
		}
		
		private var _maxRange:Number = 100;
		public function get maxRange():Number { return _maxRange; }
		public function set maxRange(value:Number):void {
			if (_maxRange == value) return;
			_maxRange = value;
			
			setDisplay();
		}
		
		private var _integer:Boolean = false;
		public function get integer():Boolean { return _integer; }
		public function set integer(value:Boolean):void {
			if (_integer == value) return;
			_integer = value;
			if (value) {
				update();
			}
		}
		
		private var _fieldWidth:Number = 30;
		public function get fieldWidth():Number { return _fieldWidth; }
		public function set fieldWidth(value:Number):void {
			if (_fieldWidth == value) return;
			_fieldWidth = value;
			field.width = value;
			update();
		}
		
		private var per:Number = 0;
		
		private var _value:Number;
		public function get value():Number { return _value; }
		public function set value(val:Number):void {
			if (val == _value) return;
			_value = val;
			
			setValueVar();
		}
		
		private var displayValue:Number;
		
		public function Slider():void {
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0x222222;
			format.size = 11;
			
			field = new TextField();
			field.defaultTextFormat = format;
			field.type = TextFieldType.INPUT;
			field.width = 30;
			field.height = 16;
			field.background = true;
			field.border = true;
			field.text = "0";
			this.addChild(field);
			
			bar = new Sprite();
			bar.y = 7;
			this.addChild(bar);
			
			thumb = new Sprite();
			thumb.buttonMode = true;
			thumb.y = 13;
			var ma:Matrix = new Matrix();
			ma.createGradientBox(8, 12, 1.57, 0, -3);
			with (thumb.graphics) {
				beginGradientFill(GradientType.LINEAR, [0xEEEEEE, 0x999999], [1, 1], [0, 255], ma);
				lineStyle(1, 0x555555, 1, true);
				moveTo(8, 2);
				lineTo(8, -4);
				lineTo(4, -11);
				lineTo(0, -4);
				lineTo(0, 2);
				lineTo(8, 2);
				endFill();
			}
			this.addChild(thumb);
			
			this.width = 120;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, sliderOver, false, 0, true);
		}
		
		public function addListeners():void {
			this.addEventListener(MouseEvent.MOUSE_OVER, sliderOver);
		}
		
		public function killListeners():void {
			this.removeEventListener(MouseEvent.MOUSE_OVER, sliderOver);
		}
		
		private function update():void {
			field.x = this._width - _fieldWidth;
			draw();
		}
		
		private function draw():void {
			with (bar.graphics) {
				clear();
				beginFill(0xAAAAAA, 1);
				lineStyle(1, 0x777777, 1, true);
				drawRect(0, 0, _width - (_fieldWidth + 4), 3);
				endFill();
			}
			
			thumbEnd = this._width - (_fieldWidth + 10);
			thumb.x = thumbEnd * per;
		}
		
		private function setValue():void {
			_value = ((_max - _min) * per) + min;
			if (_integer) _value = int(_value);
			setDisplay();
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function setValueVar():void {
			var input:Number = _value;
			var perTemp:Number = (input - min) / (max - min);
			input = perTemp * (maxRange - minRange) + minRange;
			if (input > maxRange) {
				input = maxRange;
			}else if (input < minRange) {
				input = minRange
			}
			
			if (_integer) input = int(input);
			field.text = input.toString();
			
			perTemp = (input - minRange) / (maxRange - minRange);
			thumb.x = thumbEnd * perTemp;
			per = perTemp;
			setValue();
		}
		
		private function setDisplay():void {
			displayValue = ((_maxRange - _minRange) * per) + minRange;
			if (_integer) displayValue = int(displayValue);
			field.text = String(displayValue);
		}
		
		private function sliderOver(e:MouseEvent):void {
			switch(e.target) {
				case thumb:
					thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown, false, 0, true);
					thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbOut, false, 0, true);
				break;
				
				case bar:
					bar.addEventListener(MouseEvent.MOUSE_UP, barClick, false, 0, true);
					bar.addEventListener(MouseEvent.MOUSE_OUT, barOut, false, 0, true);
				break;
				
				case field:
					field.addEventListener(MouseEvent.MOUSE_DOWN, fieldClick, false, 0, true);
					field.addEventListener(MouseEvent.MOUSE_OUT, fieldOut, false, 0, true);
				break;
			}
			
			e.updateAfterEvent();
		}
		
		private function thumbOut(e:MouseEvent):void {
			thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbOut);
			
			e.updateAfterEvent();
		}
		
		private function thumbDown(e:MouseEvent):void {
			thumbOffset = this.mouseX - thumb.x;
			stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove, false, 0, true);
			
			e.updateAfterEvent();
		}
		
		private function thumbUp(e:MouseEvent):void {
			thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbOut);
			stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			
			e.updateAfterEvent();
		}
		
		private function thumbMove(e:MouseEvent):void {
			thumb.x = this.mouseX - thumbOffset;
			(thumb.x < 0) ? thumb.x = 0:thumb.x;
			(thumb.x > thumbEnd) ? thumb.x = thumbEnd:thumb.x;
			
			per = thumb.x / thumbEnd;
			setValue();
			
			e.updateAfterEvent();
		}
		
		private function barClick(e:MouseEvent):void {
			thumb.x = bar.mouseX;
			(thumb.x < 0) ? thumb.x = 0:thumb.x;
			(thumb.x > thumbEnd) ? thumb.x = thumbEnd:thumb.x;
			per = thumb.x / thumbEnd;
			setValue();
			
			e.updateAfterEvent();
		}
		
		private function barOut(e:MouseEvent):void {
			bar.removeEventListener(MouseEvent.MOUSE_UP, barClick);
			bar.removeEventListener(MouseEvent.MOUSE_OUT, barOut);
			
			e.updateAfterEvent();
		}
		
		private function fieldClick(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.CLICK, fieldExit, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, onEnterUp);
			
			e.updateAfterEvent();
		}
		
		private function fieldOut(e:MouseEvent):void {
			field.removeEventListener(MouseEvent.MOUSE_DOWN, fieldClick);
			field.removeEventListener(MouseEvent.MOUSE_OUT, fieldOut);
			
			e.updateAfterEvent();
		}
		
		private function onEnterUp(e:KeyboardEvent):void {
			if(e.keyCode == 13){
				stage.removeEventListener(MouseEvent.CLICK, fieldExit);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onEnterUp);
				fieldChange();
			}
		}
		
		private function fieldExit(e:MouseEvent):void {
			if (e.target != field) {
				stage.removeEventListener(MouseEvent.CLICK, fieldExit);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onEnterUp);
				fieldChange();
			}
			
			e.updateAfterEvent();
		}
		
		private function fieldChange():void {
			var input:Number = Number(field.text);
			if (input > maxRange) {
				input = maxRange;
			}else if (input < minRange) {
				input = minRange
			}
			
			if (_integer) input = int(input);
			field.text = input.toString();
			
			var perTemp:Number = (input - minRange) / (maxRange - minRange);
			thumb.x = thumbEnd * perTemp;
			per = perTemp;
			setValue();
		}
	}
	
}