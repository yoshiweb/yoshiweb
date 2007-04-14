/**
* クリップボードにテキストをコピーするクラス
*
* @description	System.setClipboard();は実行するたびに前にコピーした文字列を上書きしてしまうので、前にコピーした文字列を残した状態で新たに文字列をコピーする。
*
* @author		yoshiweb
* @version		0.20070415
*
* @history
* 20070415 - System.setClipboard("");でクリップボードを空にはできないのを忘れてた。clear()削除
* 20060407 - 改行を\r\nから\rに変更
* 20060405 - 作成
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
	/*
	* クリップボードを空にします
	* @return	なし
	* @usage	<code>net.yoshiweb.utils.system.Clipboard.clear();</code>
	public static function clear(Void):Void {
		_str = "";
		System.setClipboard(_str);
	}
	*/
	//
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
/*
Copyright (c) 2007 yoshiweb.NET All rights reserved.
*/