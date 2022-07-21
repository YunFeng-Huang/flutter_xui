// ignore: must_be_immutable
import 'package:flutter/material.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XInput extends StatelessWidget {
  String? _label;
  Widget? _labelWidget;
  double? _labelWidth;
  TextStyle? _labelStyle;
  String? _hintText;
  TextStyle? _hintStyle;
  TextInputType? _keyboardType;
  late TextEditingController _controller;
  TextAlign? _textAlign;
  bool? _enabled;
  EdgeInsetsGeometry? _contentPadding;
  Color? _border;
  Color? _fillColor;
  ValueChanged<String>? _onChanged;
  double? _radius;
  Alignment? _labelAlign;
  bool? _obscureText;
  bool? _row;
  bool? _expands;
  TextStyle? _style;
  int? _maxLines;
  int? _maxLength;
  int? _hintMaxLines;
  late bool _autofocus;
  TextSelectionControls? _selectionControls;
  FocusNode? _focusNode = new FocusNode();
  XInput({
    row = true,
    label,
    labelWidget,
    labelAlign,
    labelWidth,
    labelStyle,
    padding,
    radius,
    hintText,
    hintStyle,
    keyboardType,
    controller,
    obscureText,
    validator,
    textAlign,
    border,
    onChanged,
    contentPadding,
    required,
    enabled,
    style,
    maxLines,
    autofocus,
    maxLength,
    focusNode,
    selectionControls,
    fillColor,
    hintMaxLines,
    expands,
  }) {
    _row = row ?? false;
    _focusNode = focusNode;
    _label = label;
    _labelWidget = labelWidget;
    _labelAlign = labelAlign ?? Alignment.centerLeft;
    _labelWidth = _row! ? (labelWidth ?? 120.w) : null;
    _labelStyle = labelStyle;
    _hintText = hintText;
    _hintStyle = hintStyle;
    _keyboardType = keyboardType;
    _controller = controller;
    _onChanged = onChanged;
    _textAlign = textAlign;
    _border = border;
    _contentPadding =
        contentPadding ?? EdgeInsets.only(top: 10.w, bottom: 10.w);
    _enabled = enabled;
    _radius = radius ?? 10.w;
    _obscureText = obscureText;
    _style = style;
    _maxLines = maxLines;
    _fillColor = fillColor;
    _autofocus = autofocus ?? false;
    _maxLength = maxLength;
    _selectionControls = selectionControls;
    _hintMaxLines = hintMaxLines;
    _expands = expands ?? false;
  }
  @override
  Widget build(BuildContext context) {
    // FocusNode _focusNode = new FocusNode();
    // _focusNode.addListener(() {
    //   print(1123123);
    //   if (!_focusNode.hasFocus && isNotNull(_validator)) {
    //     // var str = formCheck(_validator, _controller?.text.toString(), _required);
    //     // if (isNotNull(str)) {
    //     //   showToast(str);
    //     // }
    //   }
    // });
    // ignore: non_constant_identifier_names
    _LabelWidget() {
      return Container(
        alignment: _labelAlign,
        width: _labelWidth,
        child: _labelWidget ??
            (_label == null
                ? null
                : Text(
                    _label!,
                    style: _labelStyle,
                  )),
      );
    }

    // ignore: non_constant_identifier_names
    _InputWidget() {
      return TextField(
        expands: _expands ?? false,
        cursorColor: themeColor.primary,
        autofocus: _autofocus,
        maxLines: _maxLines,
        obscureText: _obscureText ?? false,
        focusNode: _focusNode,
        keyboardType: _keyboardType,
        controller: _controller,
        textAlign: _textAlign ?? TextAlign.start,
        enabled: _enabled ?? true,
        style: _style,
        maxLength: _maxLength,
        onChanged: _onChanged,
        decoration: InputDecoration(
          isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
          contentPadding: _contentPadding,
          fillColor: _fillColor ?? Colors.white,
          filled: true,
          hintText: _hintText,
          hintStyle: _hintStyle,
          hintMaxLines: _hintMaxLines,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        selectionControls: _selectionControls ?? XTextSelectionControls(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius ?? 0),
      child: Container(
          // padding:
          //     _padding ?? EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
          decoration: _border == null
              ? null
              : BoxDecoration(
                  borderRadius: _radius == null
                      ? null
                      : BorderRadius.all(Radius.circular(_radius!)),
                  border: Border.all(width: 1, color: _border ?? Colors.white),
                  color: Colors.red),
          child: _row!
              ? Row(
                  children: [
                    _LabelWidget(),
                    Expanded(
                      child: _InputWidget(),
                    ),
                  ],
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_LabelWidget(), _InputWidget()],
                )),
    );
  }
}
