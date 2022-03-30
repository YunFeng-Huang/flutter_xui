import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../js/index.dart';
import '../index.dart';
import '../js/color_utils.dart';
import 'css.dart';

//用法  showToast('删除成功！') icon 为图标
showToast(context, String text, {icon, showTime = 2000}) {
  return ToastCompoent.toast(context, text, icon: icon, showTime: showTime);
}

//用法 showLoading('加载中，请等待... ...')
showLoading(context, [String text = "加载中，请等待..."]) {
  return showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.w,
                )
              ]),
          padding: EdgeInsets.all(20.w),
          // margin: EdgeInsets.all(.w),
          // constraints: BoxConstraints(minHeight: 220.w, minWidth: 220.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Loading(text: text),
            ],
          ),
        ),
      );
    },
  );
}

Future<dynamic>? showConfirmDialog(
  BuildContext context,
  String text, {
  Function? confirmCallback,
  submitTitle = '确定',
  cancelTitle = "取消",
  title = '温馨提示',
}) {
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Container(
            height: 80.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(235, 236, 236, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                topRight: Radius.circular(20.w),
              ),
            ),
            child: Text(
              title,
              style: font(30, color: '#3e3e3e'),
            ),
          ),
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.w),
            ),
          ),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 56.w, horizontal: 42.w),
              child: Text(
                text,
                style: font(26, color: '#030303'),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Row(
                children: [
                  if (cancelTitle != null)
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 76.w,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 236, 236, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.w),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(cancelTitle),
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        confirmCallback?.call();
                        if (confirmCallback != null) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        // width: 340.w,
                        height: 76.w,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: NetworkImage(telIcon),
                        //     fit: BoxFit.fill,
                        //     alignment: AlignmentDirectional.topStart,
                        //   ),
                        // ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(253, 100, 79, 1),
                              Color.fromRGBO(241, 141, 39, 1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.w),
                            bottomLeft: Radius.circular(
                                cancelTitle != null ? 0.w : 20.w),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          submitTitle,
                          style: font(28, color: '#ffffff'),
                        ).background(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

//空状态
Widget EmptyListType(context, {img, callback, text}) {
  return Center(
    child: Container(
      height: 600.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.w,
          ),
          Image.asset(
            img == '404' ? 'images/404.png' : 'assets/default/cater_search.png',
            width: 215.w,
            height: 134.w,
          ),
          Text(
            text ?? '暂无内容，请稍后尝试！',
            style: font(26, color: '#909090'),
          ),
          GestureDetector(
            onTap: () {
              showLoading(context);
              Timer(Duration(seconds: 3), () {
                // Routers.pop();
                Navigator.pop(context);
                callback?.call();
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 150.w),
              width: 290.w,
              height: 70.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: HexToColor('#909090'),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(35.w),
              ),
              child: Text('点击刷新', style: font(26, color: '#333333')),
            ),
          ),
        ],
      ),
    ),
  );
}

class ToastCompoent {
  static OverlayEntry? _overlayEntry; // toast靠它加到屏幕上
  static bool _showing = false; // toast是否正在showing
  static DateTime? _startedTime; // 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static String? _msg; // 提示内容
  static int? _showTime; // toast显示时间
  static Color? _bgColor; // 背景颜色
  static Color? _textColor; // 文本颜色
  static double? _textSize; // 文字大小
  static String? _toastPosition; // 显示位置
  static double? _pdHorizontal; // 左右边距
  static double? _pdVertical; // 上下边距
  static IconData? _img; //图标
  static BuildContext? _context;
  static void toast(
    BuildContext context,
    String msg, {
    IconData? icon,
    int showTime = 2000,
    Color? bgColor,
    Color textColor = Colors.white,
    double textSize = 13.0,
    String position = 'center',
    double pdHorizontal = 10.0,
    double pdVertical = 10.0,
  }) async {
    _context = context;
    _msg = msg;
    _img = icon;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _bgColor = bgColor ?? Color.fromRGBO(0, 0, 0, 0.8);
    _textColor = textColor;
    _textSize = textSize;
    _toastPosition = position;
    _pdHorizontal = pdHorizontal;
    _pdVertical = pdVertical;
    //获取OverlayState
    OverlayState? overlayState = Overlay.of(_context!);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          //top值，可以改变这个值来改变toast在屏幕中的位置
          top: _calToastPosition(context),
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: AnimatedOpacity(
                  opacity: _showing ? 1.0 : 0.0, //目标透明度
                  duration: _showing
                      ? Duration(milliseconds: 100)
                      : Duration(milliseconds: 300),
                  child: _buildToastWidget(),
                ),
              )),
        ),
      );
      Future.delayed(Duration(milliseconds: 1), () {
        overlayState!.insert(_overlayEntry!);
      });
    } else {
      Future.delayed(Duration(milliseconds: 1), () {
        _overlayEntry!.markNeedsBuild();
      });

      //重新绘制UI，类似setState
    }
    await Future.delayed(Duration(milliseconds: _showTime!)); // 等待时间
    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime!).inMilliseconds >= _showTime!) {
      _showing = false;
      _overlayEntry!.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 200));
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  //toast绘制
  static _buildToastWidget() {
    return Center(
      child: Card(
        color: _bgColor,
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _pdHorizontal!, vertical: _pdVertical!),
            child: _img == null
                ? Text(
                    _msg!,
                    style: TextStyle(
                      fontSize: _textSize,
                      color: _textColor,
                      fontWeight: FontWeight.w300
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Icon(
                        _img,
                        color: _textColor,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        _msg!,
                        style: TextStyle(
                          fontSize: _textSize,
                          color: _textColor,
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

//  设置toast位置
  static _calToastPosition(context) {
    var backResult;
    if (_toastPosition == 'top') {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (_toastPosition == 'center') {
      backResult = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }
}
