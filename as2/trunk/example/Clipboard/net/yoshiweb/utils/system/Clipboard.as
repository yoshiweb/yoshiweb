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
* クリップボードにテキストをコピーするクラス
*
* @description	System.setClipboard();は実行するたびに前にコピーした文字列を上書きしてしまうので、前にコピーした文字列を残した状態で新たに文字列をコピーする。
*
* @author		yoshiweb
* @since		Flash Player 7 (ActionScript 2.0)
* @version		0.20070516
*
* @history
*	20070516 - System.setClipboard("");でクリップボードを空にはできないのを忘れてた。
*	20060407 - 改行を\r\nから\rに変更
*	20060405 - 作成
*/
class net.yoshiweb.utils.system.Clipboard {
	private var CLASS_NAME:String = "[Clipboard]";
	private static var _str:String = "";
	//
	//コンストラクタ
	private function Clipboard() {
	}
	/**
	* クリップボードに文字列を貼り付けます
	* @param	obj		コピーする内容
	* @return	なし
	* @usage	<code>net.yoshiweb.utils.system.Clipboard.trace(obj);</code>
	*/
	public static function trace(obj:Object):Void {
		var str:String = String(obj);
		_str += str+"\r";
		System.setClipboard(_str);
	}
	/**
	* クリップボードの中身を半角スペースにします。
	* @return	なし
	* @usage	<code>net.yoshiweb.utils.system.Clipboard.clear();</code>
	*/
	public static function clear():Void {
		_str = "";
		System.setClipboard(" ");
	}
	//
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
