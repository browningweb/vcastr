package com.ruochi.video {
	import com.ruochi.component.SimpleAlert;
	import com.ruochi.video.Controller;
	import com.ruochi.video.VideoPlayer;
	import flash.system.Security;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	public class Vcastr3 extends Sprite {
		private static var _instance:Vcastr3;
		public function Vcastr3() {
			if (!_instance) {
				_instance = this;			
				init();
			}else {
				throw new Error("singleton");
			}
		}
		public function init():void {
			Security.allowDomain("*");			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.addChild(SimpleAlert.instance);
			addChild(VideoPlayer.instance);
			Controller.instance.loadConfig(loaderInfo.parameters["xml"]);trace(loaderInfo.parameters["xml"],'----')
			stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
		}
		
		private function onStageResize(e:Event):void {
			Controller.instance.setLayout();
		}
		/*private function startUp(xml:XML):void {
			VcastrConfig.dataXml = xml;
			if (VcastrConfig.dataXml.channel.item.length() > 1) {
				VcastrConfig.isMulitVideo = true;
			}
			xmlToVar(VcastrConfig.dataXml.config[0], VcastrConfig);								
			loadPlugIns();
		}
		private function checkInit():void {
			if (_unLoadPlugInsNum == 0 && VcastrConfig.dataXml) {
				run();	
				dispatchEvent(new VideoEvent(VideoEvent.INIT, false, false, videoPlayer.state, videoPlayer.playheadTime));
			}			
		}
		
		
		private function loadPlugIns():void {
			var length:int = VcastrConfig.dataXml.plugIns.*.length();
			_unLoadPlugInsNum = length;
			for (var i:int = 0; i < length; i++) {
				var loader:Loader = new Loader();
				loader.name = String(i);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete, false, 0, true)
				loader.load(new URLRequest(VcastrConfig.dataXml.plugIns.*[i].url[0]));
			}
			checkInit();
		}
		private function onLoaderComplete(e:Event):void {
			addChild(e.target.loader.content);
			var plugIn:IVcastrPlugIn = (e.target as LoaderInfo).loader.content as IVcastrPlugIn
			plugIn.dataXml = VcastrConfig.dataXml.plugIns.*[int(e.target.loader.name)];
			plugIn.init(this);
			_unLoadPlugInsNum--;
			checkInit();
		}
		private function run():void {		
			
		}
		
		public function get dataXml():XML {
			return VcastrConfig.dataXml;
		}
		public function get videoXml():XML {
			return _videoXml;
		}
		public function get playheadTime():Number {
			return videoPlayer.playheadTime;
		}
		public function get totalTime():Number {
			return videoPlayer.totalTime;
		}
		public function get bytesLoaded():Number {
			return videoPlayer.bytesLoaded;
		}
		public function get bytesTotal():Number {
			return videoPlayer.bytesTotal;
		}
		public function playerSizeTo(w:int,h:int):void {
			_videoPlayer.setSize(w, h);
			dispatchEvent(new VideoEvent(VideoEvent.LAYOUT_CHANGE, false, false, videoPlayer.state, videoPlayer.playheadTime));
		}
		public function playerMoveTo(px:int,py:int):void {
			_videoPlayer.x = px;
			_videoPlayer.y = py;			
			dispatchEvent(new VideoEvent(VideoEvent.LAYOUT_CHANGE, false, false, videoPlayer.state, videoPlayer.playheadTime));
		}*/
		static public function get instance():Vcastr3 {
			return _instance;
		}
	}
}