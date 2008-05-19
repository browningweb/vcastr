package com.ruochi.layout {
	public class Margin {
		public static const AUTO:String = "auto";
		private var _top;
		private var _bottom;
		private var _left;
		private var _right;
		public function Margin(t = null, r = null, b = null, l = null) {
			if (String(t).indexOf(" ") > 0) {
				var array:Array = String(t).split(" ");
				top = array[0];
				right = array[1];
				bottom = array[2];
				left = array[3];
			}else {
				top = t;
				right = r;
				bottom = b;
				left = l;
			}
		}
		public function set top(t):void {
			_top = checkIsAuto(t) ? AUTO : t; 
		}
		public function get top():Object {
			if (_top == AUTO) {
				return AUTO;
			}else {
				return Number(_top);
			}			
		}
		public function set bottom(b):void {
			_bottom = checkIsAuto(b) ? AUTO : b; 
		}
		public function get bottom():Object {
			if (_bottom == AUTO) {
				return AUTO;
			}else {
				return Number(_bottom);
			}	
		}
		public function set left(l):void {
			_left = checkIsAuto(l) ? AUTO : l; 
		}
		public function get left():Object {
			if (_left == AUTO) {
				return AUTO;
			}else {
				return Number(_left);
			}	
		}
		public function set right(r):void {
			_right = checkIsAuto(r) ? AUTO : r; 
		}
		public function get right():Object {
			if (_right == AUTO) {
				return AUTO;
			}else {
				return Number(_right);
			}	
		}
		private function checkIsAuto(str:String):Boolean {
			if (str == null || str.toLowerCase() == AUTO) {
				return true;
			}else {
				return false
			}
		}
	}	
}