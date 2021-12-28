// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/js/formCheck.dart';
import 'package:xui/compontent/js/index.dart';
import '../../index.dart';
import '../css.dart';
import '../my_toast.dart';

// ignore: must_be_immutable
class XInput extends StatelessWidget {
  String? _label;
  Widget? _labelWidget;
  double? _labelWidth;
  TextStyle? _labelStyle;
  String? _hintText;
  TextStyle? _hintStyle;
  TextInputType? _keyboardType;
  TextEditingController? _controller;
  TextAlign? _textAlign;
  bool? _enabled;
  EdgeInsetsGeometry? _contentPadding;
  Color? _border;
  ValueChanged<String>? _onChanged;
  FormFieldSetter<String>? _onSaved;
  late FormKeyEnum _validator;
  bool? _required;
  double? _radius;
  EdgeInsetsGeometry? _padding;
  Alignment? _labelAlign;
  bool? _obscureText;
  bool? _row;
  XInput({row = true,label, labelWidget, labelAlign, labelWidth, labelStyle, padding, radius, hintText, hintStyle, keyboardType, controller, obscureText, validator, textAlign, border, onChanged, contentPadding, required, enabled, }) {
    _row = row ?? false;
    _label = label;
    _padding = padding;
    _labelWidget = labelWidget;
    _labelAlign = labelAlign ?? Alignment.centerLeft;
    _labelWidth =_row!? (labelWidth ?? 120.w):null;
    _labelStyle = labelStyle;
    _hintText = hintText;
    _hintStyle = hintStyle;
    _keyboardType = keyboardType;
    _controller = controller;
    _onChanged = onChanged;
// _onSaved = onSaved;
    _validator = validator;
    _textAlign = textAlign;
    _border = border;
    _contentPadding = contentPadding ??  EdgeInsets.only(top: 10.w, bottom: 10.w);
    _required = required ?? false;
    _enabled = enabled;
    _radius = radius ?? 10.w;
    _obscureText = obscureText;
  }
  @override
  Widget build(BuildContext context) {
    // FocusNode _focusNode = new FocusNode();
    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus && isNotNull(_validator)) {
    //     var str = formCheck(_validator, _controller?.text.toString(), _required);
    //     if (isNotNull(str)) {
    //       showToast(str);
    //     }
    //   }
    // });
    // ignore: non_constant_identifier_names
    _LabelWidget(){
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
    _InputWidget(){
      return TextFormField(
                obscureText: _obscureText ?? false,
                // focusNode: _focusNode,
                keyboardType: _keyboardType,
                controller: _controller,
                textAlign: _textAlign ?? TextAlign.start,
                enabled: _enabled ?? true,
                // style: font(12, color: '#3E3E3E'),
                onChanged: _onChanged,
                decoration: InputDecoration(
                  isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                  contentPadding: _contentPadding,
                  hintText: _hintText,
                  hintStyle: _hintStyle,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onSaved: (v) => formCheck(_validator, v, _required),
                // validator: (value) {
                //   print(value);
                //   print('validator');
                //   var str = formCheck(_validator, _controller?.text.toString(), _required);
                //   return str;
                // },
              );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius ?? 0),
      child: Container(
        padding: _padding ?? EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
        decoration: _border == null
            ? null
            : BoxDecoration(
                borderRadius: _radius == null ? null : BorderRadius.all(Radius.circular(_radius!)),
                border: Border.all(width: 1, color: _border ?? Colors.white),
              ),
        child:_row!? Row(
          children: [
            _LabelWidget(),
            Expanded(
              child: _InputWidget(),
            ),
          ],
        ):Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          _LabelWidget(),
          _InputWidget()
        ],)
      ),
    );
  }
}

// // ignore: must_be_immutable
// class XFormItem extends StatelessWidget implements XInput {
//   String text;
//   XFormItem(
//     this.text,
//     label,
//     labelWidth,
//     labelStyle,
//     hintText,
//     keyboardType,
//     controller,
//     onSaved,
//     validator,
//     textAlign,
//     border,
//     contentPadding,
//     required,
//     enabled,
//   ) {
//     _label = label;
//     _labelWidth = labelWidth;
//     _labelStyle = labelStyle;
//     _hintText = hintText;
//     _keyboardType = keyboardType;
//     _controller = controller;
//     _onSaved = onSaved;
//     _validator = validator;
//     _textAlign = textAlign;
//     _border = border;
//     _contentPadding = contentPadding;
//     _required = required ?? false;
//     _enabled = enabled;
//   }
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     nameController.text = text;
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'title',
//             style: font(28, color: '#3E3E3E'),
//           ),
//           Container(
//             height: 88.w,
//             child: XInput(
//               label: _label,
//               labelWidth: _labelWidth,
//               labelStyle: _labelStyle,
//               hintText: _hintText,
//               keyboardType: _keyboardType,
//               controller: _controller,
//               // onSaved: _onSaved,
//               // validator: _validator,
//               textAlign: _textAlign,
//               border: _border,
//               contentPadding: _contentPadding,
//               // required: _required,
//               enabled: _enabled,
//             ),
//             width: 300.w,
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   InputBorder? _border;
//
//   @override
//   EdgeInsetsGeometry? _contentPadding;
//
//   @override
//   TextEditingController? _controller;
//
//   @override
//   bool? _enabled;
//
//   @override
//   String? _hintText;
//
//   @override
//   TextInputType? _keyboardType;
//
//   @override
//   String? _label;
//
//   @override
//   double? _labelWidth;
//
//   @override
//   ValueChanged<String>? _onChanged;
//
//   @override
//   FormFieldSetter<String>? _onSaved;
//
//   @override
//   bool? _required;
//
//   @override
//   TextAlign? _textAlign;
//
//   @override
//   String? _validator;
//
//   @override
//   TextStyle? _labelStyle;
//
//   @override
//   TextStyle? _hintStyle;
// }
