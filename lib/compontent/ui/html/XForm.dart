import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../css.dart';
import '../../index.dart';
import '../my_loading.dart';

// ignore: must_be_immutable
class XForm extends StatelessWidget {
  List list;
  bool inline;
  var child;
  XForm({required this.list, required this.child, this.inline = false});
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (list == null) return Loading();
    List<Widget> _list = List.generate(
      list.length,
      (index) => child(list[index], inline),
    );
    return inline
        ? Wrap(
            children: _list,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _list,
          );
  }
}

// ignore: must_be_immutable
class XFormItem extends StatelessWidget {
  String? label;
  dynamic value;
  TextStyle? labelStyle;
  TextStyle? valueStyle;
  double? labelWidth;
  double? valueWidth;
  double? height;
  CrossAxisAlignment? align;
  Alignment? labelAlign;
  Alignment? valueAlign;
  Widget? child;
  Widget? custom;
  bool? inline;
  bool? hidden;
  XFormItem({this.child, this.hidden, this.valueWidth, this.valueStyle, this.valueAlign, this.align, this.custom, this.value, this.height, this.label, this.labelStyle, this.labelWidth, this.labelAlign, this.inline});

  @override
  Widget build(BuildContext context) {
    Widget _leftLable = label == null
        ? Container()
        : Text(
            '$label :',
            style: labelStyle ?? font(20.w, colorA: Color.fromRGBO(0, 0, 0, 0.85), weight: FontWeight.w400),
          ).background(width: labelWidth ?? 150.w, alignment: labelAlign ?? Alignment.centerRight, height: height).margin(right: 10.w);
    Widget _rightInput = (child ??
            Text(
              '$value',
              style: valueStyle ?? font(20.w, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ))
        .background(width: valueWidth, alignment: valueAlign, height: height)
        .margin(left: 10.w);
    Widget _custom = custom ?? Container();

    return (isNotNull(hidden) && hidden!
        ? SizedBox(width: 0, height: 0)
        : isNotNull(custom)
            ? _custom
            : (inline ?? false
                ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      _leftLable,
                      _rightInput,
                    ],
                  )
                : Row(
                    crossAxisAlignment: align ?? CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _leftLable,
                      Expanded(child: _rightInput),
                    ],
                  )));
  }
}
