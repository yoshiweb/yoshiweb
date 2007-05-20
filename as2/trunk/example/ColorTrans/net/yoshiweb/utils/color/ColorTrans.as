﻿/*
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

import flash.geom.ColorTransform;
import flash.geom.Transform;
/**
* Flash 8 でも Colorクラスのように色を変更するクラス
*
* @description		Flash Player 8 では Colorクラスが非推奨なので作成
* @usage
*	<code>
*		import net.yoshiweb.utils.color.ColorTrans;
*		var _color = new ColorTrans(mc);
*		_color.setRGB(0xff0000);
*	</code>
* @author		Takano Yoshihiro
* @since		Flash Player 8 (ActionScript 2.0)
* @version		0.20070312
* @history	
*	200070312 - getRGB()の戻り値の行の引数、typo修正。
*	200070309 - getRGB() と getTransform() などを実装。
*	200070308 - 作成。getRGB() と getTransform() はまだ未実装
*/
class net.yoshiweb.utils.color.ColorTrans {
	private var CLASS_NAME:String = "[ColorTrans]";
	private var _mc:MovieClip;
	//
	// コンストラクタ
	function ColorTrans(mc:MovieClip) {
		_mc = mc;
	}
	//
	/**
	* RGBを設定
	* @param	rgb	RGBカラー
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		_color.setRGB(0xff0000));	// 赤くする
	*	</code>
	*/
	public function setRGB(rgb:Number):Void {
		var tbl:Array = ColorTrans.colorRGB(rgb);
		var redMultiplier:Number = 0;
		var greenMultiplier:Number = 0;
		var blueMultiplier:Number = 0;
		var alphaMultiplier:Number = 1;
		var redOffset:Number = tbl[0];
		var greenOffset:Number = tbl[1];
		var blueOffset:Number = tbl[2];
		var alphaOffset:Number = 0;
		setColorTransform(new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset));
	}
	/**
	* カラーを詳細設定
	* @param	obj	カラー情報の入ったオブジェクト
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		var obj = new Object();
	*		obj.ra = 0;
	*		obj.ga = 0;
	*		obj.ba = 0;
	*		obj.aa = 1;
	*		obj.rb = 255;
	*		obj.gb = 0;
	*		obj.bb = 0;
	*		obj.ab = 0;
	*		_color.setTransform(obj);	// 赤くする
	*	</code>
	*/
	public function setTransform(obj:Object):Void {
		var redMultiplier:Number = obj.ra;
		var greenMultiplier:Number = obj.ga;
		var blueMultiplier:Number = obj.ba;
		var alphaMultiplier:Number = obj.aa;
		var redOffset:Number = obj.rb;
		var greenOffset:Number = obj.gb;
		var blueOffset:Number = obj.bb;
		var alphaOffset:Number = obj.ab;
		setColorTransform(new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset));
	}
	/**
	* ColorTransformで色を設定
	* @param	colorTrans	ColorTransformオブジェクト
	* @usage
	*	<code>
	*		import flash.geom.ColorTransform;
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		_color.setColorTransform(new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset));
	*	</code>
	*/
	public function setColorTransform(colorTrans:ColorTransform):Void {
		_mc.transform.colorTransform = colorTrans;
	}
	/**
	* RGB情報を取得
	* @return	RGB情報
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		_color.getRGB();
	*	</code>
	*/
	public function getRGB(Void):Number {
		var colorTrans:ColorTransform = _mc.transform.colorTransform;
		var r:Number = colorTrans.redOffset;
		var g:Number = colorTrans.greenOffset;
		var b:Number = colorTrans.blueOffset;
		return ColorTrans.colorRadix10(r, g, b);
	}
	/**
	* カラー詳細情報を取得
	* @return	カラー詳細情報の入ったオブジェクト
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		_color.getTransform();
	*	</code>
	*/
	public function getTransform(Void):Object {
		var colorTrans:ColorTransform = _mc.transform.colorTransform;
		var obj:Object = new Object();
		obj.ra = colorTrans.redMultiplier;
		obj.ga = colorTrans.greenMultiplier;
		obj.ba = colorTrans.blueMultiplier;
		obj.aa = colorTrans.alphaMultiplier;
		obj.rb = colorTrans.redOffset;
		obj.gb = colorTrans.greenOffset;
		obj.bb = colorTrans.blueOffset;
		obj.ab = colorTrans.alphaOffset;
		return obj;
	}
	/**
	* ColorTransformを取得
	* @return	ColorTransformオブジェクト
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		_color.getColorTransform();
	*	</code>
	*/
	public function getColorTransform(Void):ColorTransform {
		return _mc.transform.colorTransform;
	}
	//
	/**
	* 色を元に戻す
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		var _color = new ColorTrans(mc);
	*		_color.reset();
	*	</code>
	*/
	public function reset(Void):Void {
		var redMultiplier:Number = 1;
		var greenMultiplier:Number = 1;
		var blueMultiplier:Number = 1;
		var alphaMultiplier:Number = 1;
		var redOffset:Number = 0;
		var greenOffset:Number = 0;
		var blueOffset:Number = 0;
		var alphaOffset:Number = 0;
		setColorTransform(new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset));
	}
	/**
	* 数値をRGBに分解
	* @param	num		0xffffff、16777215 など
	* @return			RGBの値を含む配列
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*	    ColorTrans.colorRGB(16777215);	// [255, 255, 255]
	*	</code>
	*/
	public static function colorRGB(num:Number):Array {
		var r:Number = num >> 16 & 0xff;
		var g:Number = num >> 8 & 0xff;
		var b:Number = num & 0xff;
		return [r, g, b];
	}
	/**
	* RGBを10進数に変換
	* @param	r		0-255の数値
	* @param	g		0-255の数値
	* @param	b		0-255の数値
	* @return			10進数
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*	    ColorTrans.colorRadix10(255, 255, 255);	// 16777215
	*	</code>
	*/
	public static function colorRadix10(r:Number, g:Number, b:Number):Number {
		//return (r*256*256)+(g*256)+(b);
		return (r << 16)+(g << 8)+(b);
	}
	/**
	* RGBを16進数の文字列に変換
	* @return			16進数の文字列
	* @usage
	*	<code>
	*	    import net.yoshiweb.utils.color.ColorTrans;
	*		ColorTrans.colorRadix16(16777215);	// "ffffff"
	*	    ColorTrans.colorRadix16(255, 255, 255);	// "ffffff"
	*	</code>
	*/
	public static function colorRadix16():String {
		if (arguments.length == 1) {
			return arguments[0].toString(16);
		} else {
			var r:Number = arguments[0];
			var g:Number = arguments[1];
			var b:Number = arguments[2];
			return r.toString(16)+g.toString(16)+b.toString(16);
		}
	}
	//
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
