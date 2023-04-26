import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/xui.dart';

class TipsAlterHeightAutoWidget extends StatefulWidget {
  final Function? callback;
  final String? info;
  final String? title;
  final String? cancelText;
  final String? sureText;
  final double? width;
  final double? height;
  final bool? sureBtn;
  final bool? cancelBtn;
  final Widget? child;
  final double? maxHeight;
  final double? minHeight;
  final bool? elevation;
  final Color? cancelBtnBackgroundColor;
  final Color? sureBtnBackgroundColor;
  final Color? cancelBtnTextColor;
  final Color? sureBtnTextColor;
  final bool? barrierDismissible;
  TipsAlterHeightAutoWidget(
    this.callback,
    this.cancelText,
    this.sureText,
    this.width,
    this.height,
    this.sureBtn,
    this.cancelBtn, {
    this.child,
        this.barrierDismissible,
    this.info,
    this.title,
    this.maxHeight,
    this.minHeight,
    this.elevation,
        this.cancelBtnBackgroundColor,
        this.sureBtnBackgroundColor,
        this.cancelBtnTextColor,
        this.sureBtnTextColor,
  });
  @override
  _TipsAlterWidgetState createState() => _TipsAlterWidgetState();
}

class _TipsAlterWidgetState extends State<TipsAlterHeightAutoWidget> {
  Widget? get child => widget.child;
  bool disabled = false;
  double _buttonViewHeight = 87.w;
  double get _topViewHeight => widget.title == null
      ? 0
      : widget.elevation ?? false
          ? 107.w
          : 112.w;
  double? get _centerViewHeight => widget.height == null ? null : ((widget.height ?? 0.0) - _topViewHeight - _buttonViewHeight + 1.w);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(widget.barrierDismissible??false);
      },
      child:Scaffold(
        backgroundColor: Colors.transparent,
        body: Transform.translate(
          offset: Offset(0, -(MediaQueryData.fromWindow(window).padding.top) / 2),
          child: Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    if (widget.title != null)
                      _titleView()
                          .padding(
                        top: widget.elevation ?? false ? 34.w : 37.w,
                        bottom: widget.elevation ?? false ? 34.w : 33.w,
                      )
                          .background(
                        borderBottom: widget.elevation ?? false ? 1.w : null,
                        border: widget.elevation ?? false ? 1.w : null,
                      )
                          .background(color: themeColor.ffFFFFFF, topLeft: 16.w, topRight: 16.w, height: _topViewHeight),
                    SingleChildScrollView(child: (widget.child ?? ((widget.elevation ?? false) ? (_textView().center) : (_textView().topCenter))).padding(left: 30.w, right: 30.w, bottom: 60.w)).background(
                      maxHeight: widget.height ?? 550.w,
                      minHeight: widget.height,
                    ),
                  ],
                ).background(
                  width: widget.width ?? 550.w,
                  color: themeColor.ffFFFFFF,
                  topLeft: 16.w,
                  topRight: 16.w,
                  bottomLeft:!(widget.cancelBtn! || widget.sureBtn!)? 16.w:null,
                  bottomRight: !(widget.cancelBtn! || widget.sureBtn!)? 16.w:null,
                ),
                // Divider(height: 1.h, color: themeColor.ffFFFFFF),
                if (widget.cancelBtn! || widget.sureBtn!)  _buttonView().background(
                  width: widget.width ?? 550.w,
                  color: themeColor.ffFFFFFF,
                  bottomLeft: 16.w,
                  bottomRight: 16.w,
                  height: _buttonViewHeight,
                ),
              ],
            ).background(   width: widget.width ?? 550.w,),
          ),
        ),
      ),
    );
  }

  Widget _titleView() {
    return Center(
      child: Text(
        widget.title ?? '提示',
        style: font(
          32,
          colorA: (themeColor.ff3D3B48!),
          weight: FontWeight.w500,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _textView() {
    return Center(
      child: Text(
        widget.info ?? '',
        textAlign: TextAlign.center,
        style: font(32, colorA: (themeColor.ff3D3B48), height: 1.2, weight: FontWeight.w500),
      ),
    );
  }

  Widget _buttonView() {
    return new Row(
      children: <Widget>[
        if (widget.cancelBtn!)
          new Expanded(
            child: _getLiftBtn().background(color: widget.cancelBtnBackgroundColor??Colors.transparent, bottomLeft: 16.w,
             ),
          ),
        new Container(
          width: 1.w,
          color: themeColor.ffDEDFDE,
        ),
        if (widget.sureBtn!)
          new Expanded(
            child: _getRightBtn().background(color:widget.sureBtnBackgroundColor??Colors.transparent, bottomRight: 16.w,),
          ),
      ],
    );
  }

  Widget _getLiftBtn() {
    return XButton(
      child: Text(
        widget.cancelText ?? '取消',
        style: font(32, colorA:widget.cancelBtnTextColor?? themeColor.ff6C7480, weight: FontWeight.w400),
      ),
      callback: () => Navigator.pop(context, false),
    ).center;
  }

  Widget _getRightBtn() {
    return XButton(
      child: Text(
        widget.sureText ?? '确认',
        style: font(
          32,
          colorA:widget.sureBtnTextColor?? themeColor.primary,
          weight: FontWeight.w400,
        ),
      ),
      // disabled: disabled,
      callback: () async {
        // disabled = true;
        setState(() {});
        bool? value = await widget.callback?.call();
        // disabled = false;
        setState(() {});
        if (value == null || value) Navigator.pop(context, true);
      },
    ).center;
  }
}

SafeArea AlertModalPopupWidget(BuildContext context, child, Widget? bottom, double? bottomHeight, Function? leftCallBack, String? leftText, String? title, bool? elevation, double? height) {
  return SafeArea(
    bottom: true,
    child: AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: child(context),
                  margin: EdgeInsets.only(top: 92.w, bottom: bottom == null ? 0 : (bottomHeight ?? 88.w)),
                ),
                Positioned(
                  width: ScreenUtil().screenWidth,
                  child: bottom ?? SizedBox(),
                  bottom: 0,
                  left: 0,
                ),
                Positioned(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      XButton(
                        callback: () => leftCallBack?.call(),
                        child: Text(
                          '${leftText ?? ''}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themeColor.ff3D3B48),
                        ).centerLeft.background(width: 150.w),
                      ),
                      Text(
                        '${title ?? ''}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: themeColor.primary),
                      ).center.background(height: 44.w).padding(vertical: 24.w).center,
                      XButton(
                        callback: () => Navigator.pop(context),
                        child: Icon(
                          // Icons.close_outlined,
                          const IconData(0xe648, fontFamily: 'iconfont'),
                          size: 24.w,
                          color: themeColor.ff9EA6AE,
                        ).center.background(height: 40.w, width: 40.w).centerRight.background(width: 150.w),
                      )
                    ],
                  ).padding(horizontal: 32.w).background(height: 92.w, topRight: 16.w, topLeft: 16.w, borderBottom: elevation ?? false ? 1.w : null, width: ScreenUtil().screenWidth),
                  top: 0,
                  left: 0,
                ),
              ],
            ).background(topRight: 16.w, topLeft: 16.w, color: themeColor.ffFFFFFF, width: ScreenUtil().screenHeight, height: ScreenUtil().screenHeight / 2).bottomCenter,
          ],
        ),
      ).background(height: height ?? ScreenUtil().screenHeight * 0.5),
    ),
  );
}

