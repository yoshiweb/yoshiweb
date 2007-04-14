/**
* Version クラス
*
* @description	プラグインのバージョンチェックをするクラス。
*
* @author		yoshiweb
* @since	Flash Player 6 (ActionScript 2.0)
* @version		0.20070415
*
* @history
* 20070415 - 他の機能を実装すると Flash Player 6 書き出しができなくなるので、バージョンチェックだけ別クラスに分離
* 20060406 - SystemUtilsクラスから独立。
* 20060402 - isVersion マイナーバージョンにも対応
* 20060329 - isVersion 作成
*/
class net.yoshiweb.utils.player.Version {
	private var CLASS_NAME:String = "[Version]";
	//
	//コンストラクタ
	private function Version() {
	}
	/**
	* プレーヤーのバージョンチェック
	* @param	調べたいプレーヤーのバージョン
	* @return	指定したバージョンよりも新しかったら true それ以外は false
	* @usage	
	*	<code>
	*	// プレーヤーがバージョン 9,0,28,0 以上か調べる
	*	import net.yoshiweb.utils.player.Version;
	*	//
	*	if(Version.isOver(9,0,28,0)){
	*	    trace("フルスクリーン対応");
	*	}else{
	*	    trace("フルスクリーン未対応");
	*	}
	*	</code>
	*/
	public static function isOver():Boolean {
		var tbl:Array = getVersion().split(" ")[1].split(",");
		var len:Number = arguments.length;
		for (var i:Number = 0; i<len; i++) {
			var ver = Number(tbl[i]);
			var arg = arguments[i];
			if (ver>arg) {
				return true;
			} else if (ver<arg) {
				return false;
			}
		}
		return true;
	}
	//
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
/*
Copyright (c) 2007 yoshiweb.NET All rights reserved.
*/
