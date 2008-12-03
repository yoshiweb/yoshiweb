/*
* Copyright(c) 2008 yoshiweb.NET
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

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.geom.Matrix;
/**
* Pattern
*
* @description	ドットでパターンを作成できるクラス
*
* @author		Takano Yoshihiro
* @since		Flash Player 8 (ActionScript 2.0)
* @version		0.20080102
*/
class net.yoshiweb.display.graphics.Pattern {
	private var CLASS_NAME:String = "[net.yoshiweb.display.graphics.Pattern]";
	//
	//コンストラクタ
	private function Pattern() {
	}
	/////////////////////////////////////////////////////////////////
	// public
	/////////////////////////////////////////////////////////////////
	/**
	* 任意のパターンでタイル状に点を描画
	* @usage
	*	<code>
	*	import net.yoshiweb.display.graphics.Pattern;
	*	//
	*	// タイル状のパターン２次元配列を作成
	*	var tileArray:Array = new Array();
	*	tileArray[0] = [1, 0, 0, 0];
	*	tileArray[1] = [0, 0, 0, 0];
	*	tileArray[2] = [0, 0, 1, 0];
	*	tileArray[3] = [0, 0, 0, 0];
	*	//
	*	// 各ピクセルを塗りつぶす色を配列で指定
	*	var argbArray:Array = new Array();
	*	argbArray[0] = 0x00;		// 透過
	*	argbArray[1] = 0xffff0000;	// 赤
	*	//
	*	// 適用先、サイズなどを指定して、実行。
	*	var mc:MovieClip = this.createEmptyMovieClip("test_mc", 0);
	*	var width:Number = 50;
	*	var height:Number = 100;
	*	Pattern.custom(mc, width, height, tileArray, argbArray);
	*	</code>
	*/
	public static function custom(mc:MovieClip, width:Number, height:Number, tileArray:Array, argbArray:Array) {
		var x:Number = tileArray[0].length;
		var y:Number = tileArray.length;
		var bmp:BitmapData = new BitmapData(x, y, true, 0xff);
		for(var i=0; i<x; i++){
			for(var j=0; j<y; j++){
				var rect:Rectangle = new Rectangle(i, j, 1, 1);
				var id:Number = tileArray[j][i];
				bmp.fillRect(rect, argbArray[id]);
			}
		}
		var xMax:Number = width;
		var yMax:Number = height;
		var matrix:Matrix = new Matrix();
		var repeat:Boolean = true;
		var smoothing:Boolean = false;
		mc.beginBitmapFill(bmp, matrix, repeat, smoothing);
		mc.moveTo(0, 0);
		mc.lineTo(xMax, 0);
		mc.lineTo(xMax, yMax);
		mc.lineTo(0, yMax);
		mc.endFill();
		//mc.cacheAsBitmap = true;
	}
	/////////////////////////////////////////////////////////////////
	// private
	/////////////////////////////////////////////////////////////////
	private function toString():String {
		return CLASS_NAME;
	}
}