/*
 * Copyright(c) 2007 yoshiweb.NET
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

/**
* mx.transitions.Tweenクラスを拡張したクラス
*
* @description	Elasticクラス や Backクラス に、引数を渡せるように mx.transitions.Tweenクラスを拡張
* @usage		Tweenクラスと比較。
*	<code>
*	import net.yoshiweb.transitions.TweenEx;
*	import mx.transitions.Tween;
*	import mx.transitions.easing.*;
*	new Tween(mc1, "_x", Back.easeOut, 0, 300, 2, true);
*	new TweenEx(mc2, "_x", Back.easeOut, 0, 300, 2, true, 5);
*	</code>
*
* @author		Takano Yoshihiro
* @version		0.20060316
* @history		20060316 - 作成
*
* @see	mx.transitions.Tween
*/
class net.yoshiweb.transitions.TweenEx extends mx.transitions.Tween {
	private var _extra1;
	private var _extra2;
	/**
	*  トゥイーンを開始する。
	*  @param	obj	Tween インスタンスのターゲットになるオブジェクト
	*  @param	prop	値がトゥイーンされる obj のプロパティ名
	*  @param	func	イージング効果を計算するイージングメソッド
	*  @param	begin	トゥイーンされるオブジェクトのプロパティの開始値
	*  @param	finish	トゥイーンされるオブジェクトのプロパティの終了値
	*  @param	duration	トゥイーンモーションの継続時間
	*  @param	useSeconds	duration パラメータで指定した値の単位に関して、秒 (true の場合) またはフレーム (false の場合) のどちらを使用するか
	*  @param	extra1	elastic のときは振幅 [amplitude]。back のときは通り越す値 [overshoot amount] //0〜
	*  @param	extra2	elastic のときは周期 [period] //0〜
	*/
	function TweenEx(obj, prop, func, begin, finish, duration, useSeconds, extra1, extra2) {
		super(obj, prop, func, begin, finish, duration, useSeconds);
		_extra1 = extra1;
		_extra2 = extra2;
	}
	function getPosition(t:Number):Number {
		if (t == undefined) {
			t = this._time;
		}
		return this.func(t, this.begin, this.change, this._duration, _extra1, _extra2);
	}
}
