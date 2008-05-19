package com.ruochi.utils{
	public function replaceHat(_str:String):String {
		var pattern:RegExp = /\^/g;
		return _str.replace(pattern, "&");
	}
}