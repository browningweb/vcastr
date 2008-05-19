package com.ruochi.shape{
	import flash.display.*;
	import flash.geom.*;
	public class RectBorder extends Sprite {
		public function RectBorder(_w:Number=100,_h:Number=100,_borderWidth:Number=1,_color:uint=0xff0000) {
			super()
			this.graphics.beginFill(_color);
            this.graphics.drawRect(0, 0, _w, _h);
			this.graphics.drawRect(_borderWidth, _borderWidth, _w-_borderWidth*2, _h-_borderWidth*2);
            this.graphics.endFill();
			this.scale9Grid = new Rectangle( _borderWidth, _borderWidth, _w - _borderWidth * 2, _h - _borderWidth * 2);
		}		
	}
}