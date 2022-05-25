import 'dart:async';

import 'package:flutter/material.dart';

//用法  showToast('删除成功！') icon 为图标
showToast(context, String text) {
  return Toast.makeText(context:context, content:text,animated: Toast.ANIMATED_MOVEMENT_BTB).show();
}

debugInfo(context, String text) {
  bool isDev = !bool.fromEnvironment("dart.vm.product");
  if (isDev)
    return ToastCompoent.toast(context, 'debug提示:$text', showTime: 2000);
}

class Toast {
  // 透明  默认
  static final int ANIMATED_OPACITY = 0;
  // 平移 下上下   （bottom -> top -> bottom）
  static final int ANIMATED_MOVEMENT_BTB = 1;
  // 平移 左中右   （left -> centre -> right）
  static final int ANIMATED_MOVEMENT_LCR = 2;
  //Tween  demo
  static final int ANIMATED_MOVEMENT_TWEEN = 3;

  static final int LENGTH_SHORT = 0;
  static final int LENGTH_LONG = 1;
  static final int SHORT = 2000;
  static final int LONG = 2000;
  // 默认显示时间
  static int _milliseconds = 2000;
  // //toast靠它加到屏幕上
  // static OverlayEntry? _overlayEntry;
  //toast是否正在showing
  static bool _showing = false;

  static BuildContext? _context;
  // 显示文本内容
  static String? _content;
  // 字体颜色
  static Color _contentColor = Colors.white;
  // 背景颜色
  static Color _backgroundColor = Color.fromRGBO(0, 0, 0, 0.8);

  // 自定义 显示内容
  static Widget? _toastWidget;
  static ToastLayoutStyle style = ToastLayoutStyle(
      fontSize: 13, height: 18 / 13, horizontal: 10, vertical: 10);
  // 动画
  static int _animated = 0;
  // 执行动画时间
  static int _millisecondsShow = 200;
  static int _millisecondsHide = 400;
  static String? _toastPosition = 'center';
  static Toast makeText({
    required BuildContext context,
    String? content, //文本内容
    Color? contentColor, //字体颜色
    int duration = -1, // 显示时间
    Color? backgroundColor, //背景
    double? top, // 与上边  边距 距离
    String? toastPosition,
    int animated = 0, // 动画， 默认透明/不透明
    Widget? child, //自定义的 Toast
  }) {
    _toastPosition = toastPosition ?? 'center';
    if (content == null && child == null) {
      content = '未知...';
    }

    _context = context;
    _content = content;
    if (contentColor != null) {
      _contentColor = contentColor;
    }
    _milliseconds = duration <= LENGTH_SHORT ? SHORT : LONG;

    if (backgroundColor != null) {
      _backgroundColor = backgroundColor;
    }

    _animated = animated;

    if (child != null) {
      _toastWidget = child;
    } else {
      _toastWidget = _defaultToastLayout();
    }
    return Toast();
  }

  void show() {
    // _overlayEntry?.remove();
    // _overlayEntry = null;

    _showing = false;

    // 显示 Toast
    if (_animated == ANIMATED_MOVEMENT_TWEEN) {
      _makeTextShowTween();
    } else {
      _makeTextShowOpacity();
    }
  }

