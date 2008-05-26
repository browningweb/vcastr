package com.ruochi.utils{
	import flash.display.Sprite;
	public function deleteAll(sp:Sprite) {
		while (sp.numChildren) {
			sp.removeChildAt(0);
		}
	}
}