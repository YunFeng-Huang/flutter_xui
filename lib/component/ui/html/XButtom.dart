import 'package:flutter/material.dart';

Function XButtonInterceptor = () async {};

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
  Color? color;
  double? radius;
  Map? params;
  Function? paramsFn;
  Function? api;
  Function callback;
  bool? disabled;
  XButtonType? type;
  Widget? child;

  XButton({
    this.child,
    this.disabled = false,
    required this.callback,
    this.color,
  }) {
    type = type ?? XButtonType.btn;
  }
  @override
  _XButtonState createState() => _XButtonState();
}

class _XButtonState extends State<XButton> {
  Color? get color => widget.color;
  Widget? get child => widget.child;
  Function get callback => widget.callback;
  bool _disabled = false;

  // void onPressed() async {
  //   setState(() {
  //     _disabled = true;
  //   });
  //   await XButtonInterceptor();
  //   await callback?.call();
  //   setState(() {
  //     _disabled = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool disabled = _disabled || widget.disabled!;
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:()=>callback(),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

enum XButtonType { btn, text }
