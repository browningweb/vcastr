package com.ruochi.net {
	import flash.net.URLRequest;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoaderDataFormat;
	public class CrossURLLoader extends SafeURLLoader {
		private var _url:String;
		public var proxy:String = "http://www.ruochigroup.com/crossDomainProxy.php";
		public function CrossURLLoader() {			
			super();
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
		}
		public function crossLoad(request:URLRequest) {
			_url = request.url
			safeLoad(request);
		}
		private function securityErrorHandler(e:SecurityErrorEvent) {
			if(dataFormat==URLLoaderDataFormat.BINARY){
				_url=proxy + "?mimeType=binary&url=" + _url;
			}else{
				_url=proxy + "?url=" + _url;
			}
			load(new URLRequest(_url));
			//removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
	}
}