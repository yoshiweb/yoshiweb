import mx.transitions.OnEnterFrameBeacon;
import mx.transitions.easing.*;
/**
* ColorTransクラスに tween機能を追加
*
* @description		色を徐々に変化
* @usage
*	<code>
*	import mx.transitions.easing.*;
*	import net.yoshiweb.utils.color.ColorTransEx;
*	//
*	var _color = new ColorTransEx(mc);
*	var beginRGB:Number = 0xff0000;
*	var finishRGB:Number = 0x00ff00;
*	var frame:Number = 30;
*	var ease:Function = None.easeNone;
*	var delay:Number = 5;
*	var extra1:Number = 0;
*	var extra2:Number = 0;
*	//
*	_color.onChanged = function(color) {
*		trace(color);
*	}
*	_color.onFinished = function(color) {
*		trace(color);
*	};
*	// 実行
*	_color.tween(beginRGB, finishRGB, frame, ease, delay, extra1, extra2);
*	</code>
* @author		Takano Yoshihiro
* @since		Flash Player 8 (ActionScript 2.0)
* @version		0.20070319
* @history	
*	200070319 - frame 0 対応
*	200070312 - 作成
*/
class net.yoshiweb.utils.color.ColorTransEx extends net.yoshiweb.utils.color.ColorTrans {
	private var CLASS_NAME:String = "[ColorTransEx]";
	private static var __initBeacon:Object = OnEnterFrameBeacon.init();
	//
	function ColorTransEx(mc:MovieClip) {
		super(mc);
	}
	//
	/**
	* トゥイーンで色変化
	*/
	public function tween(beginRGB:Number, finishRGB:Number, frame:Number, ease:Function, delay:Number, extra1:Number, extra2:Number):Void {
		if (!beginRGB || !finishRGB || isNaN(frame)) {
			return;
		}
		if (frame<=0) {
			setRGB(finishRGB);
			onChanged(finishRGB);
			onFinished(finishRGB);
			return;
		}
		var beginR:Number = colorRGB(beginRGB)[0];
		var beginG:Number = colorRGB(beginRGB)[1];
		var beginB:Number = colorRGB(beginRGB)[2];
		var finishR:Number = colorRGB(finishRGB)[0];
		var finishG:Number = colorRGB(finishRGB)[1];
		var finishB:Number = colorRGB(finishRGB)[2];
		//
		var distanceR:Number = (finishR-beginR);
		var distanceG:Number = (finishG-beginG);
		var distanceB:Number = (finishB-beginB);
		//
		if (ease == undefined) {
			ease = None.easeNone;
		}
		if (delay == undefined) {
			delay = 0;
		}
		//                              
		var self = this;
		var cnt:Number = 0;
		var obj:Object = new Object();
		obj.onEnterFrame = function() {
			if (cnt>delay) {
				var count:Number = cnt-delay;
				var r:Number = ease(count, beginR, distanceR, frame, extra1, extra2);
				var g:Number = ease(count, beginG, distanceG, frame, extra1, extra2);
				var b:Number = ease(count, beginB, distanceB, frame, extra1, extra2);
				var rgb:Number = colorRadix10(r, g, b);
				self.setRGB(rgb);
				self.onChanged(rgb);
				if (cnt>=(frame+delay)) {
					self.onFinished(rgb);
					MovieClip.removeListener(this);
				}
			}
			cnt++;
		};
		obj.onEnterFrame();
		MovieClip.addListener(obj);
	}
	/**
	* 詳細カラーでトゥイーン
	*/
	public function tweenTransform(beginObj:Object, finishObj:Object, frame:Number, ease:Function, delay:Number, extra1:Number, extra2:Number):Void {
		if (!beginObj || !finishObj || isNaN(frame)) {
			return;
		}
		if (frame<=0) {
			setTransform(finishObj);
			onChanged(finishObj);
			onFinished(finishObj);
			return;
		}
		var beginRA:Number = beginObj.ra;
		var beginGA:Number = beginObj.ga;
		var beginBA:Number = beginObj.ba;
		var beginAA:Number = beginObj.aa;
		var beginRB:Number = beginObj.rb;
		var beginGB:Number = beginObj.gb;
		var beginBB:Number = beginObj.bb;
		var beginAB:Number = beginObj.ab;
		var finishRA:Number = finishObj.ra;
		var finishGA:Number = finishObj.ga;
		var finishBA:Number = finishObj.ba;
		var finishAA:Number = finishObj.aa;
		var finishRB:Number = finishObj.rb;
		var finishGB:Number = finishObj.gb;
		var finishBB:Number = finishObj.bb;
		var finishAB:Number = finishObj.ab;
		//
		var distanceRA:Number = (finishRA-beginRA);
		var distanceGA:Number = (finishGA-beginGA);
		var distanceBA:Number = (finishBA-beginBA);
		var distanceAA:Number = (finishAA-beginAA);
		var distanceRB:Number = (finishRB-beginRB);
		var distanceGB:Number = (finishGB-beginGB);
		var distanceBB:Number = (finishBB-beginBB);
		var distanceAB:Number = (finishAB-beginAB);
		//
		if (ease == undefined) {
			ease = None.easeNone;
		}
		if (delay == undefined) {
			delay = 0;
		}
		//                              
		var self = this;
		var cnt:Number = 0;
		var obj:Object = new Object();
		obj.onEnterFrame = function() {
			if (cnt>delay) {
				var count:Number = cnt-delay;
				var obj:Object = new Object();
				obj.ra = ease(count, beginRA, distanceRA, frame, extra1, extra2);
				obj.ga = ease(count, beginGA, distanceGA, frame, extra1, extra2);
				obj.ba = ease(count, beginBA, distanceBA, frame, extra1, extra2);
				obj.aa = ease(count, beginAA, distanceAA, frame, extra1, extra2);
				obj.rb = ease(count, beginRB, distanceRB, frame, extra1, extra2);
				obj.gb = ease(count, beginGB, distanceGB, frame, extra1, extra2);
				obj.bb = ease(count, beginBB, distanceBB, frame, extra1, extra2);
				obj.ab = ease(count, beginAB, distanceAB, frame, extra1, extra2);
				self.setTransform(obj);
				self.onChanged(obj);
				if (cnt>=(frame+delay)) {
					self.onFinished(obj);
					MovieClip.removeListener(this);
				}
			}
			cnt++;
		};
		MovieClip.addListener(obj);
	}
	/**
	* トゥイーン中に実行
	*/
	public function onChanged() {
	}
	/**
	* トゥイーン後に実行
	*/
	public function onFinished() {
	}
	//
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
