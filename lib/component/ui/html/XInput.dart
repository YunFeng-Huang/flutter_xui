// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../index.dart';

// ignore: must_be_immutable
class XInput extends StatelessWidget {
  Key? key;
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
  bool? _readOnly;
  TextStyle? _style;
  int? _maxLines;
  int? _maxLength;
  int? _hintMaxLines;

  late bool _autofocus;
  TextSelectionControls? _selectionControls;
  FocusNode? _focusNode = new FocusNode();
  String? _counterText;
  Widget? _suffixIcon;
  Widget? _prefixIcon;
  List<TextInputFormatter>? _inputFormatters;
  XInput({
    Key? key,
    row,
    label,
    readOnly,
    inputFormatters,
    labelWidget,
    labelAlign,
    labelWidth = 0.0,
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
    counterText,
    suffixIcon,
    prefixIcon,
    showClose,
    eyeChange,
  }) {
    _inputFormatters = inputFormatters;

    _prefixIcon = prefixIcon;
    _counterText = counterText;
    _readOnly = readOnly;
    _row = row ?? false;
    _focusNode = focusNode;
    _label = label;
    _labelWidget = labelWidget;
    _labelAlign = labelAlign ?? Alignment.centerLeft;
    _labelWidth = _row! ? (labelWidth ?? 0.w) : null;
    _labelStyle = labelStyle;
    _hintText = hintText;
    _hintStyle = hintStyle;
    _keyboardType = keyboardType;
    _controller = controller;

    _textAlign = textAlign;
    _border = border;
    _contentPadding =
        contentPadding ?? EdgeInsets.only(top: 10.w, bottom: 10.w);
    _enabled = enabled;
    _radius = radius ?? 10.w;
    _obscureText = obscureText;
    _style = style;
    _maxLines = obscureText ?? false ? 1 : maxLines;
    _fillColor = fillColor;
    _autofocus = autofocus ?? false;

    _selectionControls = selectionControls;
    _hintMaxLines = hintMaxLines;
    _expands = expands ?? false;

    ///密码眼睛
    if (eyeChange != null) {
      _suffixIcon = GestureDetector(
        onLongPressStart: (details) {
          eyeChange?.call(false);
        },
        onLongPressDown: (v) {
          eyeChange?.call(false);
        },
        onTap: () {
          eyeChange?.call(true);
        },
        onLongPressUp: () {
          eyeChange?.call(true);
        },
        onLongPressEnd: (details) {
          eyeChange?.call(true);
        },
        child: _obscureText ?? false
            ? const Icon(Icons.visibility_off_outlined,size: 22,)
            : const Icon(Icons.visibility_outlined,size: 22),
      );
      //输入框清空
    } else if (showClose ?? false) {
      _suffixIcon = controller.text.length > 0
          ? GestureDetector(
              onTap: () {
                controller.text = '';
                onChanged?.call('');
              },
              child: Icon(
                Icons.close_outlined,
                size: 38.w,
              ),
            )
          : null;
    } else {
      _suffixIcon = suffixIcon;
    }

    _onChanged = (v) {
      if (maxLength != null && v.length > maxLength) {
        controller.text = controller.text.substring(0, maxLength);
        controller.selection =
            TextSelection.fromPosition(TextPosition(offset: maxLength ?? 0));
      }
      onChanged?.call(v);
    };
  }
  @override
  Widget build(BuildContext context) {
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
        key: key,
        inputFormatters: _inputFormatters,
        expands: _expands ?? false,
        cursorColor: themeColor.ffFF4300,
        autofocus: _autofocus,
        maxLines: _maxLines,
        obscureText: _obscureText ?? false,
        focusNode: _focusNode,
        keyboardType: _keyboardType,
        controller: _controller,
        textAlign: _textAlign ?? TextAlign.start,
        enabled: _enabled ?? true,
        style: _style,
        readOnly: _readOnly ?? false,
        maxLength: _maxLength,
        onChanged: _onChanged,
        decoration: InputDecoration(
          counterText: _counterText,
          suffixIcon: _suffixIcon,
          isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
          contentPadding: _contentPadding,
          fillColor: _fillColor ?? Colors.white,
          filled: true,
          hintText: _hintText,
          hintStyle: _hintStyle,
          hintMaxLines: _hintMaxLines,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: _prefixIcon,
        ),
        selectionControls: _selectionControls,
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

class MyNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  ///允许的小数位数，-1代表不限制位数
  int digit;
  MyNumberTextInputFormatter({this.digit = -1});
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value == "-") {
      value = "-";
      selectionIndex++;
    } else if (value != "" &&
            value != defaultDouble.toString() &&
            strToFloat(value, defaultDouble) == defaultDouble ||
        getValueDigit(value) > digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
