import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class XAlert {
  BuildContext context;
  Color backgroundColor = Color.fromRGBO(0, 0, 0, 0.5);
  XAlert(this.context);

  /// 底部弹出提示框
  showBottomAlert({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor:CupertinoDynamicColor.withBrightness(
        color: backgroundColor,
        darkColor: Color(0x7A000000),
      ),
      context: context,
      builder: (context) {
        return ShowCustomAlterWidget(callback, list, title);
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
      barrierColor:CupertinoDynamicColor.withBrightness(
        color: backgroundColor,
        darkColor: Color(0x7A000000),
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
      body: Center(
        child: new Column(
          children: <Widget>[
            if (widget.title != null) _titleView(),
            Expanded(
              child: widget.child ?? _textView(),
            ),
            Divider(height: 1.w, color: themeColor.line),
            _buttonView(),
          ],
        ).background(
            width: widget.width ?? 560.w,
            height: widget.height ?? 330.w,
            colorA: Colors.white,
            radius: 16.w,
        ),
      ),
    );
  }

  Widget _titleView() {
    return Center(
      child: Text(
        widget.title ?? '提示',
        style: font(36, color: '#333333', weight: FontWeight.w500),
      ),
    ).background(height: 50.w).margin(top: 40.w);
  }

  Widget _textView() {
    return Center(
      child: Text(
        widget.info ?? '',
        style: font(28, color: '#3D3B48', height: 40 / 28),
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
            color: themeColor.line,
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
      style: font(32, colorA: themeColor.gray, weight: FontWeight.w400),
    ).center;
  }

  Widget _getRightBtn() {
    return XButton(
      disabled: disabled,
      text: widget.sureText ?? '确认',
      style: font(
        32,
        colorA: themeColor.active,
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

class ShowCustomAlterWidget extends StatefulWidget {
  final confirmCallback;
  final list;
  final title;

  const ShowCustomAlterWidget(this.confirmCallback, this.list, this.title);

  @override
  _ShowCustomAlterWidgetState createState() => _ShowCustomAlterWidgetState();
}

class _ShowCustomAlterWidgetState extends State<ShowCustomAlterWidget> {
  final controller = TextEditingController();

  String inputValuue = "";

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
