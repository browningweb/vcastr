package com.ruochi.video {
	import flash.display.Sprite;
	import gs.TweenLite;
	import com.ruochi.video.VcastrConfig;
	public class TextItemList extends Sprite{
		private var _dataXml:XML
		private var _length:int;
		private var _isOpen:Boolean;
		public function TextItemList(xml:XML) {
			_dataXml = xml;
			init();
		}		
		
		private function init():void {
			_length = _dataXml.channel.item.length();
			var maxW:int = 0;
			var textItem:TextItem;
			for (var i:int = 0; i < _length; i++) {
				textItem = new TextItem();
				textItem.text = _dataXml.channel.item[i].title[0];
				addChild(textItem);
				if (textItem.width > maxW) {
					maxW = textItem.width;
				}
			}
			for ( var i:int = 0; i < _length; i++) {
				textItem = getChildAt(i) as TextItem;
				textItem.width = maxW;
			}
		}
		public function open():void {
			for (var i:int = 0; i < _length; i++) {
				TweenLite.to(getChildAt(i), .5, { y: -i * VcastrConfig.textItemHeight } ); 
			}
			_isOpen = true;
		}
		public function close():void {
			for (var i:int = 0; i < _length; i++) {
				TweenLite.to(getChildAt(i), .5, { y: -i * VcastrConfig.textItemHeight } ); 
			}
			_isOpen = false;
		}
		public function get isOpen():Boolean {
			return _isOpen;
		}
	}	
}