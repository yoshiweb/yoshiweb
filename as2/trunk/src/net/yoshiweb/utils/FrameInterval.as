import mx.transitions.OnEnterFrameBeacon;
/**
* 任意の間隔で関数を実行するクラス
* 
* @description		setInterval／setTimeout のフレーム版
* @usage
	<code>
	import net.yoshiweb.utils.FrameInterval;
	FrameInterval.setInterval(trace, 10, "10フレームごとに実行");
	</code>
	<code>
	import net.yoshiweb.utils.FrameInterval;
	FrameInterval.setInterval(this, "test", 10);
	function test(){
		trace("10フレームごとに実行");
	}
	</code>
*
* @author		Takano Yoshihiro
* @since		Flash Player 6 (ActionScript 2.0)
* @version		0.20060831
* @history
*	20060831 - 内包されたfunction対応
*	20060816 - setTimeout・clearTimeoutを追加
*	20060724 - 作成
*/
class net.yoshiweb.utils.FrameInterval {
	private var CLASS_NAME:String = "[FrameInterval]";
	private static var __initBeacon = OnEnterFrameBeacon.init();
	//
	private static var _id:Number = 0;
	private static var _enterFrameObj:Array = new Array();
	/**
	* コンストラクタ
	*/
	private function FrameInterval() {
	}
	/**
	* 繰り返し実行
	* @param	functionReference	呼び出される関数への参照。
	* @param	interval			functionReference または methodName 関数に対する呼び出しの間隔 (フレーム数)。
	* @param	param				functionReference または methodName に送られた関数に渡すパラメータ。複数のパラメータはカンマで区切ります。 param1 , param2 , ..., paramN
	* @param	objectReference		methodName で指定したメソッドを含むオブジェクト。
	* @param	methodName			objectReference で指定したオブジェクトのスコープ内に存在するメソッド。
	* @return						間隔を識別するための整数 (インターバル ID)。
	* @usage
	<code>
	setInterval(functionReference:Function, interval:Number, [param1:Object, param2, ..., paramN]) : Number
	setInterval(objectReference:Object, methodName:String, interval:Number, [param1:Object, param2, ..., paramN]) : Number
	</code>
	*/
	public static function setInterval():Number {
		if (arguments[0] == undefined) {
			return;
		}
		var obj:Object = _interval.apply(FrameInterval, arguments);
		_id++;
		_enterFrameObj[_id] = new Object();
		_countDown(false, _enterFrameObj[_id], obj);
		return _id;
	}
	/**
	* １回だけ実行
	* @param	functionReference	呼び出される関数への参照。
	* @param	interval			functionReference または methodName 関数に対する呼び出しの間隔 (フレーム数)。
	* @param	param				functionReference または methodName に送られた関数に渡すパラメータ。複数のパラメータはカンマで区切ります。 param1 , param2 , ..., paramN
	* @param	objectReference		methodName で指定したメソッドを含むオブジェクト。
	* @param	methodName			objectReference で指定したオブジェクトのスコープ内に存在するメソッド。
	* @return						間隔を識別するための整数 (インターバル ID)。
	* @usage
	<code>
	setTimeout(functionReference:Function, interval:Number, [param1:Object, param2, ..., paramN]) : Number
	setTimeout(objectReference:Object, methodName:String, interval:Number, [param1:Object, param2, ..., paramN]) : Number
	</code>
	*/
	public static function setTimeout():Number {
		if (arguments[0] == undefined) {
			return;
		}
		var obj:Object = _interval.apply(FrameInterval, arguments);
		_id++;
		_enterFrameObj[_id] = new Object();
		_countDown(true, _enterFrameObj[_id], obj);
		return _id;
	}
	/**
	* setIntervalを停止する
	* @param	id	停止する関数のインターバルID
	* @return		なし
	*/
	public static function clearInterval(id:Number):Void {
		_clear(id);
	}
	/**
	* setTimeoutを停止する
	* @param	id	停止する関数のインターバルID
	* @return		なし
	*/
	public static function clearTimeout(id:Number):Void {
		_clear(id);
	}
	//
	/**
	* パラメータを解析
	* @return		解析した関数情報オブジェクト
	*/
	private static function _interval():Object {
		var target:Object;
		var method;
		var interval:Number;
		var args:Array;
		//    
		var a0 = arguments[0];
		var a1 = arguments[1];
		var a2 = arguments[2];
		//
		if (a0 instanceof Function && typeof (a1) == "number") {
			target = null;
			method = a0;
			interval = Math.max(0, Math.floor(a1));
			args = [].concat(arguments.slice(2));
			//} else if (a0[a1] instanceof Function && typeof (a2) == "number") {
		} else {
			target = a0;
			method = a0[a1];
			if (method == undefined) {
				method = a1;
			}
			interval = Math.max(0, Math.floor(a2));
			args = [].concat(arguments.slice(3));
		}
		return {target:target, method:method, interval:interval, args:args};
	}
	/**
	* 停止
	* @param	id	停止する関数のインターバルID
	* @return		なし
	*/
	private static function _clear(id:Number):Void {
		MovieClip.removeListener(_enterFrameObj[id]);
	}
	/**
	* カウントダウン
	* @param	timeout		setTimeoutの場合 true。
	* @param	enterObj	カウントダウンオブジェクト
	* @param	obj			実行する関数の情報
	* @return				なし
	*/
	private static function _countDown(timeout:Boolean, enterObj:Object, obj:Object):Void {
		var target:Object = obj.target;
		var method = obj.method;
		var interval:Number = obj.interval;
		var args:Array = obj.args;
		//
		if (!(method instanceof Function)) {
			var methodName:String = obj.method;
		}
		//     
		var count:Number = interval;
		enterObj.onEnterFrame = function() {
			count--;
			if (count<=0) {
				count = interval;
				if (!(method instanceof Function)) {
					method = target[methodName];
				}
				// 実行             
				method.apply(target, args);
				if (timeout) {
					// setTimeoutの場合、終了
					MovieClip.removeListener(this);
				}
			}
		};
		MovieClip.addListener(enterObj);
	}
	//
	private function toString():String {
		return CLASS_NAME;
	}
}
