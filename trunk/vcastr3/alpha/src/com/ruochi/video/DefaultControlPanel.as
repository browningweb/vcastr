package com.ruochi.video {
	import com.ruochi.shape.player.FFShape;
	import com.ruochi.shape.player.FullScreenOffShape;
	import com.ruochi.shape.player.FullScreenOnShape;
	import com.ruochi.shape.player.OpenListShape;
	import com.ruochi.shape.player.PauseShape;
	import com.ruochi.shape.player.PlayShape;
	import com.ruochi.shape.player.RewShape;
	import com.ruochi.shape.player.SoundOffShape;
	import com.ruochi.shape.player.SoundOnShape;
	import com.ruochi.shape.Rect;
	import com.ruochi.text.EmbedText;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	import com.ruochi.video.Vcastr3;
	import com.ruochi.video.VcastrConfig;
	import com.ruochi.utils.formatTime;
	import gs.TweenLite;
	import com.ruochi.video.VideoEvent;
	public class DefaultControlPanel extends Sprite {
		private var _vcastr3:Vcastr3;
		private var _panelWidth:Number = 300;
		private var _panelHeight:Number = 17;
		private var _playPauseBtn:IconGlowBtn = new IconGlowBtn(_panelHeight,_panelHeight);
		private var _volumnBtn:IconGlowBtn = new IconGlowBtn(_panelHeight,_panelHeight);
		private var _fullScreenBtn:IconGlowBtn = new IconGlowBtn(_panelHeight, _panelHeight);
		private var _nextBtn:IconGlowBtn = new IconGlowBtn(_panelHeight, _panelHeight);
		private var _prevBtn:IconGlowBtn = new IconGlowBtn(_panelHeight, _panelHeight);
		private var _openListBtn:IconGlowBtn = new IconGlowBtn(_panelHeight, _panelHeight);
		private var _progressSlider:Slider = new Slider();
		private var _volumnSlider:Slider = new Slider(30);
		private var _currentTimeText:EmbedText = new EmbedText();
		private var _totalTimeText:EmbedText = new EmbedText();
		private var _bg:Rect = new Rect(_panelWidth, _panelHeight, VcastrConfig.controlPanelBgColor);
		private var _gap:Number = 5;
		private var _dataXml:XML;
		private var _defualtVoluem = .8;
		public function DefaultControlPanel() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		private function bulidUI():void {
			_playPauseBtn.icon = new PlayShape();
			_playPauseBtn.icon = new PauseShape();
			_volumnBtn.icon = new SoundOnShape();
			_volumnBtn.icon = new SoundOffShape();
			_fullScreenBtn.icon = new FullScreenOnShape();
			_fullScreenBtn.icon = new FullScreenOffShape();
			_nextBtn.icon = new FFShape();
			_prevBtn.icon = new RewShape();
			_openListBtn.icon = new OpenListShape();
			setTextField(_currentTimeText);
			setTextField(_totalTimeText);
			_bg.alpha = VcastrConfig.controlPanelAlpha;
			_volumnSlider.sliderWidth = 30;
			_volumnSlider.isSnap = true;			
			_volumnSlider.value = _defualtVoluem;		
			addChindren();
			setLayout();
		}
		private function setTextField(textField:EmbedText):void {
			textField.font = "SG16";
			textField.text = "00:00";
			textField.size = 10;
			textField.y = 2;
		}
		private function setLayout():void {
			_bg.width = _panelWidth;
			_playPauseBtn.x = _gap;
			_prevBtn.x = Math.round(_playPauseBtn.width + _playPauseBtn.x + _gap);
			_nextBtn.x = Math.round(_prevBtn.width + _prevBtn.x + _gap);
			if (VcastrConfig.isMulitVideo) {
				_currentTimeText.x = Math.round(_nextBtn.width + _nextBtn.x + _gap);
			}else {
				_currentTimeText.x = Math.round(_playPauseBtn.width + _playPauseBtn.x + _gap);
			}
			_progressSlider.x = Math.round(_currentTimeText.x + _currentTimeText.width );
			_openListBtn.x = Math.round(_panelWidth - _openListBtn.width - _gap);
			if (VcastrConfig.isMulitVideo) {
				_fullScreenBtn.x = Math.round(_openListBtn.x - _fullScreenBtn.width - _gap);
			}else{
				_fullScreenBtn.x = Math.round(_panelWidth - _fullScreenBtn.width - _gap);
			}
			_volumnSlider.x = Math.round(_fullScreenBtn.x - _volumnSlider.width - _gap);
			_volumnBtn.x =  Math.round(_volumnSlider.x - _volumnBtn.width);
			_totalTimeText.x = Math.round(_volumnBtn.x - _totalTimeText.width - _gap);
			_progressSlider.sliderWidth = Math.round(_totalTimeText.x - _currentTimeText.x -_currentTimeText.width-0);
			_volumnSlider.y = 4;
			_progressSlider.y = 4;
		}
		private function addChindren():void {
			addChild(_bg);
			addChild(_playPauseBtn);
			addChild(_volumnBtn);
			addChild(_fullScreenBtn);
			addChild(_progressSlider);
			addChild(_volumnSlider);
			addChild(_currentTimeText);
			addChild(_totalTimeText);
			if (VcastrConfig.isMulitVideo) {
				addChild(_nextBtn);
				addChild(_prevBtn);
				addChild(_openListBtn);
			}
		}
		private function configListener():void {			
			_playPauseBtn.addEventListener(MouseEvent.CLICK, onPlayPauseBtnClick, false, 0, true);
			_volumnBtn.addEventListener(MouseEvent.CLICK, onVolumnBtnClick, false, 0, true);
			_fullScreenBtn.addEventListener(MouseEvent.CLICK, onFullScreenBtnClick, false, 0, true);
			_progressSlider.addEventListener(Event.CHANGE, onProgressSliderChange, false, 0, true);
			_volumnSlider.addEventListener(Event.CHANGE, onVolumnSliderChange, false, 0, true);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onStageFullScreen, false, 0, true);
			if(VcastrConfig.controlPanelMode==VcastrConfig.FLOAT){
				stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseOver, false, 0, true);
			}
		}
		
		private function onStageMouseOver(e:MouseEvent):void {
			TweenLite.to(this, .5, { alpha:1 } );
		}
		
		private function onStageMouseLeave(e:Event):void {
			TweenLite.to(this, .5, { alpha:0 } );
		}
		private function onStageFullScreen(e:FullScreenEvent) {
			if (stage.displayState == StageDisplayState.NORMAL) {
				_fullScreenBtn.frame = 2;
			}else {
				_fullScreenBtn.frame = 1;
			}
		}
		private function configVcastr3Listener():void {
			_vcastr3.addEventListener(VideoEvent.INIT, onVcastrInit, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.PLAYHEAD_UPDATE, onVcastrPlayHeadUpdate, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.PAUSED, onVcastrPaused, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.STOP, onVcastrStopped, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.PLAYING, onVcastrPlaying, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.PROGRESS , onVcastrProgress, false, 0, true);
			_vcastr3.addEventListener(VideoEvent.COMPLETE, onVcastrComplete, false, 0, true);
		}
		private function onVcastrPaused(e:Event):void {
			_playPauseBtn.frame = 1;
		}
		private function onVcastrStopped(e:Event):void {
			_playPauseBtn.frame = 1;
		}
		private function onVcastrPlaying(e:Event):void {
			_playPauseBtn.frame = 2;
		}
		private function onVcastrInit(e:Event):void {
			configListener();
		}
		private function onVcastrPlayHeadUpdate(e:Event):void {
			_currentTimeText.text = formatTime(Math.round(_vcastr3.videoPlayer.playheadTime));
			_totalTimeText.text = formatTime(Math.round(_vcastr3.videoPlayer.totalTime));
			if (!_progressSlider.isDrag) {
				_progressSlider.value = _vcastr3.videoPlayer.playheadTime / _vcastr3.videoPlayer.totalTime;
			}	
		}
		private function onVcastrProgress(e:Event):void {
			_progressSlider.persent = _vcastr3.videoPlayer.bytesLoaded / _vcastr3.videoPlayer.bytesTotal;
			_progressSlider.couldDragPersent = _vcastr3.videoPlayer.bytesLoaded / _vcastr3.videoPlayer.bytesTotal;
		}
		private function onVcastrComplete(e:Event):void {
			_vcastr3.videoPlayer.gotoBegin();
		}
		private function onFullScreenBtnClick(e:MouseEvent):void {
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				_fullScreenBtn.frame = 2;
			}else {
				stage.displayState = StageDisplayState.NORMAL;
				_fullScreenBtn.frame = 1;
			}
		}
		private function onAddedToStage(e:Event):void {
			init()
		}
		private function onStageResize(e:Event):void {
			setPosition();
		}
		private function onProgressSliderChange(e:Event):void {
			TweenLite.killDelayedCallsTo(_vcastr3.videoPlayer.seekPersent);
			TweenLite.delayedCall(.3, _vcastr3.videoPlayer.seekPersent, [_progressSlider.value]);
		}
		private function onVolumnSliderChange(e:Event):void {		
			if (_volumnSlider.value < 0.05) {
				_volumnSlider.value = 0;
				_volumnBtn.frame = 2;
			} else {
				_volumnBtn.frame = 1;
			}
			_vcastr3.videoPlayer.volume = _volumnSlider.value;
		}
		private function onVolumnBtnClick(e:MouseEvent):void {
			if (_vcastr3.videoPlayer.volume > 0.05) {
				_vcastr3.videoPlayer.volume = 0;
				_volumnBtn.frame = 2;
			}else {
				_vcastr3.videoPlayer.volume = .8;				
				_volumnBtn.frame = 1;
			}
			_volumnSlider.value = _vcastr3.videoPlayer.volume;
		}
		private function onPlayPauseBtnClick(e:MouseEvent):void {
			_vcastr3.videoPlayer.playPause();
		}
		private function setPosition():void {
			if (VcastrConfig.controlPanelMode != "bottom") {
				_vcastr3.playerSizeTo(stage.stageWidth, stage.stageHeight);
				if (_vcastr3.videoPlayer.playerWidth > 600) {
					panelWidth = 600;
					x = (_vcastr3.videoPlayer.playerWidth - 600) / 2;
				}else {
					panelWidth = _vcastr3.videoPlayer.playerWidth - _panelHeight - 15;
					x = 15;
				}				
				y = _vcastr3.videoPlayer.playerHeight - 30;
			}else {				
				_vcastr3.playerSizeTo(stage.stageWidth, stage.stageHeight - _panelHeight);
				panelWidth = _vcastr3.videoPlayer.playerWidth;
				y = _vcastr3.videoPlayer.playerHeight - _panelHeight;
			}
			
		}
		private function init():void {			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
			_vcastr3 = parent as Vcastr3;
			_vcastr3.videoPlayer.volume = .8;
			bulidUI();
			setPosition();
			configVcastr3Listener();
		}
		public function set panelWidth(w:Number):void {
			_panelWidth = w;
			setLayout();
		}
	}	
}