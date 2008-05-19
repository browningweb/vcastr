package com.ruochi.video {	
	import com.ruochi.utils.replaceHat;
	public dynamic class VcastrConfig {
		private static var _source:String;		
		private static var _dataXml:XML;
		private static function buildXml(str:String,tag:String) {
			var fileArray:Array = str.split("|");
			if(_dataXml==null){
				_dataXml = new XML("<vcastr/>");
			}
			for (var i:int = 0; i < fileArray.length; i++) {
				if (_dataXml.item[i] == undefined || _dataXml.item[i]=="") {
					_dataXml.item[i] = new XML("<item/>");					
					_dataXml.item[i].child(tag)[0] = fileArray[i];
				}
			}
		}
		public static const FLOAT:String = "float";
		public static const NORMAL:String = "normal";
		public static const BOTTOM:String = "bottom";
		public static const NONE:String = "none";
		public static var isLoadBegin:Boolean = true;
		public static var scaleMode = ScaleUtils.SHOW_ALL;
		public static function set source(str:String):void {
			_source = replaceHat(str);
			buildXml(str, "source");
		}
		public static function set duration(str:String):void {
			buildXml(str, "duration");
		}
		public static var isShowAbout:Boolean = true;
		public static var xml:String = "vcastr.xml";
		public static var plugIn:String;
		/*public static function get plugIn():Array {
			if (_plugIn != "") {				
				var array:Array =  _plugIn.split(",");
				return array; 
			}else {
				return null;
			}
		}
		public static function set plugIn(str:String):void {
			_plugIn = replaceHat(str);
		}*/
		
		public static function get dataXml():XML {
			return _dataXml;
		}
		public static function set dataXml(xml:XML):void {
			_dataXml = xml;
		}
		public static var defautVolume:Number = .8;
		public static var isAutoPlay:Boolean = true;
		public static var bufferTime:Number = 4;
		public static var controlPanelMode:String = FLOAT;
		public static var controlPanelBgColor:uint = 0xff6600;
		public static var controlPanelBtnColor:uint = 0xffffff;
		public static var controlPanelBtnGlowColor:uint = 0xffff00;
		public static var controlPanelAlpha = .75;
	}	
}