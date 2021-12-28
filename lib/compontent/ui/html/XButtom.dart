import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../css.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XButton extends StatefulWidget {
  TextStyle? style;
  String? text;
  double? width;
  double? height;
  double? horizontal;
  double? vertical;
  double? borderSize;
  String? borderColor;
  String? color;
  Color? colorA;
  double? radius;
  Map? params;
  Function? paramsFn;
  Function? api;
  Function? callback;
  bool? disabled;
  XButtonType? type;
  Widget? child;
  XButton({
    this.text,
    this.style,
    this.child,
    this.type,
    this.width,
    this.height,
    this.paramsFn,
    this.borderSize,
    this.borderColor,
    this.radius,
    this.vertical,
    this.horizontal,
    this.disabled = false,
    this.params,
    this.api,
    required this.callback,
    this.color,
    this.colorA,
  }) {
    type = type ?? XButtonType.btn;
  }
  @override
  _XButtonState createState() => _XButtonState();
}

class _XButtonState extends State<XButton> {
  TextStyle? get style => widget.style;
  String? get text => widget.text;
  double? get radius => widget.radius ?? 10.w;
  double? get width => widget.width;
  double? get height => widget.height;
  double? get horizontal => widget.horizontal;
  double? get vertical => widget.vertical;
  double? get borderSize => widget.borderSize;
  Color? get borderColor =>
      widget.borderColor != null ? HexToColor(widget.borderColor!) : null;
  Color? get color =>
      widget.colorA ??
      (widget.color != null ? HexToColor(widget.color!) : null);
  Widget? get child => widget.child;
  Map? get params =>
      isNotNull(widget.paramsFn) ? widget.paramsFn?.call() : widget.params;
  Function? get api => widget.api;
  Function? get callback => widget.callback;
  bool _disabled = false;
  void onPressed() async {
    if (api != null) {
      setState(() {
        _disabled = true;
      });
      if (params != null) {
        var data = await api?.call(new Map<String, dynamic>.from(params!));
        if (data != null) {
          await callback?.call(data);
        }
      }
      setState(() {
        _disabled = false;
      });
    } else {
      callback?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool disabled = _disabled || widget.disabled!;
    bool _type = widget.type == XButtonType.btn;
    Color? _color = disabled && _type ? color?.withOpacity(0.8) : color;
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: disabled ? null : onPressed,
        child: child ??
            (Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                if(disabled && _type)  Container(
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(_color??themeColor.active!),
                      strokeWidth: 2.w,
                    ),
                  ),
                  Text(
                    text ?? '',
                    style: !_type && disabled
                        ? TextStyle(color: themeColor.disable)
                        : style,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).margin(horizontal: 20.w)
                ],
              ).padding(horizontal: horizontal, vertical: vertical),
            ).background(
                colorA: _color,
                border: borderSize,
                borderColor: borderColor ?? themeColor.line,
                width: width,
                height: height,
                radius: radius)),
      ),
    );
  }
}

enum XButtonType { btn, text }