// ignore: must_be_immutable
class ShowTipsAlterWidget extends StatefulWidget {
  final callback;
  final info;
  String? title;
  String? cancelText;
  String? sureText;
  double? width;
  double? height;
  bool? sureBtn;
  bool? cancelBtn;
  Widget? child;
  ShowTipsAlterWidget(
    this.callback,
    this.cancelText,
    this.sureText,
    this.width,
    this.height,
    this.sureBtn,
    this.cancelBtn, {
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
          offset: Offset(0, -(MediaQueryData.fromWindow(window).padding.top) / 2),
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
              color: themeColor.ffFFFFFF,
              radius: 16.w,
            ),
          )),
    );
  }

  Widget _titleView() {
    return Center(
      child: Text(
        widget.title ?? '提示',
        style: font(36, colorA: (themeColor.ffFFFFFF!), weight: FontWeight.w500),
      ),
    ).background(height: 50.w).margin(top: 40.w);
  }

  Widget _textView() {
    return Center(
      child: Text(
        widget.info ?? '',
        style: font(28, colorA: (themeColor.ff3D3B48!), height: 40 / 28),
      ),
    );
  }

  Widget _buttonView() {
    return new Container(
      height: 88.w,
      child: new Row(
        children: <Widget>[
          if (widget.cancelBtn!)
            new Expanded(
              child: _getLiftBtn(),
            ),
          new Container(
            width: 1.w,
            color: themeColor.ffDEDFDE,
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
      child: Text(widget.cancelText ?? '取消', style: font(32, colorA: themeColor.ff6C7480, weight: FontWeight.w400)),
      callback: () => Navigator.pop(context, false),
    ).center;
  }

  Widget _getRightBtn() {
    return XButton(
      // disabled: disabled,
      child: Text(widget.sureText ?? '确认',
          style: font(
            32,
            colorA: themeColor.ffFF4300,
            weight: FontWeight.w400,
          )),
      callback: () async {
        // disabled = true;
        // setState(() {});
        bool? value = await widget.callback?.call();
        // disabled = false;
        // setState(() {});
        if (value == null || value) Navigator.pop(context, true);
      },
    ).center;
  }
}

class showBottomAlertCustomWidget extends StatefulWidget {
  final confirmCallback;
  final list;
  final title;

  const showBottomAlertCustomWidget(this.confirmCallback, this.list, this.title);

  @override
  State<showBottomAlertCustomWidget> createState() => _showBottomAlertCustomWidgetState();
}

class _showBottomAlertCustomWidgetState extends State<showBottomAlertCustomWidget> {
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
                style: font(26, colorA: themeColor.ff9EA6AE),
              ).center.background(height: 53),
              Column(
                children: List.generate(
                  widget.list.length,
                  (index) => XButton(
                    callback: () {
                      Navigator.pop(context);
                      widget.confirmCallback(index);
                    },
                    child: Text(widget.list[index], style: font(32, colorA: themeColor.primary)).center.background(height: 56),
                  ),
                ),
              ),
              XButton(
                callback: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '取消',
                  style: font(32, colorA: themeColor.primary),
                ).center.background(height: 56, borderTop: 1.w),
              )
            ],
          ).background(color: themeColor.ffFFFFFF, topRight: 16.w, topLeft: 16.w).bottomCenter
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
