package com.ruochi.video.plugIn {
	import com.ruochi.video.IController;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import com.ruochi.layout.place;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import com.ruochi.utils.xmlToVar;
	import com.ruochi.layout.ScaleUtils;
	import com.ruochi.video.VideoEvent;
	import com.ruochi.sprites.CropSprite;
	public class BeginEndImagePlugIn extends Sprite implements IVcastrPlugIn {
		public static const BEGIN:String = "begin";
		public static const END:String = "end";
		public static const BEGIN_AND_END:String = "beginAndEnd"
		private var _source:String;
		private	var _loader:Loader = new Loader();
		private var _dataXml:XML;
		private var _wrapper:Sprite = new Sprite();;
		private var _scaleType:String = ScaleUtils.SHOW_ALL;
		private var _displayObject:DisplayObject;
		private var _controller:IController;
		private var _type:String = BEGIN;
		public function BeginEndImagePlugIn() {
			
		}
		public function set dataXml(xml:XML):void {
			_dataXml = xml;
		}
		public function init(controller:IController):void {
			_controller = controller;
			_source = _dataXml.source[0];
			_type = _dataXml.type[0];
			_scaleType = _dataXml.scaleType[0];
			if (_source) {
				addChild(_wrapper);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete, false, 0, true);
				_loader.load(new URLRequest(_source));
			}
			if (_type == END ) {
				_wrapper.visible = false;
			}
			_controller.addEventListener(VideoEvent.LAYOUT_CHANGE, onVcastrLayoutChange, false, 0, true);			
			_controller.addEventListener(VideoEvent.PLAYING, onVcastrPlaying, false, 0, true);
			_controller.addEventListener(VideoEvent.LIST_COMPLETE, onVcastrListComplete, false, 0, true);
		}		
		
		private function onVcastrListComplete(e:VideoEvent):void {
			if(_type == END ||_type == BEGIN_AND_END){
				_wrapper.visible = true;
			}
		}
		private function onVcastrPlaying(e:VideoEvent):void {
			_wrapper.visible = false;
		}
		
		private function onVcastrLayoutChange(e:Event):void {			
			if(_displayObject){
				setLayout();
			}
		}
		public function setLayout():void {
			ScaleUtils.fill(_scaleType, _displayObject, _controller.videoPlayer.width, _controller.videoPlayer.height);
		}
		
		private function onLoaderComplete(e:Event):void {
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			if (loaderInfo.content is Bitmap) {
				_displayObject = loaderInfo.content;
				try {
					(_displayObject as Bitmap).smoothing = true;
				}catch (e:Error) {
					
				}
			}else {
				var cropSprite:CropSprite = new CropSprite(_loader.content, loaderInfo.width, loaderInfo.height);
				_displayObject =  cropSprite as DisplayObject;
			}
			_wrapper.addChild(_displayObject);
			setLayout();
		}
	}	
}