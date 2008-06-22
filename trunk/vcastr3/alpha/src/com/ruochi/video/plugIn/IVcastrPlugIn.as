package com.ruochi.video.plugIn {
	import com.ruochi.video.Controller;
	public interface IVcastrPlugIn {
		function init(controller:Controller):void;
		function set dataXml(xml:XML):void
	}	
}