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
* Player クラス
*
* @description	プラグインのバージョンチェックなど、再生しているPlayerを調べるクラス。
*
* @author		Takano Yoshihiro
* @version		0.20070216
*
* @history
* 20070216 - isPreview() → isMoviePreview() へ改名
* 20061114 - isPreview() 追加
* 20060406 - SystemUtils クラスから独立。
* 20060402 - isVersion() マイナーバージョンにも対応
* 20060329 - isVersion() 作成
*/
class net.yoshiweb.utils.system.Player {
	private var CLASS_NAME:String = "[Player]";
	//
	//コンストラクタ
	private function Player() {
	}
	/**
	* プレーヤーのバージョンチェック
	* @param	調べたいプレーヤーのバージョン
	* @return	指定したバージョンよりも新しかったら true それ以外は false
	* @usage	
	*	<code>
	*	// プレーヤーがバージョン8.5以上か調べる
	*	import net.yoshiweb.utils.system.Player;
	*	Player.isVersion(8, 5);
	*	</code>
	* @since	Flash Player 6 (ActionScript 2.0)
	*/
	public static function isVersion():Boolean {
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
	/**
	* ムービープレビュー用プレーヤーか判別
	* @return	ムービープレビュー用プレーヤーの場合は true それ以外は false
	* @since	Flash Player 7 (ActionScript 2.0)
	*/
	public static function isMoviePreview():Boolean {
		return (System.capabilities.playerType == "External") && System.capabilities.isDebugger;
	}
	//--------------------------------------------------------
	private function toString():String {
		return CLASS_NAME;
	}
	//--------------------------------------------------------
}
