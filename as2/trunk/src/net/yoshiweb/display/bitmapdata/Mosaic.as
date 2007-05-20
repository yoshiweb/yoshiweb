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

import flash.geom.Matrix;
import flash.display.BitmapData;
/**
* モザイククラス
*
* @description	
* @usage		
*	<code>
*	</code>
* @author		Takano Yoshihiro
* @since		Flash Player 8 (ActionScript 2.0)
* @version		0.20060804
* @history		
*	20060804	作成
*/
class net.yoshiweb.display.bitmapdata.Mosaic {
	private var CLASS_NAME:String = "[Mosaic]";
	//
	//コンストラクタ
	private function Mosaic() {
	}
	/**
	* 元データのイメージにモザイクをかける
	* @param	bmp		描画先
	* @param	source	元データ
	* @param	strong	強さ
	* @return		なし
	* @usage	<code></code>
	*/
	public static function createMosaic(mc:MovieClip, source:Object, strong:Number):Void {
		if (strong<=0) {
			return;
		}
		if (source instanceof BitmapData) {
			var w:Number = source.width;
			var h:Number = source.height;
		} else if (source instanceof MovieClip) {
			var w:Number = source._width;
			var h:Number = source._height;
		}
		//
		// 縮小ビットマップ作成
		var mini_bmp:BitmapData = new BitmapData(w/strong, h/strong, true, 0x00);
		var matrix:Matrix = new Matrix();
		matrix.scale(1/strong, 1/strong);
		mini_bmp.draw(source, matrix);
		//
		var xs:Number = w/mini_bmp.width;
		var ys:Number = h/mini_bmp.height;
		//
		// モザイクビットマップ作成
		mc.mosaic_bmp.dispose();
		mc.mosaic_bmp = new BitmapData(w, h, true, 0x00);
		var matrix:Matrix = new Matrix();
		matrix.scale(xs, ys);
		mc.mosaic_bmp.draw(mini_bmp, matrix);
		mini_bmp.dispose();
		//
		// 描画
		mc.attachBitmap(mc.mosaic_bmp, mc.getNextHighestDepth(), "auto", false);
	}
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
