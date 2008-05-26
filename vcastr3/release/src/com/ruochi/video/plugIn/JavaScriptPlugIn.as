package com.ruochi.video.plugIn {
	import com.ruochi.video.Vcastr3;
	import flash.display.Sprite;
	import com.ruochi.video.VideoEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	public class JavaScriptPlugIn extends Sprite implements IVcastrPlugIn {
		private var _vcastr3:Vcastr3;
		public function JavaScriptPlugIn() {
			Security.allowDomain("*");
		}
		public function set dataXml(xml:XML):void {
			
		}
		public function init(vcastr3:Vcastr3):void {
			_vcastr3 = vcastr3;
			configListener();
			addCallBack();
		}
		private function configListener():void {
			_vcastr3.addEventListener(VideoEvent.STATE_CHANGE, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.COMPLETE, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.INIT, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.READY, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.PLAYHEAD_UPDATE, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.START_BUFFERING, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.STOP_BUFFERING, onVideoEvent, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.STOP, onVideoEvent, false, 0, true);			
		}		
		private function onVideoEvent(e:Event):void {
			ExternalInterface.call("vcastrEvent", e.type,_vcastr3.videoPlayer.state, _vcastr3.videoPlayer.playheadTime, _vcastr3.videoPlayer.bytesLoaded/_vcastr3.videoPlayer.bytesTotal);
		}
		private function playPause():void {
			_vcastr3.playPause();
		}
		private function play():void {
			_vcastr3.play();
		}
		private function pause():void {
			_vcastr3.pause();
		}
		private function stop():void {
			_vcastr3.stop();
		}
		private function ff():void {
			_vcastr3.ff();
		}
		private function rew():void {
			_vcastr3.rew();
		}
		private function next():void {
			_vcastr3.next();
		}
		private function prev():void {
			_vcastr3.prev();
		}
		private function volumeTo(value:Number) {
			_vcastr3.voluemTo(value);
		}
		private function playerSizeTo(w:Number, h:Number):void {
			_vcastr3.playerSizeTo(w, h);
		}
		private function playerMoveTo(px:Number, py:Number):void {
			_vcastr3.playerMoveTo(px, py);
		}
		private function seek(offset:Number):void {
			_vcastr3.seek(offset);
		}
		public function addCallBack():void {
			 ExternalInterface.addCallback("play", play);
			 ExternalInterface.addCallback("pause", pause);
			 ExternalInterface.addCallback("playPause", playPause);
			 ExternalInterface.addCallback("stop", stop);
			 ExternalInterface.addCallback("ff", ff);
			 ExternalInterface.addCallback("rew", rew);
			 ExternalInterface.addCallback("next", next);
			 ExternalInterface.addCallback("prev", prev);
			 ExternalInterface.addCallback("volumeTo", volumeTo);
			 ExternalInterface.addCallback("playerSizeTo", playerSizeTo);
			 ExternalInterface.addCallback("playerMoveTo", playerMoveTo);
			 ExternalInterface.addCallback("seek", seek);			 
		}
	}	
}