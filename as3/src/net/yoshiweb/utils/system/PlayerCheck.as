/*
* Copyright(c) 2007-2008 yoshiweb.NET
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

package net.yoshiweb.utils.system
{
	import flash.system.Capabilities;

	public class PlayerCheck
	{
		// コンストラクタ
		public function PlayerCheck()
		{
		}
		
		/**
		* プレーヤーのバージョンチェック
		* @param	調べたいプレーヤーのバージョン
		* @return	指定したバージョンよりも新しかったら true それ以外は false
		* @usage	
		*	<code>
		*	// プレーヤーがバージョン 9,0,115,0 以上か調べる
		*	import net.yoshiweb.utils.system.PlayerCheck;
		*	PlayerCheck.isVersion(9, 0, 115, 0);
		*	</code>
		*/
		public static function isVersion(...args):Boolean
		{
			var str:String = Capabilities.version;
			var tbl:Array = str.split(" ")[1].split(",");
			var len:Number = args.length;
			for (var i:Number = 0; i<len; i++) {
				var ver:Number = Number(tbl[i]);
				var num:Number = Number(args[i]);
				if (ver > num) {
					return true;
				} else if (ver < num) {
					return false;
				}
			}
			return true;
		}
		/**
		* ムービープレビュー用プレーヤーか判別
		* @return	ムービープレビュー用プレーヤーの場合は true それ以外は false
		*/
		public static function isMoviePreview():Boolean
		{
			return (Capabilities.playerType == "External") && Capabilities.isDebugger;
		}
	}
}
