package com.ruochi.video {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import com.ruochi.text.StyleText;
	import com.ruochi.shape.Rect;
	import com.ruochi.video.VcastrConfig;
	public class TextItem extends Sprite {
		private var _isActive:Boolean;
		private var _styleText:StyleText = new StyleText();
		private var _bg:Rect = new Rect(100,VcastrConfig.textItemHeight,VcastrConfig.controlPanelBgColor);
		public function TextItem() {
			init();
		}
		private function init():void {
			setChildren();
			addChildren();
			configeListener();
		}
		
		private function configeListener():void{
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
		}
		
		private function onMouseOut(e:MouseEvent):void {
			if (_isActive) {
				_bg.alpha = .5;
			}else {
				_bg.alpha = .7;
			}
		}
		
		private function onMouseOver(e:MouseEvent):void {
			_bg.alpha = .8
		}
		
		private function addChildren():void{
			addChild(_bg);
			addChild(_styleText);			
		}
		
		private function setChildren():void {
			visible = false;
			alpha = 0;
			_bg.alpha = VcastrConfig.controlPanelAlpha;
		}
		
		public function set text(s:String):void {
			_styleText.text = s;
			_bg.width = _styleText.width +10;
		}
		override public function set width(value:Number):void { 
			_bg.width = value;
			_bg.x = - _bg.width;
			_styleText.x =  - _styleText.width - 5;
		}
		public function get styleText():StyleText {
			return _styleText
		}
		public function set isActive(b:Boolean):void {
			_isActive = b;
			mouseEnabled = !_isActive;
			alpha = .5;
		}
	}	
}