  //显示 文本 Toast  透明渐变
  static void _makeTextShowOpacity() async {
    //清除原有的 Toast

    DateTime _startedTime = DateTime.now();
    _showing = true;
    OverlayEntry? _overlayEntry;
    //创建OverlayEntry
    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
              //top值，可以改变这个值来改变toast在屏幕中的位置
              top: _calToastPosition(context),
              child: Container(
                alignment: Alignment.center, //居中
                width: MediaQuery.of(context).size.width, //Container 宽
                child: AnimatedOpacity(
                  //目标透明度
                  opacity: _showing ? 1.0 : 0.0,
                  //执行时间
                  duration: _showing
                      ? Duration(milliseconds: _millisecondsShow)
                      : Duration(milliseconds: _millisecondsHide),
                  child: _toastWidget,
                ),
              ),
            ));
    //显示到屏幕上
    Overlay.of(_context!)?.insert(_overlayEntry);
    //等待两秒
    await Future.delayed(Duration(milliseconds: _milliseconds));

    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >=
        _milliseconds) {
      _showing = false;
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
      //等待动画执行
      await Future.delayed(Duration(milliseconds: _millisecondsHide));
      if (!_showing) {
        _overlayEntry.remove();
        _overlayEntry = null;
      }
    }
  }

  /*
  显示时 初始化在屏幕外（下边） 平移/透明 到显示位置
  隐藏时 平移/透明 到屏幕外（下边）
  */
  // 平移 位置 参数

  static List<OverlayEntry> overlayEntryList = [];
  //显示 文本 Toast  Tween 动画
  static void _makeTextShowTween() async {
    DateTime _startedTime = DateTime.now();
    // _overlayEntry?.remove();
    // _overlayEntry = null;

    OverlayState? overlayState = Overlay.of(_context!);
    //透明显示动画控制器
    AnimationController showAnimationController = new AnimationController(
      vsync: overlayState!,
      duration: Duration(milliseconds: 250),
    );
    //平移动画控制器
    AnimationController offsetAnimationController = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );
    //平移动画控制器
    AnimationController hideOffsetAnimationController = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );
    //透明隐藏动画控制器
    AnimationController hideAnimationController = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );

    //透明显示动画
    Animation<double> opacityShow =
        new Tween(begin: 0.0, end: 1.0).animate(showAnimationController);
    //提供一个曲线，使动画感觉更流畅
    CurvedAnimation ffsetCurvedAnimation = new CurvedAnimation(
        parent: offsetAnimationController, curve: Curves.fastOutSlowIn);

    CurvedAnimation hideFfsetCurvedAnimation = new CurvedAnimation(
        parent: hideOffsetAnimationController, curve: Curves.fastOutSlowIn);

    //平移动画
    Animation<double> offsetAnim =
        new Tween(begin: 50.0, end: 0.0).animate(ffsetCurvedAnimation);

    Animation<double> offsetAnimHide =
        new Tween(begin: 0.0, end: -40.0).animate(hideFfsetCurvedAnimation);
    //透明隐藏动画
    Animation<double> opacityHide =
        new Tween(begin: 1.0, end: 0.0).animate(hideAnimationController);
    OverlayEntry? _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        //top值，可以改变这个值来改变toast在屏幕中的位置
        top: _calToastPosition(context),
        child: Container(
          alignment: Alignment.center, //居中
          width: MediaQuery.of(context).size.width, //Container 宽
          child: AnimatedBuilder(
            animation: opacityShow,
            child: _toastWidget,
            builder: (context, childToBuild) {
              return Opacity(
                opacity: opacityShow.value,
                child: AnimatedBuilder(
                  animation: offsetAnim,
                  builder: (context, _) {
                    return Transform.translate(
                      offset: Offset(0, offsetAnim.value),
                      child: AnimatedBuilder(
                        animation: opacityHide,
                        builder: (context, _) {
                          return AnimatedBuilder(
                            animation: offsetAnimHide,
                            builder: (BuildContext context, Widget? child) {
                              return Transform.translate(
                                offset: Offset(0, offsetAnimHide.value),
                                child: Opacity(
                                  opacity: opacityHide.value,
                                  child: childToBuild,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    });
    //显示到屏幕上
    overlayState.insert(_overlayEntry);
    //执行显示动画
    showAnimationController.forward();
    offsetAnimationController.forward();
    //等待
    await Future.delayed(Duration(milliseconds: _milliseconds));

    //执行隐藏动画
    hideOffsetAnimationController.forward();
    hideAnimationController.forward();
    //等待动画执行
    await Future.delayed(Duration(milliseconds: 250));
    _overlayEntry.remove();
    _overlayEntry = null;
  }

  //toast绘制
  static _defaultToastLayout() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        //限制 最大宽度
        maxWidth: MediaQuery.of(_context!).size.width / 5 * 4,
      ),
      child: Card(
        color: _backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: style.horizontal, vertical: style.vertical),
          child: Text(_content!,
              style: TextStyle(
                  fontSize: style.fontSize,
                  color: _contentColor,
                  height: style.height),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ),
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

//自定义 一个曲线  当然 也可以使用SDK提供的 如： Curves.fastOutSlowIn
class MyCurve extends Curve {
  @override
  double transform(double t) {
    t -= 1.0;
    double b = t * t * ((2 + 1) * t + 2) + 1.0;
    return b;
  }
}

class ToastLayoutStyle {
  late double horizontal;
  late double vertical;
  late double fontSize;
  late double height;
  ToastLayoutStyle(
      {required this.horizontal,
      required this.vertical,
      required this.fontSize,
      required this.height});
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
                        fontWeight: FontWeight.w300),
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
