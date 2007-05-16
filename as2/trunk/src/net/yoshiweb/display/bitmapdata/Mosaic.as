/*
Copyright (c) 2007 yoshiweb.NET

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
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
