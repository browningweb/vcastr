package src.com.ruochi.video {
	import flash.display.Sprite;
	import gs.TweenLite;
	import com.ruochi.video.VcastrConfig;
	public class TextItemList extends Sprite{
		private var _dataXml:XML
		private var _length:int;
		public function TextItemList(xml:XML) {
			_dataXml = xml;
			init();
		}		
		
		private function init():void{
			_length:int = _dataXml.channel.item.length();
			for (var i:int = 0; i < _length; i++) {
				var textItem:TextItem = new TextItem();
				textItem.text = _dataXml.channel.item[i].title[0];
			}
		}
		public function open():void {
			for (var i:int = 0; i < _length; i++) {
				TweenLite.to(getChildAt(i), .5 { y: -i * VcastrConfig.textItemHeight } ); 
			}
			
		}
		public function close():void {
			for (var i:int = 0; i < _length; i++) {
				TweenLite.to(getChildAt(i), .5 { y: -i * VcastrConfig.textItemHeight } ); 
			}
		}
	}	
}