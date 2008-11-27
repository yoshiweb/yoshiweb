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

package net.yoshiweb.events {
	import net.yoshiweb.utils.system.PlayerCheck;
	/**
	 * 
	 * Trace
	 * 
	 * @description	
	 * @usage		
	 * 	<code>
	 * 	import net.yoshiweb.events.Trace;
	 * 	// ERROR 以上のみ出力に設定
	 * 	Trace.level = Trace.ERROR;
	 *  Trace.canBrowser = false;
	 * 	//
	 * 	Trace.debug("debug");
	 * 	Trace.info("info");
	 * 	Trace.warning("warning");
	 * 	Trace.error("error");		// error
	 * 	Trace.fatal("fatal", 123);	// fatal,123
	 * 	</code>
	 * @author		Takano Yoshihiro
	 * @version		0.20081127
	 * @history		
	 */
	public class Trace
	{
		public static const ALL:Number     = 0;
		public static const DEBUG:Number   = 2;
		public static const INFO:Number    = 4;
		public static const WARNING:Number = 6;
		public static const ERROR:Number   = 8;
		public static const FATAL:Number   = 1000;
		//
		private static var _level:Number           = Trace.ALL;
		private static var _isMoviePreview:Boolean = PlayerCheck.isMoviePreview();
		private static var _canBrowser:Boolean = false;
		//
		//コンストラクタ
		public function Trace()
		{
		}
		////////////////////////////////////////////////////////////////////
		// public
		////////////////////////////////////////////////////////////////////
		/**
		 *  出力レベルを設定
		 *  @param	level	出力レベル
		 */
		public static function set level(level:Number):void
		{
			_level = level;
		}
		/**
		 *  ブラウザでも出力
		 *  @param	flg		true または false
		 */
		public static function set canBrowser(flg:Boolean):void
		{
			_canBrowser = flg;
		}
		////////////////////////////////////////////////////////////////////
		/**
		 * 致命的
		 */
		public static function fatal(...args):void
		{
			if (_level <= FATAL) {
				Trace._trace(args);
			}
		}
		/**
		 * エラー
		 */
		public static function error(...args):void
		{
			if (_level <= ERROR) {
				Trace._trace(args);
			}
		}
		/**
		 * 注意
		 */
		public static function warning(...args):void
		{
			if (_level <= WARNING) {
				Trace._trace(args);
			}
		}
		/**
		 * インフォ
		 */
		public static function info(...args):void
		{
			if (_level <= INFO) {
				Trace._trace(args);
			}
		}
		/**
		 * デバッグ
		 */
		public static function debug(...args):void
		{
			if (_level <= DEBUG) {
				Trace._trace(args);
			}
		}
		////////////////////////////////////////////////////////////////////
		// private
		////////////////////////////////////////////////////////////////////
		private static function _trace(...args):void
		{
			if(_isMoviePreview || _canBrowser){
				trace(args);
			}
		}
	}
}
