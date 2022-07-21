import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class XAlert {
  BuildContext context;
  Color backgroundColor = Color.fromRGBO(0, 0, 0, 0.5);
  Color backgroundColorDark = Color.fromRGBO(0, 0, 0, 0.4);
  XAlert(this.context);

  /// 底部弹出提示框
  showBottomAlertCustom({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor: CupertinoDynamicColor.withBrightness(
        color: backgroundColor,
        darkColor: backgroundColorDark,
      ),
      context: context,
      builder: (context) {
        return showBottomAlertCustomWidget(callback, list, title);
      },
    );
  }

  /// 底部弹出提示框
  showBottomAlertIos({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor: CupertinoDynamicColor.withBrightness(
        color: backgroundColor,
        darkColor: backgroundColorDark,
      ),
      context: context,
      builder: (context) {
        return ShowCustomAlterWidget(callback, list, title);
      },
    );
  }

  /// 底部弹出提示框
  showBottomAlertAndroid({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor: CupertinoDynamicColor.withBrightness(
        color: backgroundColor,
        darkColor: backgroundColorDark,
      ),
      context: context,
      builder: (context) {
        return XButton(
          callback: () {
            Navigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(
                children: [
                  Column(
                    children: List.generate(
                      list.length,
                      (index) => XButton(
                        callback: () {
                          Navigator.pop(context);
                          callback(index);
                        },
                        child: Text(list[index],
                                style: font(32, colorA: themeColor.headline1))
                            .center
                            .background(
                                height: 112.w, borderTop: index == 0 ? 0 : 1.w),
                      ),
                    ),
                  ),
                  Container(
                    height: 20.w,
                    color: themeColor.background,
                  ),
                  XButton(
                    callback: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '取消',
                      style: font(32, colorA: themeColor.headline1),
                    ).center.background(height: 110.w),
                  )
                ],
              )
                  .background(
                      color: themeColor.white, topRight: 16.w, topLeft: 16.w)
                  .bottomCenter
            ]),
          ),
        );
      },
    );
  }

  /// 中间弹出提示框
  showCenterTipsAlter(
      {required Function callback,
      title,
      info,
      cancalText,
      sureText,
      width,
      height,
      bool sureBtn = true,
      bool cancalBtn = true,
      child}) {
    return showCupertinoModalPopup(
      barrierColor: CupertinoDynamicColor.withBrightness(
        color: backgroundColor,
        darkColor: backgroundColorDark,
      ),
      context: context,
      builder: (BuildContext context) {
        return ShowTipsAlterWidget(
            callback, cancalText, sureText, width, height, sureBtn, cancalBtn,
            child: child, info: info, title: title);
      },
    );
  }
}

class ShowTipsAlterWidget extends StatefulWidget {
  final callback;
  final info;
  String? title;
  String? cancalText;
  String? sureText;
  double? width;
  double? height;
  bool? sureBtn;
  bool? cancalBtn;
  Widget? child;
  ShowTipsAlterWidget(
    this.callback,
    this.cancalText,
    this.sureText,
    this.width,
    this.height,
    this.sureBtn,
    this.cancalBtn, {
    this.child,
    this.info,
    this.title,
  });
  @override
  _ShowTipsAlterWidgetState createState() => _ShowTipsAlterWidgetState();
}

