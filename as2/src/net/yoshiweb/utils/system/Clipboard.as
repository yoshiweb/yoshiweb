/*
* Copyright(c) 2007 yoshiweb.NET
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
* 
* The MIT License
* http://www.opensource.org/licenses/mit-license.php
*/

/**
* クリップボードにテキストをコピーするクラス
*
* @description	System.setClipboard();は実行するたびに前にコピーした文字列を上書きしてしまうので、前にコピーした文字列を残した状態で新たに文字列をコピーする。
*
* @author		yoshiweb
* @since		Flash Player 7 (ActionScript 2.0)
* @version		0.20070516
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
