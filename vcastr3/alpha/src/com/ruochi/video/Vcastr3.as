package com.ruochi.video{
	import com.ruochi.utils.about;
	import com.ruochi.video.CenterBtn;
	import com.ruochi.video.DefaultControlPanel;
	import com.ruochi.utils.defaultBoolean;
	import com.ruochi.utils.defaultNum;
	import com.ruochi.utils.defaultString
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.ruochi.net.CrossURLLoader;
	import com.ruochi.component.SimpleAlert;
	import com.ruochi.video.VcastrConfig;
	import com.ruochi.utils.paramToVar;
	import com.ruochi.video.VideoPlayer;
	import com.ruochi.video.VideoEvent;
	import com.ruochi.utils.xmlToVar;
	import com.ruochi.utils.replaceHat;
	import com.ruochi.video.plugIn.IVcastrPlugIn;
	import flash.system.Security;
	public class Vcastr3 extends Sprite {
		private var _videoPlayer:VideoPlayer = new VideoPlayer();
		private var _unLoadPlugInsNum:int;
		private var _videoXml:XML;
		private var _activeVideoId:int = 0;
		private var _defaultControlPanel:DefaultControlPanel;
		private var _centerBtn:CenterBtn = new CenterBtn();
		public function Vcastr3() {
			init();
		}
		private function init():void {
			Security.allowDomain("*");
			addChild(_videoPlayer);			
			stage.addChild(SimpleAlert.instance);			
			if (loaderInfo.parameters["xml"]) {
				var xmlStr = replaceHat(String(loaderInfo.parameters["xml"]));
				var dataXml = new XML(xmlStr); 
				if (dataXml.channel.item.source.length()>0) {
					VcastrConfig.dataXml = dataXml;
					xmlToVar(VcastrConfig.dataXml.config[0], VcastrConfig);										
					loadPlugIns();
				}else {
					VcastrConfig.xml = xmlStr;
				}
			}
			if (VcastrConfig.dataXml==null) {
				var xmlLoader:CrossURLLoader = new CrossURLLoader();
				xmlLoader.addEventListener(Event.COMPLETE, onXmlLoaderComplete, false, 0, true);
				xmlLoader.crossLoad(new URLRequest(VcastrConfig.xml));
			}
		}
		private function checkInit():void {
			if (_unLoadPlugInsNum == 0 && VcastrConfig.dataXml) {
				run();	
				dispatchEvent(new VideoEvent(VideoEvent.INIT, false, false, videoPlayer.state, videoPlayer.playheadTime));
			}			
		}
		private function configListener():void {
			_videoPlayer.addEventListener(VideoEvent.STATE_CHANGE, onVideoPlayerStateChange, false, 0, true);
			_videoPlayer.addEventListener(VideoEvent.COMPLETE, onVideoPlayerComplete, false, 0, true);
			_videoPlayer.addEventListener(VideoEvent.READY, onVideoPlayerReady, false, 0, true);
			_videoPlayer.addEventListener(VideoEvent.PLAYHEAD_UPDATE, onVideoPlayerPlayHeadUpdate, false, 0, true);
			_videoPlayer.addEventListener(VideoEvent.PROGRESS, onVideoPlayerProgress, false, 0, true);
			_videoPlayer.addEventListener(VideoEvent.START_BUFFERING, onVideoPlayerStartBuffering, false, 0 , true);
			_videoPlayer.addEventListener(VideoEvent.STOP_BUFFERING, onVideoPlayerStopBuffering, false, 0, true);
			_videoPlayer.addEventListener(VideoEvent.STOP, onVideoPlayerStop, false, 0, true);
		}
		
		private function onVideoPlayerStop(e:VideoEvent):void {
			dispatchEvent(e);
		}
		
		private function onVideoPlayerStopBuffering(e:VideoEvent):void {
			dispatchEvent(e);
		}
		
		private function onVideoPlayerStartBuffering(e:VideoEvent):void {
			dispatchEvent(e);
		}
		private function onVideoPlayerProgress(e:VideoEvent) {
			dispatchEvent(e);
		}
		private function onVideoPlayerPlayHeadUpdate(e:VideoEvent) {
			dispatchEvent(e);
		}
		private function onXmlLoaderComplete(e:Event) {
			VcastrConfig.dataXml = new XML(e.target.data);
			xmlToVar(VcastrConfig.dataXml.config[0],VcastrConfig)			
			loadPlugIns();
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
		private function onLoaderComplete(e:Event) {
			addChild(e.target.loader.content);
			var plugIn:IVcastrPlugIn = (e.target as LoaderInfo).loader.content as IVcastrPlugIn
			plugIn.dataXml = VcastrConfig.dataXml.plugIns.*[int(e.target.loader.name)];
			plugIn.init(this);
			_unLoadPlugInsNum--;
			checkInit();
		}
		private function run():void {		
			_videoXml = VcastrConfig.dataXml.channel.item[_activeVideoId];	
			addChild(_centerBtn);
			configListener();
			if (VcastrConfig.controlPanelMode!=VcastrConfig.NONE) {
				_defaultControlPanel = new DefaultControlPanel();
				addChild(_defaultControlPanel);				
			}
			if (VcastrConfig.isShowAbout) {
				about(this, "About Vcastr 3.0", "http://code.google.com/p/vcastr/");
			}
			_videoPlayer.dataXml =  _videoXml;
		}
		private function onVideoPlayerStateChange(e:VideoEvent):void { 
			dispatchEvent(new VideoEvent(e.state, false, false, e.state, e.playheadTime));
		}
		private function onVideoPlayerComplete(e:VideoEvent):void {
			next();
			dispatchEvent(e);
		}
		private function onVideoPlayerReady(e:VideoEvent):void {
			dispatchEvent(e);
		}
		public function playPause():void {
			_videoPlayer.playPause();
		}
		public function play() {
			_videoPlayer.play();
		}
		public function pause():void {
			_videoPlayer.pause();
		}
		public function stop():void {
			_videoPlayer.stop();
		}
		public function ff():void {
			_videoPlayer.ff();
		}
		public function rew():void {
			_videoPlayer.rew();
		}
		public function voluemTo(value:Number):void {
			_videoPlayer.volume = value;
		}
		public function get videoPlayer():VideoPlayer {
			return _videoPlayer;
		}
		public function seek(offset:Number):void {
			_videoPlayer.seek(offset);
		}
		public function next():void {
			if (_activeVideoId < VcastrConfig.dataXml.channel.item.length()-1) {
				_activeVideoId++
				_videoXml = VcastrConfig.dataXml.channel.item[_activeVideoId];				
				VcastrConfig.isAutoPlay = true;
				_videoPlayer.dataXml =  _videoXml;
			}
		}
		public function prev():void {
			if (_activeVideoId > 0) {
				_activeVideoId--
				_videoXml = VcastrConfig.dataXml.channel.item[_activeVideoId];				
				VcastrConfig.isAutoPlay = true;
				_videoPlayer.dataXml =  _videoXml;
			}
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
		}
	}
}