class _ShowTipsAlterWidgetState extends State<ShowTipsAlterWidget> {
  Widget? get child => widget.child;
  bool disabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Transform.translate(
          offset:
              Offset(0, -(MediaQueryData.fromWindow(window).padding.top) / 2),
          child: Center(
            child: new Column(
              children: <Widget>[
                if (widget.title != null) _titleView(),
                Expanded(
                  child: widget.child ?? _textView(),
                ),
                Divider(height: 1.w, color: globalConfig.theme.dividerColor),
                _buttonView(),
              ],
            ).background(
              width: widget.width ?? 560.w,
              height: widget.height ?? 330.w,
              color: globalConfig.theme.primaryColorLight,
              radius: 16.w,
            ),
          )),
    );
  }

  Widget _titleView() {
    return Center(
      child: Text(
        widget.title ?? '提示',
        style: font(36, colorA: (themeColor.white!), weight: FontWeight.w500),
      ),
    ).background(height: 50.w).margin(top: 40.w);
  }

  Widget _textView() {
    return Center(
      child: Text(
        widget.info ?? '',
        style: font(28, colorA: (themeColor.headline2!), height: 40 / 28),
      ),
    );
  }

  Widget _buttonView() {
    return new Container(
      height: 88.w,
      child: new Row(
        children: <Widget>[
          if (widget.cancalBtn!)
            new Expanded(
              child: _getLiftBtn(),
            ),
          new Container(
            width: 1.w,
            color: themeColor.divider,
          ),
          if (widget.sureBtn!)
            new Expanded(
              child: _getRightBtn(),
            ),
        ],
      ),
    );
  }

  Widget _getLiftBtn() {
    return XButton(
      text: widget.cancalText ?? '取消',
      callback: () => Navigator.pop(context, false),
      style: font(32, colorA: themeColor.headline3, weight: FontWeight.w400),
    ).center;
  }

  Widget _getRightBtn() {
    return XButton(
      disabled: disabled,
      text: widget.sureText ?? '确认',
      style: font(
        32,
        colorA: themeColor.primary,
        weight: FontWeight.w400,
      ),
      callback: () async {
        disabled = true;
        setState(() {});
        bool? value = await widget.callback?.call();
        disabled = false;
        setState(() {});
        if (value == null || value) Navigator.pop(context, true);
      },
    ).center;
  }
}

class showBottomAlertCustomWidget extends StatefulWidget {
  final confirmCallback;
  final list;
  final title;

  const showBottomAlertCustomWidget(
      this.confirmCallback, this.list, this.title);

  @override
  State<showBottomAlertCustomWidget> createState() =>
      _showBottomAlertCustomWidgetState();
}

class _showBottomAlertCustomWidgetState
    extends State<showBottomAlertCustomWidget> {
  @override
  Widget build(BuildContext context) {
    // widget.list.add('取消');
    return XButton(
      callback: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(
            children: [
              Text(
                '选择图片',
                style: font(26, colorA: themeColor.headline4),
              ).center.background(height: 110.w),
              Column(
                children: List.generate(
                  widget.list.length,
                  (index) => XButton(
                    callback: () {
                      Navigator.pop(context);
                      widget.confirmCallback(index);
                    },
                    child: Text(widget.list[index],
                            style: font(32, colorA: themeColor.headline1))
                        .center
                        .background(height: 110.w),
                  ),
                ),
              ),
              XButton(
                callback: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '取消',
                  style: font(32, colorA: themeColor.headline1),
                ).center.background(height: 110.w, borderTop: 1.w),
              )
            ],
          )
              .background(
                  color: themeColor.white, topRight: 16.w, topLeft: 16.w)
              .bottomCenter
        ]),
      ),
    );
  }
}

class ShowCustomAlterWidget extends StatefulWidget {
  final confirmCallback;
  final list;
  final title;

  const ShowCustomAlterWidget(this.confirmCallback, this.list, this.title);

  @override
  _ShowCustomAlterWidgetState createState() => _ShowCustomAlterWidgetState();
}

class _ShowCustomAlterWidgetState extends State<ShowCustomAlterWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: widget.title == null ? null : Text(widget.title),
      actions: List.generate(
        widget.list.length,
        (index) => CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            widget.confirmCallback(index);
          },
          child: Text(widget.list[index]),
        ),
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('取消'),
      ),
    );
  }
}

class ShowInputAlertWidget extends StatefulWidget {
  final callback;
  final title;
  final placeholder;
  const ShowInputAlertWidget(this.callback, this.title, this.placeholder);

  @override
  _ShowInputAlertWidgetState createState() => _ShowInputAlertWidgetState();
}

class _ShowInputAlertWidgetState extends State<ShowInputAlertWidget> {
  String inputValue = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Column(
        children: <Widget>[
          CupertinoTextField(
            placeholder: widget.placeholder,
            onChanged: (value) {
              inputValue = value;
            },
          )
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("取消"),
          onPressed: () {
            Navigator.pop(context);
            widget.callback(null);
          },
        ),
        CupertinoDialogAction(
          child: Text("确认"),
          onPressed: () {
            widget.callback(inputValue);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
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
              color: themeColor.white,
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
          backgroundColor: themeColor.white,
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
