package com.ruochi.video.plugIn {
	import com.ruochi.video.Vcastr3;
	public interface IVcastrPlugIn {
		function init(vcastr3:Vcastr3):void;
		function set dataXml(xml:XML):void
	}	
}