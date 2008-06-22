package com.ruochi.video.plugIn {
	import com.ruochi.sprites.RectSprite;
	import com.ruochi.video.Controller;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ruochi.layout.place;
	import com.ruochi.utils.xmlToVar;
	import com.ruochi.text.EmbedText;
	import com.ruochi.video.plugIn.LogoPlugInConfig;
	import com.ruochi.video.VideoEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	public class LogoPlugIn extends Sprite implements IVcastrPlugIn{
		private var _logoText:EmbedText = new EmbedText();
		private var _logoClipSprite:Sprite = new Sprite;
		private var _rect:RectSprite = new RectSprite();
		private var _logoTextWrapper:Sprite = new Sprite();
		private var _dataXml:XML;
		private var _controller:Controller;
		public function LogoPlugIn() {
			
		}
		public function set dataXml(xml:XML):void {
			_dataXml = xml;
		}
		public function init(controller:Controller):void {
			_controller = controller;			
			xmlToVar(_dataXml, LogoPlugInConfig); 
			if (LogoPlugInConfig.logoText != "") {				
				_logoText.embedFonts = true;
				_logoText.text = LogoPlugInConfig.logoText;
				_logoText.alpha = LogoPlugInConfig.logoTextAlpha;
				_logoText.size = LogoPlugInConfig.logoTextFontSize;
				_logoText.color = LogoPlugInConfig.logoTextColor;
				_logoTextWrapper.addChild(_logoText);
				addChild(_logoTextWrapper);
				if (LogoPlugInConfig.logoTextLink != "") {
					_rect.alpha = 0;
					_rect.width = _logoText.width;
					_rect.height = _logoText.height;
					_logoTextWrapper.addChild(_rect);
					_logoTextWrapper.buttonMode = true; trace(LogoPlugInConfig.logoTextLink)
					_logoTextWrapper.useHandCursor =  true;
					_logoTextWrapper.addEventListener(MouseEvent.CLICK, onLogoTextWrapperClick, false, 0, true);
				}
				setLayout();
			}
			if (LogoPlugInConfig.logoClipUrl) {
				addChild(_logoClipSprite);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete, false, 0, true);
				loader.load(new URLRequest(LogoPlugInConfig.logoClipUrl));
			}
			Controller.instance.addEventListener(VideoEvent.LAYOUT_CHANGE, onVcastrLayoutChange, false, 0, true);
		}		
		
		private function onVcastrLayoutChange(e:Event):void {
			setLayout();
		}
		public function setLayout():void {
			place(_logoTextWrapper, LogoPlugInConfig.logoTextMargin, _controller.videoPlayer);
			place(_logoClipSprite, LogoPlugInConfig.logoClipMargin, _controller.videoPlayer);
		}
		
		private function onLoaderComplete(e:Event):void {
			var displayObject:DisplayObject = (e.target as LoaderInfo).loader.content as DisplayObject
			if (displayObject is Bitmap) {
				(displayObject as Bitmap).smoothing = true;
			}
			_logoClipSprite.addChild(displayObject);
			_logoClipSprite.alpha = LogoPlugInConfig.logoClipAlpha;			
			if (LogoPlugInConfig.logoClipLink != "") {
				_logoClipSprite.buttonMode = true;
				_logoClipSprite.addEventListener(MouseEvent.CLICK, onlogoSpriteClick, false, 0, true);
			}
			setLayout();
		}
		
		private function onlogoSpriteClick(e:MouseEvent):void {
			navigateToURL(new URLRequest(LogoPlugInConfig.logoClipLink), LogoPlugInConfig.windowOpen);
		}
		
		private function onLogoTextWrapperClick(e:MouseEvent):void {
			navigateToURL(new URLRequest(LogoPlugInConfig.logoTextLink), LogoPlugInConfig.windowOpen);
		}
	}	
}