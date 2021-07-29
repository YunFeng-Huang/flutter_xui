import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../css.dart';
import '../index.dart';

// ignore: must_be_immutable
class XButton extends StatefulWidget {
  TextStyle? textStyle;
  String? text;
  // TextStyle textStyle;
  double? width;
  double? height;
  double? horizontal;
  double? vertical;
  double? borderSize;
  Color? borderColor;
  Color? color;
  double? radius;
  Map? params;
  Function? api;
  Function? callback;
  XButton(this.text, {this.textStyle, this.width, this.height, this.borderSize, this.borderColor, this.radius, this.vertical, this.horizontal, this.params, this.api, required this.callback, this.color});
  @override
  _XButtonState createState() => _XButtonState();
}

class _XButtonState extends State<XButton> {
  TextStyle? get textStyle => widget.textStyle;
  String? get text => widget.text;
  double? get radius => widget.radius ?? 10.w;
  double? get width => widget.width;
  double? get height => widget.height;
  double? get horizontal => widget.horizontal;
  double? get vertical => widget.vertical;
  double? get borderSize => widget.borderSize;
  Color? get borderColor => widget.borderColor;
  Function? get api => widget.api;
  Function? get callback => widget.callback;
  Color? get color => widget.color;
  Map? get params => widget.params;
  bool _disabled = false;
  void onPressed() async {
    if (api != null) {
      setState(() {
        _disabled = true;
      });
      var data = await api?.call(params);
      print(data);
      await callback?.call(data);
      setState(() {
        _disabled = false;
      });
    } else {
      callback?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _disabled ? null : onPressed,
      child: Center(
        child: Text(
          text ?? '',
          style: textStyle ?? font(16, colorA: Colors.white),
        ).padding(horizontal: horizontal, vertical: vertical),
      ).background(color: color, border: borderSize, borderColor: borderColor, width: width, height: height, radius: radius),
    );
  }
}

// Widget button(title, onTap, {minWidth, width, height, color, fontStyle, disable = false, disableText, borderRadius}) {
//   return SizedBox(
//     width: width,
//     height: height,
//     child: TextButton(
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       color: color ?? HexToColor(ThemeColor.active),
//       // highlightColor: Colors.blue[700],
//       colorBrightness: Brightness.dark,
//       splashColor: Colors.grey,
//       disabledColor: HexToColor(ThemeColor.disable),
//       child: Text(disable ? disableText ?? title : title, style: fontStyle),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 20.0)),
//       onPressed: disable ? null : onTap,
//     ),
//   );
// }
