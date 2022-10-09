import 'package:flutter/material.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XCheckBox extends StatefulWidget {
  bool? value;
  bool? disable;
  Function(bool?)? onChanged;
  double? radius;
  Color? color;
  double? size;
  String? label;
  Widget? left;
  Widget? right;
  String? activeImg;
  String? defaultImg;
  XCheckBox(
      {required this.value,
      required this.onChanged,
      this.radius,
      this.disable,
      this.color,
      this.size,
      this.label,
      this.left,
      this.right,
      this.activeImg,
      this.defaultImg});
  @override
  _XCheckBoxState createState() => _XCheckBoxState();
}

class _XCheckBoxState extends State<XCheckBox> {
  bool get _value => widget.value!;
  set _value(v) {
    onChanged!(v);
  }

  Function(bool?)? get onChanged => widget.onChanged;
  double? get radius => widget.radius;
  Color? get color => widget.color ?? Colors.white;
  double get size => widget.size ?? 20;
  Widget? get left => widget.left;
  Widget? get right => widget.right;
  String? get activeImg => widget.activeImg;
  String? get defaultImg => widget.defaultImg;
  bool? get disable => widget.disable ?? false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _icon = (_value
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

    return XButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isNotNull(left)) left!.margin(right: 10.w),
          isNotNull(activeImg)
              ? (_value
                  ? XImage(
                      image: activeImg!,
                      width: size,
                      height: size,
                    )
                  : XImage(image: defaultImg!, width: size, height: size))
              : _icon.background(
                  radius: 4.w,
                  color: color,
                  border: 1.w,
                  borderColor: themeColor.ffDEDFDE,
                ),
          if (isNotNull(right)) right!.margin(left: 10.w)
        ],
      ),
      disabled: disable ?? false,
      callback: () {
        _value = !_value;
        setState(() {});
      },
    );
  }
}

// ignore: must_be_immutable
class XCheckBoxGroup extends StatefulWidget {
  String? labelImg;
  double? labelImgSize;
  double? horizontal;
  double? vertical;
  Widget labelWidget;
  XCheckBox child;
  Function callback;
  bool value;
  bool? radio;
  XCheckBoxGroup({
    this.radio,
    this.labelImg,
    this.labelImgSize,
    this.horizontal,
    this.vertical,
    required this.value,
    required this.labelWidget,
    required this.child,
    required this.callback,
  });
  @override
  _XCheckBoxGroupState createState() => _XCheckBoxGroupState();
}

class _XCheckBoxGroupState extends State<XCheckBoxGroup> {
  String? get labelImg => widget.labelImg;
  Widget get labelWidget => widget.labelWidget;
  double? get labelImgSize => widget.labelImgSize;
  Function get callback => widget.callback;
  bool get value => widget.value;
  double? get horizontal => widget.horizontal;
  double? get vertical => widget.vertical;
  bool? get radio => widget.radio ?? false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (labelImg != null)
                XImage(
                  image: labelImg!,
                  width: labelImgSize,
                  height: labelImgSize,
                ).margin(right: 10.w),
              labelWidget,
            ],
          ),
          widget.child,
        ],
      ).padding(vertical: vertical, horizontal: horizontal),
      onTap: () => callback.call(radio ?? !value),
    );
  }
}
