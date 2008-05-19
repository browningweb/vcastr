﻿package com.ruochi.net {
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	public class SafeLoader extends Loader {
		private var _url:String;
		private var _tryTime:int = 0;	
		public static var tryMax:int = 3;	
		public function SafeLoader() {			
			super();
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , errorHandler, false, 0, true);
		}
		public function safeLoad(request:URLRequest):void {
			_url = request.url;
			load(request);
		}
		private function errorHandler(e:IOErrorEvent) {
			if(_tryTime<tryMax){
				load(new URLRequest(_url));				
			}else {
				dispatchEvent(new Event("IOError"));
			}
			_tryTime++
		}
	}
}