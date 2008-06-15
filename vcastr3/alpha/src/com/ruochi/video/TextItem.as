package src.com.ruochi.video {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import com.ruochi.text.StyleText;
	import com.ruochi.shape.Rect;
	import com.ruochi.video.VcastrConfig;
	public class TextItem extends Sprite{
		private var _styleText:StyleText = new StyleText();
		private var _bg:Rect = new Rect(100,24,VcastrConfig.controlPanelBgColor);
		public function TextItem() {
			init();
		}
		private function init():void {
			setChildren();
			addChildren();
		}
		
		private function addChildren():void{
			addChild(_bg);
			addChild(_styleText);			
		}
		
		private function setChildren():void{
			_styleText.x = 5;
			_styleText.y = 2;
			_styleText.align = "right";
		}
		public function set text(s:String):void {
			_styleText.text = s;
			_bg.width = _styleText.width +10;
		}
		override public function set width(value:Number):void {
			_bg.width = value;
			_styleText.width = value -10;
		}
	}	
}
