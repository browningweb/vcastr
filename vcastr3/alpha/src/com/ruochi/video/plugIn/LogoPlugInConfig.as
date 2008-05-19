package com.ruochi.video.plugIn {
	import com.ruochi.layout.Margin;
	public class LogoPlugInConfig {
		public static var logoText:String = "";
		public static var logoTextAlpha:Number = .75;
		public static var logoTextFontSize:int = 24;
		public static var logoTextColor:uint = 0xffffff;
		public static var logoTextMargin:Margin = new Margin(10, null, null, 10);
		public static var logoClipUrl:String;
		public static var logoClipAlpha:Number = 1;
		public static var logoClipMargin:Margin = new Margin(10, 10, null, null);
		public static var url:String;
		/*public static function set logoClipMargin(m:Margin):void {
			var array:Array = str.split(" ");
			_logoClipMargin = new Margin(array[0], array[1], array[2], array[3]);
		}
		public static function get logoClipMargin():Margin {
			return _logoClipMargin;
		}
		public static function get logoTextMargin():Margin {
			return _logoTextMargin;
		}
		public static function set logoTextMargin(m:Margin):void {
			_logoTextMargin = m;
		}*/
		public static function set textMargin(s:String) {
			logoTextMargin = new Margin(s);
		}
		public static function set clipMargin(s:String) {
			logoClipMargin = new Margin(s);
		}
	}	
}
