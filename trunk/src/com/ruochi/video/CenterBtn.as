package com.ruochi.video {
	import com.ruochi.shape.player.PauseShape;
	import com.ruochi.shape.player.PlayShape;
	import com.ruochi.shape.Rect;
	import com.ruochi.layout.setCenter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	import com.ruochi.video.IconGlowBtn;
	import com.ruochi.video.Vcastr3;
	import gs.TweenLite;
	import com.ruochi.utils.cover;
	import com.ruochi.video.VideoEvent;
	import com.ruochi.component.StripeProgressBar;	
	public class CenterBtn extends Sprite {
		private var _playPauseBtn:IconGlowBtn = new IconGlowBtn();
		private var _vcastr3:Vcastr3;
		private var _bg:Rect = new Rect(100, 100, 0);
		private var _isBgDoubleClick:Boolean = false;
		private var _progressBar:StripeProgressBar = new StripeProgressBar(60,10);
		public function CenterBtn() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		private function onAddedToStage(e:Event):void {
			init();
		}
		private function init():void {
			_vcastr3 = parent as Vcastr3;
			buildUI();
			configListener();
		}
		private function buildUI():void {
			_playPauseBtn.icon = new PlayShape();
			_playPauseBtn.icon = new PauseShape();
			_playPauseBtn.scaleX = _playPauseBtn.scaleY = 2;
			_bg.alpha = 0;
			_progressBar.stripeShape.alpha = .5;
			addChild(_bg)
			addChild(_progressBar);
			addChild(_playPauseBtn);
			setLayout();
		}
		private function setLayout():void {
			_bg.width = _vcastr3.videoPlayer.playerWidth;
			_bg.height = _vcastr3.videoPlayer.playerHeight;
			setCenter(_playPauseBtn, _bg);
			setCenter(_progressBar, _bg);
			_progressBar.y = _playPauseBtn.y + 40;
			//_playPauseBtn.x += _bg.x;
			//_playPauseBtn.y += _bg.y;
		}
		private function configListener():void {
			_vcastr3.addEventListener(VideoEvent.LAYOUT_CHANGE, onVcastrLayoutChange, false, 0, true);			
			_vcastr3.videoPlayer.addEventListener(VideoEvent.STATE_CHANGE, onVideoPlayerStateChange, false, 0, true);
			_vcastr3.videoPlayer.addEventListener(VideoEvent.START_BUFFERING, onVideoPlayerStartBuffering, false, 0, true);
			_vcastr3.videoPlayer.addEventListener(VideoEvent.STOP_BUFFERING, onVideoPlayerStopBuffering, false, 0, true);
			_bg.addEventListener(MouseEvent.CLICK, onBgClick, false, 0, true);
			_bg.doubleClickEnabled = true;
			_bg.addEventListener(MouseEvent.DOUBLE_CLICK, onBgDoubleClick, false, 0, true);
			_playPauseBtn.addEventListener(MouseEvent.CLICK, onPlayPauseBtnClick, false, 0, true);
		}
		
		private function onVideoPlayerStateChange(e:VideoEvent):void {
			if (e.state == VideoEvent.PLAYING) {
				turnOff()
			}else {
				turnOn();
			}
		}
		
		private function onVideoPlayerStopBuffering(e:VideoEvent):void {
			_progressBar.stop();
		}
		
		private function onVideoPlayerStartBuffering(e:VideoEvent):void {
			_progressBar.start();
		}
		private function onBgClick(e:MouseEvent):void {
			TweenLite.killDelayedCallsTo(delayBgClick);
			TweenLite.delayedCall(.3,delayBgClick);
		}
		private function delayBgClick():void {
			if (!_isBgDoubleClick) {
				_vcastr3.videoPlayer.playPause();
			}
			_isBgDoubleClick = false;
		}
		private function onBgDoubleClick(e:MouseEvent):void {			
			_isBgDoubleClick = true;
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		private function onPlayPauseBtnClick(e:MouseEvent):void {
			_vcastr3.videoPlayer.playPause();
		}
		private function onVcastrLayoutChange(e:Event):void {
			setLayout();
		}
		private function turnOn():void {
			_playPauseBtn.frame = 1;
			_playPauseBtn.visible = true;
		}
		private function turnOff():void {
			_progressBar.stop();
			_playPauseBtn.frame = 2;
			_playPauseBtn.visible = false;
		}
	}	
}