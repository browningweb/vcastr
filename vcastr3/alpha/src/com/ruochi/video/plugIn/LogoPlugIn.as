package com.ruochi.video.plugIn {
	import flash.text.TextField;
	import com.ruochi.video.Vcastr3;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	import flash.events.Event;
	import com.ruochi.layout.place;
	import com.ruochi.utils.xmlToVar;
	import com.ruochi.text.EmbedText;
	import com.ruochi.video.plugIn.LogoPlugInConfig;
	import com.ruochi.video.VideoEvent;
	import flash.net.URLRequest;
	public class LogoPlugIn extends Sprite implements IVcastrPlugIn{
		private var _logoText:EmbedText = new EmbedText();
		private var _logoSprite:Sprite = new Sprite;
		private var _dataXml:XML;
		private var _vcastr3:Object;
		public function LogoPlugIn() {
			
		}
		public function set dataXml(xml:XML):void {
			_dataXml = xml;
		}
		public function init(vcastr3:Vcastr3):void {
			_vcastr3 = vcastr3;
			
			xmlToVar(_dataXml, LogoPlugInConfig); 
			if (LogoPlugInConfig.logoText != "") {
				
				_logoText.embedFonts = true;
				_logoText.text = LogoPlugInConfig.logoText;
				_logoText.alpha = LogoPlugInConfig.logoTextAlpha;
				_logoText.size = LogoPlugInConfig.logoTextFontSize;
				_logoText.color = LogoPlugInConfig.logoTextColor;
				setLayout();
				addChild(_logoText);
			}
			if (LogoPlugInConfig.logoClipUrl) {
				addChild(_logoSprite);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete, false, 0, true);
				loader.load(new URLRequest(LogoPlugInConfig.logoClipUrl));
			}
			_vcastr3.addEventListener(VideoEvent.LAYOUT_CHANGE, onVcastrLayoutChange, false, 0, true);
		}		
		private function onVcastrLayoutChange(e:Event):void {
			setLayout();
		}
		public function setLayout():void {
			place(_logoText, LogoPlugInConfig.logoTextMargin, parent);
			place(_logoSprite, LogoPlugInConfig.logoClipMargin, _vcastr3.videoPlayer);
		}
		
		private function onLoaderComplete(e:Event):void {
			var displayObject:DisplayObject = (e.target as LoaderInfo).loader.content as DisplayObject
			if (displayObject is Bitmap) {
				(displayObject as Bitmap).smoothing = true;
			}
			_logoSprite.addChild(displayObject);
			_logoSprite.alpha = LogoPlugInConfig.logoClipAlpha;
			setLayout();
		}
	}	
}