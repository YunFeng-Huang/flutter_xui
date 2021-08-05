import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/js/index.dart';
import 'package:xui/compontent/ui/css.dart';
import '../index.dart';

// ignore: must_be_immutable
class XCheckBox extends StatefulWidget {
  bool? value;
  Function(bool?)? onChanged;
  String? activeColor;
  double? radius;
  Color? color;
  double? size;
  String? label;
  Widget? left;
  Widget? right;
  XCheckBox({required this.value, required this.onChanged, this.activeColor, this.radius, this.color, this.size, this.label, this.left, this.right});
  @override
  _XCheckBoxState createState() => _XCheckBoxState();
}

class _XCheckBoxState extends State<XCheckBox> {
  bool value = false;
  Function(bool?)? get onChanged => widget.onChanged;
  String? get activeColor => widget.activeColor;
  double? get radius => widget.radius;
  Color? get color => widget.color ?? Colors.white;
  double get size => widget.size ?? 20;
  Widget? get left => widget.left;
  Widget? get right => widget.right;
  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _icon = (value
        ? Icon(
            Icons.check,
            size: size,
            color: Colors.blue,
          )
        : Icon(
            Icons.check,
            size: size,
            color: Colors.transparent,
          ));
    return GestureDetector(
      child: Row(
        children: [
          if (isNotNull(left)) left!.margin(right: 10.w),
          _icon.background(
            radius: radius ?? 4.w,
            color: color,
            border: 1.w,
            borderColor: ThemeColor.border,
          ),
          if (isNotNull(right)) right!.margin(left: 10.w)
        ],
      ),
      onTap: () {
        setState(() {
          value = !value;
        });
        onChanged!(value);
      },
    );
  }
}
