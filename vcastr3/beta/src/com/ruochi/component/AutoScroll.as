package com.ruochi.component{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	public class AutoScroll extends EventDispatcher {
		public static const HORIZON:String = "horizon";
		public static const VERTICAL:String = "vertical";
		private var _content:DisplayObject;
		private var _mask:Shape;
		private var _direction:String;
		private var _maxSpeed:Number;
		private var _easeSpeed:Number = 3;
		private var _isEnterFrame:Boolean = false;
		public function AutoScroll(content:DisplayObject, mask:Shape, direction:String, maxSpeed:Number = 32 ) {
			_content = content;
			_mask = mask;
			_direction = direction;
			_maxSpeed = maxSpeed;
			init();
		}
		
		private function init():void {
			
			addListeners();
		}
		
		private function addListeners():void {
			if(_mask.stage){
				_mask.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMaskMouseMove);
			}else {
				_mask.addEventListener(Event.ADDED_TO_STAGE, onMaskAddToStage, false, 0, true);
			}
		}
		
		private function onMaskAddToStage(e:Event):void {
			_mask.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMaskMouseMove);
		}
		
		private function onMaskMouseMove(e:MouseEvent):void {
			if(_mask.hitTestPoint(_mask.stage.mouseX,_mask.stage.mouseY)){
				if(!_isEnterFrame){
					_mask.addEventListener(Event.ENTER_FRAME, onMaskEnterFrame);
					_isEnterFrame = true
				}
			}
		}		
		private function onMaskEnterFrame(e:Event):void {
			var mouseOffset:Number;
			if (_direction == VERTICAL) {
				mouseOffset = (_mask.height/2 - _mask.mouseY)/(_mask.height / 2);
				var gy:Number = _content.y + mouseOffset * _maxSpeed;
				if (gy > _mask.y) {
					gy = _mask.y;
				}else if(gy + _content.height< _mask.y + _mask.height) {
					gy = _mask.y + _mask.height - _content.height;
				}
				
				if (Math.abs(gy - _content.y) < .1) {
					_content.y = gy;
					removeEnterFrame();
				}else {
					_content.y += (gy - _content.y) / _easeSpeed;
				}				
			}else {
				mouseOffset = (_mask.width / 2 - _mask.mouseX)/(_mask.width / 2);
				var gx:Number = _content.x + mouseOffset * _maxSpeed;
				if (gx > _mask.x) {
					gx = _mask.x;
				}else if(gx + _content.width< _mask.x + _mask.width) {
					gx = _mask.x + _mask.width - _content.width;
				}
				
				if (Math.abs(gx - _content.x) < .1) {
					_content.x = gx;
					removeEnterFrame();					
				}else {
					_content.x += (gx - _content.x) / _easeSpeed;
				}	
			}
		}
		private function removeEnterFrame():void {
			_mask.removeEventListener(Event.ENTER_FRAME, onMaskEnterFrame);
			_isEnterFrame = false;
		}
	}
}