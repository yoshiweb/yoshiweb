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
* 任意の座標で変形
*
* @description	Transクラスを Flash Player 6 書き出し用に修正。Point→Object
* @usage		
*	<code>
*	import net.yoshiweb.utils.movieclip.Trans6;
*	//
*	var _trans = new Trans6(mc);
*	//
*	mc.onEnterFrame = function() {
*		_trans.rotate += 10;
*		_trans.scaleX += 10;
*		_trans.scaleY += 10;
*		// trace([_trans.rotate, _trans.scaleX, _trans.scaleY]);
*	};
*	// クリックした座標を基準に変形
*	mc.onPress = function() {
*		var x = this._xmouse;
*		var y = this._ymouse;
*		// trace([x, y]);
*		_trans.setTrans6Point(x, y);
*	};
*	</code>
* @author		Takano Yoshihiro
* @since		Flash Player 6 (ActionScript 2.0)
* @version		0.20070516
*
* @history		20070516 - 作成
*/
class net.yoshiweb.utils.movieclip.Trans6 {
	private var CLASS_NAME:String = "[Trans6]";
	private var _mc:MovieClip;
	private var _transPoint:Object;
	//
	private var _rotate:Number = 0;
	private var _scaleX:Number = 100;
	private var _scaleY:Number = 100;
	//
	// コンストラクタ
	function Trans6(mc:MovieClip) {
		_mc = mc;
		_rotate = mc._rotation;
		_scaleX = mc._xscale;
		_scaleY = mc._yscale;
		//
		_transPoint = new Object({x:0, y:0});
	}
	//
	/**
	* 変形点を設定
	* @param	x	変形点 x 座標
	* @param	y	変形点 y 座標
	*/
	public function setTrans6Point(x:Number, y:Number):Void {
		_transPoint = new Object({x:x, y:y});
	}
	/**
	* 水平スケールを取得
	* @return	水平スケール
	*/
	public function get scaleX():Number {
		return _scaleX;
	}
	/**
	* 水平スケールを設定
	* @param	s	スケール
	* @usage	
	*	<code>
	*	import net.yoshiweb.utils.movieclip.Trans6;
	*	//
	*	//座標 50, 50 を基準に変形
	*	var _trans = new Trans6(mc);
	*	_trans.setTrans6Point(50, 50);
	*	_trans.scaleX += 10;
	*	</code>
	*/
	public function set scaleX(s:Number) {
		_scaleX = s;
		var beforePoint:Object = getTrans6PointToGlobal();
		_mc._xscale = _scaleX;
		var afterPoint:Object = getTrans6PointToGlobal();
		_revisionXY(beforePoint, afterPoint);
	}
	/**
	* 垂直スケールを取得
	* @return	垂直スケール
	*/
	public function get scaleY():Number {
		return _scaleY;
	}
	/**
	* 垂直スケールを設定
	* @param	s	スケール
	* @usage	
	*	<code>
	*	import net.yoshiweb.utils.movieclip.Trans6;
	*	//
	*	//座標 50, 50 を基準に変形
	*	var _trans = new Trans6(mc);
	*	_trans.setTrans6Point(50, 50);
	*	_trans.scaleY += 10;
	*	</code>
	*/
	public function set scaleY(s:Number) {
		_scaleY = s;
		var beforePoint:Object = getTrans6PointToGlobal();
		_mc._yscale = _scaleY;
		var afterPoint:Object = getTrans6PointToGlobal();
		_revisionXY(beforePoint, afterPoint);
	}
	/**
	* 回転角度を取得
	* @return	回転角度
	*/
	public function get rotate():Number {
		return _rotate;
	}
	/**
	* 回転角度を設定
	* @param	r	回転角度
	* @usage	
	*	<code>
	*	import net.yoshiweb.utils.movieclip.Trans6;
	*	//
	*	//座標 50, 50 を基準に変形
	*	var _trans = new Trans6(mc);
	*	_trans.setTrans6Point(50, 50);
	*	_trans.rotate += 10;
	*	</code>
	*/
	public function set rotate(r:Number) {
		_rotate = r;
		// 変形前の座標取得
		// 変形
		// 変形後の座標取得
		// 座標補正
		var beforePoint:Object = getTrans6PointToGlobal();
		_mc._rotation = _rotate;
		var afterPoint:Object = getTrans6PointToGlobal();
		_revisionXY(beforePoint, afterPoint);
	}
	/**
	* グローバル座標基準の変形点の座標を取得
	* @return	グローバル基準の変形点の座標
	*/
	private function getTrans6PointToGlobal(Void):Object {
		var x:Number = _transPoint.x;
		var y:Number = _transPoint.y;
		//trace(_transPoint);
		//
		var point:Object = new Object({x:x, y:y});
		_mc.localToGlobal(point);
		//trace(point);
		return point;
	}
	/**
	* 座標補正
	* @param	beforePoint	変形前座標
	* @param	afterPoint	変形後座標
	*/
	private function _revisionXY(beforePoint:Object, afterPoint:Object):Void {
		// 変形前座標 - 変形後座標
		var x:Number = beforePoint.x-afterPoint.x;
		var y:Number = beforePoint.y-afterPoint.y;
		//
		// 移動
		_mc._x += x;
		_mc._y += y;
	}
	//
	//
	private function toString(Void):String {
		return CLASS_NAME;
	}
}
